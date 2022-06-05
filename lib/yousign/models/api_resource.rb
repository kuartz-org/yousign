# frozen_string_literal: true

require "time"

module Yousign
  class APIResource
    TIME_ATTRIBUTES = %i[created_at updated_at finished_at expires_at].freeze

    def self.find(id)
      new APIRequest.get(id)
    end

    def initialize(attributes = {})
      attributes.each do |key, value|
        next if value.nil?

        value = Time.parse(value) if TIME_ATTRIBUTES.include? key
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
