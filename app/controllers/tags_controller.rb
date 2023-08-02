# frozen_string_literal: true
require 'httparty'

class TagsController < ApplicationController
  include TagsHelper

  MSQUALIPSO_BASE_URL = "http://localhost:3000".freeze

  # This method is more fast to use the ms-tags but token should be added manually
  # TODO: replace the token manually and use the get_current_customer
  # @@session_id = "put the token manually"
  # def get_current_customer
  #   current_customer_endpoint = 'get_current_customer'
  #   api_url = "#{MSQUALIPSO_BASE_URL}/#{current_customer_endpoint}"

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
        render json: get_current_customer.tags.autocompleter(query)
      end
      format.html do
        tag = get_current_customer.tags.order(label: :asc).first
        if tag.nil?
          render
        else
          redirect_to tag_path(tag)
        end
      end
    end
  end

  def show
    get_graphs_docs_url = "#{MSQUALIPSO_BASE_URL}/tags/#{params[:id]}/get_graphs_docs"
    headers = {
      'Cookie' => "_qualipso_session=#{get_token}"
    }

    @tag = get_current_customer.tags.find_by_id(params[:id]) # get tag

    response = HTTParty.get(get_graphs_docs_url, headers: headers)
    @graphs = response.parsed_response['graphs']
    @documents = response.parsed_response['documents']
    @roles = response.parsed_response['roles']
    @resources = response.parsed_response['resources']

    # Render HTML and send it to the monolithic to be displayed
    html_content = render_to_string('show', layout: true)
    render json: { html_content: html_content, tag: @tag }
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(label: params[:tag][:label], customer_id: get_current_customer.id)
    if @tag.save
      flash[:success] = I18n.t("controllers.tags.successes.create")
      # redirect_to "#{MSQUALIPSO_BASE_URL}/tags/#{@tag.id}"
    else
      puts "NOT GOOD"
      flash[:error] = I18n.t("controllers.tags.errors.create")
      respond_to do |format|
        format.js { render :error_create, status: :unprocessable_entity }
      end
    end
  end

  def confirm_rename
    @tag = get_current_customer.tags.find(params[:id])
  end

  def rename
    @tag = get_current_customer.tags.find(params[:id])
    @tag.label = params[:label]
    if @tag.save
      flash.now[:success] = I18n.t("controllers.tags.successes.rename")
      redirect_to "#{MSQUALIPSO_BASE_URL}/tags/#{params[:id]}"
    else
      fill_errors_hash(I18n.t("controllers.tags.errors.rename"), @tag)
    end
  end

  def confirm_delete; end

  def delete
    @tag = get_current_customer.tags.find(params[:id])
    if @tag.destroy
      flash[:success] = I18n.t("controllers.tags.successes.delete")
      notify_tagging_service(params[:id])
      puts "destroyed successfully"
    else
      flash[:error] = I18n.t("controllers.tags.errors.delete")
      puts "destruction failed"
    end
    if get_current_customer.tags.empty?
      redirect_to "#{MSQUALIPSO_BASE_URL}/tags"
    else
      redirect_to "#{MSQUALIPSO_BASE_URL}/tags/#{get_current_customer.tags.order(label: :asc).first.id}"
    end
  end

  # New api calls - this is not working but it is okay
  # This is for handling the tagging update index method
  def notify_tagging_service(tag_id)
    tagging_service_url = "#{MSQUALIPSO_BASE_URL}/taggings/destroy"
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
