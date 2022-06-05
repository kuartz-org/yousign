# frozen_string_literal: true

module Yousign
  class Procedure < APIResource
    attr_reader :id,
                :created_at,
                :updated_at,
                :finished_at,
                :expires_at,
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

    def self.create(api_request_body)
      new APIRequest.post("/procedures", api_request_body)
    end

    def members
      @members.map { |member| Member.new(member) }
    end

    def files
      @files.map { |file| File.new(file) }
    end
  end
end
