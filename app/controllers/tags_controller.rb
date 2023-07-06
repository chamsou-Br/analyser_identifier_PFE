# frozen_string_literal: true
require 'httparty'

class TagsController < ApplicationController
  include TagsHelper

  @mstags_url = "http://localhost:3000/"

  def set_connexion
    session_id = 'c7a7f96de8db07a401666ee20513f93b'
    current_customer_endpoint = 'get_current_customer'
    api_url = "http://localhost:3000/#{current_customer_endpoint}"

    headers = {
      'Cookie' => "_qualipso_session=#{session_id}"
    }
    customer = HTTParty.get(api_url, headers: headers)
    # pp @current_customer['id']
    @actual_customer = Customer.find(1)
    return @actual_customer
  end  


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

  ## MAZEL
  # def show
  #   @tag = set_connexion.tags.find_by_id(params[:id])
  #   @graphs = @tag.graphs.select { |g| GraphPolicy.viewable?(current_user, g) && !g.in_archives? }
  #   @documents = @tag.documents.select { |d| DocumentPolicy.viewable?(current_user, d) && !d.in_archives? }
  #   respond_to do |format|
  #     format.html {}
  #   end
  # end

  def new
    @tag = Tag.new
    respond_to do |format|
      format.html
      format.json { render json: @tag }
    end 
    head :ok
  end

  def create
    @tag = Tag.create(label: params[:tag][:label], customer_id: set_connexion.id)
    if @tag.save
      flash[:success] = I18n.t("controllers.tags.successes.create")
    else
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
    session_id = 'c7a7f96de8db07a401666ee20513f93b'
    headers = {
      'Cookie' => "_qualipso_session=#{session_id}"
    }
  
    response = HTTParty.post(tagging_service_url, headers: headers, body: { tag_id: tag_id })
  
    if response.code == 200
      puts "successfully deleted"
    else
      puts "deletion failed"
    end
  end
end
