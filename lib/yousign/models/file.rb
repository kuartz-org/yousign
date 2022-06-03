# frozen_string_literal: true

module Yousign
  class File < APIResource
    attr_reader :id,
                :name,
                :type,
                :content_type,
                :description,
                :sha256,
                :metadata,
                :workspace,
                :creator,
                :protected,
                :position,
                :parent,
                :fields_compatible,
                :company

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
