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

    class << self
      def create(api_request_body)
        new APIRequest.post("/procedures", api_request_body)
      end

      def find(id)
        new APIRequest.get(id)
      end
    end

    def members
      @members.map { |member| Member.new(member) }
    end

    def files
      @files.map { |file| File.new(file) }
    end
  end
end
