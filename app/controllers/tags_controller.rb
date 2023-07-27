# frozen_string_literal: true
require 'httparty'

class TagsController < ApplicationController
  include TagsHelper

  @@mstags_url = "http://localhost:3000/"

  def testing_c
    # Connect to the same Redis database as the other microservice
    redis_config = {
      url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'),
      namespace: "pyx4_#{Rails.env}"
    }.freeze
    redis = Redis.new(redis_config) # Establish the connection to Redis
    session_data = redis.keys("qualipso_#{Rails.env}:session:*") # Retrieve the key

    # Assuming user_session_data contains the user session information, parse it to get the token
    # You might need to adapt this part based on how your session data is structured
    # user_session_hash = JSON.parse(user_session_data)
    # user_session_token = user_session_hash['qualipso_#{Rails.env}:session:'] # Replace 'your_token_key' with the key where the token is stored in the session data

    # Now you have the user session token and can use it as needed in this microservice
    render json: session_data
  end



  # This method is more fast to use the ms-tags
  # TODO: replace the token manually and use the set_connexion
  # @@session_id = "put the token manually"
  # def set_connexion
  #   current_customer_endpoint = 'get_current_customer'
  #   api_url = "http://localhost:3000/#{current_customer_endpoint}"

  #   headers = {
  #     'Cookie' => "_qualipso_session=#{@@session_id}"
  #   }
  #   customer = HTTParty.get(api_url, headers: headers, timeout: 40)
  #   puts customer['id']
  #   @actual_customer = Customer.find(customer['id'])
  #   return @actual_customer
  # end


  def index
    query = params[:q]
    respond_to do |format|
      format.json do
        render json: set_connexion.tags.autocompleter(query)
      end
      format.html do
        tag = set_connexion.tags.order(label: :asc).first
        if tag.nil?
          render
        else
          redirect_to tag_path(tag)
        end
      end
    end
  end

  def show
    get_graphs_docs_url = "#{@@mstags_url}tags/#{params[:id]}/get_graphs_docs"
    headers = {
      'Cookie' => "_qualipso_session=#{get_token}"
    }

    @tag = set_connexion.tags.find_by_id(params[:id]) # get tag

    # get tags
    response = HTTParty.get(get_graphs_docs_url, headers: headers)

    @graphs = response.parsed_response['graphs']
    @documents = response.parsed_response['documents']
    @roles = response.parsed_response['roles']
    @resources = response.parsed_response['resources']

    Timeout.timeout(20) do  # Set the timeout value (in seconds) to 5 seconds
      html_content = render_to_string('show', layout: true)
      render json: { html_content: html_content, tag: @tag }
    end
  end

  def test_get_graph
    get_graphs_docs_url = "#{@@mstags_url}tags/#{params[:id]}/get_graphs_docs"
    headers = {
      'Cookie' => "_qualipso_session=#{get_token}"
    }

    response = HTTParty.get(get_graphs_docs_url, headers: headers)
    @graphs = response.parsed_response['graphs']
    @documents = response.parsed_response['documents']
    @roles = response.parsed_response['roles']


    render json: @roles
  end


  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(label: params[:tag][:label], customer_id: set_connexion.id)
    if @tag.save
      flash[:success] = I18n.t("controllers.tags.successes.create")
      # redirect_to "http://localhost:3000/tags/#{@tag.id}"
    else
      puts "NOT GOOD"
      flash[:error] = I18n.t("controllers.tags.errors.create")
      respond_to do |format|
        format.js { render :error_create, status: :unprocessable_entity }
      end
    end
  end

  def confirm_rename
    @tag = set_connexion.tags.find(params[:id])
  end

  def rename
    @tag = set_connexion.tags.find(params[:id])
    @tag.label = params[:label]
    if @tag.save
      flash.now[:success] = I18n.t("controllers.tags.successes.rename")
      redirect_to "http://localhost:3000/tags/#{params[:id]}"
    else
      fill_errors_hash(I18n.t("controllers.tags.errors.rename"), @tag)
    end
  end

  def confirm_delete; end

  def delete
    @tag = set_connexion.tags.find(params[:id])
    if @tag.destroy
      flash[:success] = I18n.t("controllers.tags.successes.delete")
      notify_tagging_service(params[:id])
      puts "destroyed successfully"
    else
      flash[:error] = I18n.t("controllers.tags.errors.delete")
      puts "destruction failed"
    end
    if set_connexion.tags.empty?
      redirect_to "http://localhost:3000/tags"
    else
      redirect_to "http://localhost:3000/tags/#{set_connexion.tags.order(label: :asc).first.id}"
    end
  end

  # New api calls - this is not working but it is okay
  # This is for handling the tagging update index method
  def notify_tagging_service(tag_id)
    tagging_service_url = 'http://localhost:3000/taggings/destroy'
    headers = {
      'Cookie' => "_qualipso_session=#{get_token}"
    }

    response = HTTParty.post(tagging_service_url, headers: headers, body: { tag_id: tag_id })

    if response.code == 200
      puts "successfully deleted"
    else
      puts "deletion failed"
    end
  end
end
