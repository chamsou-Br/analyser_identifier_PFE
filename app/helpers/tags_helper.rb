# frozen_string_literal: true

module TagsHelper
  include ApplicationHelper

  @@mstags_url = "http://localhost:3000/"
  @@session_id = '0a9ed383dd308fa0e2b60bd7488df91b'


  def tags_labels_for_js(tags)
    tags = Tag.all if tags.nil?
    i = 0
    # rubocop:disable Style/StringConcatenation
    tags.reduce("[") do |res, tag|
      i += 1
      tag_label = render_for_html(tag.label)
      res += "{id: #{tag.id}, text: \"#{tag_label}\"}"
      res += "," unless i >= tags.size
      res
    end.html_safe + "]"
    # rubocop:enable Style/StringConcatenation
  end

  def tags_labels_for_html(object)
    res = ""
    tags = object.tags
    i = 0
    tags.each do |tag|
      i += 1
      res += tag.label.to_s
      res += "," unless i >= tags.size
    end
    res
  end

  def consolidate(tags_labels)
    # tags_labels a la forme "toto,tata", il faut rendre les ids sous la forme "5,12"
    # si les tags n'existent pas, il faut les créer
    res = []
    unless tags_labels.nil?
      tags_labels_array = tags_labels.split(",")
      tags_labels_array.each do |label|
        tag = Tag.find_or_create_by(label: label)
        res << tag
      end
    end
    logger.debug "tags_labels : #{tags_labels} consolidated to res : #{res}"
    res
  end

  def tag_label(tag)
    if tag.respond_to?(:label)
      tag.label
    elsif tag.respond_to?(:title)
      tag.title
    elsif tag.respond_to?(:name)
      tag.name
    end
  end

  def get_child_image_url(child_id, size, type)
    api_url = "http://localhost:3000/child_images/#{child_id}?size=#{size}&type=#{type}"
    headers = {
      'Cookie' => "_qualipso_session=#{get_token}"
    }
    response = HTTParty.get(api_url, headers: headers)
    if response.success?
      json = JSON.parse(response.body)
      # json['image_url']

      image_url = json['image_url'].match(/<img[^>]*src="([^"]+)"/i)&.captures&.first
      image_url = image_url.gsub('/images/', '/assets/')
      return image_url
    else
      puts 'not found'
    end
  end

  date_string = "10-07-2023"

  def parse_timer(date_string)
    date = DateTime.iso8601(date_string)
    formatted_date = date.strftime("%e-%m-%Y")
    return formatted_date
  end

  def get_child_author_name(child_id, type)
    api_url = "#{@@mstags_url}get_entity_author/#{child_id}?type=#{type}"
    puts api_url
    headers = {
      'Cookie' => "_qualipso_session=#{get_token}"
    }
    response = HTTParty.get(api_url, headers: headers)

    if response.success?
      json = JSON.parse(response.body)
      json['author_name']
    else
      puts 'not found'
    end
  end
end
