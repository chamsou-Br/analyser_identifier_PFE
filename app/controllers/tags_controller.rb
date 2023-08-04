# frozen_string_literal: true
require 'httparty'

class TagsController < ApplicationController
  include TagsHelper

  MSQUALIPSO_BASE_URL = "http://localhost:3000".freeze

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
    get_graphs_docs_url = "#{MSQUALIPSO_BASE_URL}/tags/#{params[:id]}/get_graphs_docs"
    headers = {
      'Cookie' => "_qualipso_session=#{get_token}"
    }

    @tag = set_connexion.tags.find_by_id(params[:id])

    # Retrieve needed data to display tag details
    response = HTTParty.get(get_graphs_docs_url, headers: headers)
    @graphs = response.parsed_response['graphs']
    @documents = response.parsed_response['documents']
    @roles = response.parsed_response['roles']
    @resources = response.parsed_response['resources']

    html_content = render_to_string('show', layout: true)
    render json: { html_content: html_content, tag: @tag }
  end

  def new
    @tag = Tag.new
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
      redirect_to "#{MSQUALIPSO_BASE_URL}/tags/#{params[:id]}"
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
    else
      flash[:error] = I18n.t("controllers.tags.errors.delete")
    end
    if set_connexion.tags.empty?
      redirect_to "#{MSQUALIPSO_BASE_URL}/tags"
    else
      redirect_to "#{MSQUALIPSO_BASE_URL}/tags/#{set_connexion.tags.order(label: :asc).first.id}"
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
