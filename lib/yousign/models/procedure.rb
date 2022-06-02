# frozen_string_literal: true

module Yousign
  class Procedure < APIResource
    attr_reader :id,
                :name,
                :description,
                :status,
                :creator,
                :creator_first_name,
                :creator_last_name,
                :workspace,
                :template,
                :ordered,
                :parent,
                :metadata,
                :config,
                :members

    def initialize(name:, description: "", members: [])
      super()
      @name = name
      @description = description
      @members = members
    end

    def create
      APIRequest.post("/procedures", to_hash)
    end

    # def finished_at
    # end

    # def expires_at
    # end

    def to_hash
      {
        name: name,
        description: description,
        members: members.map(&:to_hash)
      }
    end
  end
end
