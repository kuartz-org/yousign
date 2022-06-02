# frozen_string_literal: true

module Yousign
  class FileObject < APIResource
    attr_reader :id,
                :field_name,
                :file,
                :mention,
                :mention2,
                :page,
                :parent,
                :position,
                :reason,
                :type
  end
end
