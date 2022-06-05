# frozen_string_literal: true

module Yousign
  ##
  # See https://dev.yousign.com/#0889a9c5-aa1e-4de0-9b35-4d6621b4eb20
  class File < APIResource
    attr_reader :id,
                :created_at,
                :updated_at,
                :company,
                :content_type,
                :creator,
                :description,
                :fields_compatible,
                :metadata,
                :name,
                :parent,
                :position,
                :protected,
                :sha256,
                :type,
                :workspace

    def self.upload(filename:, file:)
      new APIRequest.post("/files", { name: filename, content: Base64.strict_encode64(::File.read(file)) })
    end

    def file_objects
      @file_objects.map { |file_object| FileObject.new(file_object) }
    end

    def binary
      base64_encoded_file = APIRequest.get("#{id}/download")
      Base64.strict_decode64(base64_encoded_file)
    end
  end
end
