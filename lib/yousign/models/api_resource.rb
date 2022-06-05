# frozen_string_literal: true

require "time"

module Yousign
  ##
  # Parent and abstract class for resources to be found at https://dev.yousign.com
  class APIResource
    TIME_ATTRIBUTES = %i[created_at updated_at finished_at expires_at].freeze

    def self.find(id)
      new APIRequest.get(id)
    end

    def self.create_collection(collection_attributes)
      collection_attributes.map { |member_attributes| new(member_attributes) }
    end

    def initialize(attributes = {})
      attributes.compact.each do |key, value|
        value = Time.parse(value) if TIME_ATTRIBUTES.include? key
        instance_variable_set("@#{key}", transformed_value(key, value))
      end
    end

    private

    def transformed_value(key, value)
      case key.to_sym
      when :members then Member.create_collection(value)
      when :files then File.create_collection(value)
      when :file_objects then FileObject.create_collection(value)
      else
        value
      end
    end
  end
end
