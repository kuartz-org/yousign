# frozen_string_literal: true

require "time"

module Yousign
  class APIResource
    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def created_at
      Time.parse(@created_at) if @created_at
    end

    def updated_at
      Time.parse(@updated_at) if @updated_at
    end

    def finished_at
      Time.parse(@finished_at) if @finished_at
    end

    def expires_at
      Time.parse(@expires_at) if @expires_at
    end
  end
end
