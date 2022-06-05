# frozen_string_literal: true

module Yousign
  ##
  # See https://dev.yousign.com/#76e83e1d-ba4e-4c57-98da-fbe6de48a2f2
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
