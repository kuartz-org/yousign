# frozen_string_literal: true

module Yousign
  ##
  # See https://dev.yousign.com/#218fcae4-41d1-44d2-87eb-6146a356af16
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
                :files,
                :members,
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
  end
end
