# frozen_string_literal: true

module Yousign
  class FileObject
    attr_reader :file_id, :page, :position, :mentions

    def initialize(file_id:, page:, position:, mentions: [])
      @file_id = file_id
      @page = page
      @position = position
      @mentions = mentions
    end

    def to_hash
      hash = {
        file: file_id,
        page: page,
        position: position
      }

      mentions.each_with_index do |mention, index|
        if index.zero?
          hash[:mention] = mention
        else
          hash["mention#{index + 1}".to_sym] = mention
        end
      end

      hash
    end
  end
end
