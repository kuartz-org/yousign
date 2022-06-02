# frozen_string_literal: true

module Yousign
  class Procedure < APIResource
    attr_reader :id,
                :config,
                :creator_first_name,
                :creator_last_name,
                :creator,
                :description,
                :metadata,
                :name,
                :ordered,
                :parent,
                :status,
                :template,
                :workspace

    def self.find(id)
      attributes = APIRequest.get(id)
      instance = new
      attributes.each do |key, value|
        instance.instance_variable_set("@#{key}", value)
      end
      instance
    end

    def initialize(api_request_body = {})
      super()
      @api_request_body = api_request_body
    end

    def create!
      attributes = APIRequest.post("/procedures", @api_request_body)

      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      self
    end

    def members
      @members.map { |member| Member.new(member) }
    end

    def files
      @files.map { |file| File.new(file) }
    end
  end
end
