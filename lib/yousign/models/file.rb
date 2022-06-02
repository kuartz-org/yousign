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
                :file_objects,
                :protected,
                :position,
                :parent,
                :fields_compatible,
                :company

    def initialize(filename:, file:)
      super()
      @filename = filename
      @content = ::File.read(file)
    end

    def upload!
      attributes = APIRequest.post("files", { name: filename, content: Base64.strict_encode64(content) })

      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      self
    end

    def created_at
      Time.parse(@created_at) if @created_at
    end

    def updated_at
      Time.parse(@updated_at) if @updated_at
    end

    def inspect
      "<##{self.class} #{filename} >"
    end

    private

    attr_reader :filename, :content
  end
end
