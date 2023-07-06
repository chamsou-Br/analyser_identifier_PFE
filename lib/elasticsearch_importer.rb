# frozen_string_literal: true

class ElasticsearchImporter
  # Array of classes whose attributes can be indexed for Elasticsearch
  INDEXABLE_CLASSES = [Group, User, Tag, Role, Resource, Graph, Document,
                       Directory, Customer, GraphImage, Event, Act, Audit,
                       Package, Risk].freeze

  # Deletes indices for a given array of classes.  If no array is provided,
  # defaults to `INDEXABLE_CLASSES`.
  #
  # @param klasses [Array<#__elasticsearch__>] Array of classes indexed by
  #   Elastic Search
  # @raise [NotImplementedError] if class has not been indexed by Elastic Search
  def self.delete_indexes(klasses = INDEXABLE_CLASSES)
    klasses.each do |klass|
      raise NotImplementedError unless klass.respond_to? :__elasticsearch__

      klass.__elasticsearch__.client.indices.delete index: klass.index_name
    rescue StandardError => e
      puts "Could not delete ES index for #{klass.name}"
      puts e.message
    end
  end

  # Invokes `import_to_es` on every class in the array provided, if said class
  # responds to said method.  If said class does not implement a `import_to_es`
  # method, raises `NotImplementedError`.
  # If no classes are provided, defaults to `INDEXABLE_CLASSES`
  #
  # @param klasses [Array<#import_to_es>] An array of classes implementing
  #   `import_to_es`
  # @raise [NotImplementedError]
  def self.import(klasses = INDEXABLE_CLASSES)
    klasses.each do |klass|
      raise NotImplementedError unless klass.respond_to? :import_to_es

      klass.send(:import_to_es)
    end
  end
end
