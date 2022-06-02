# frozen_string_literal: true

require "time"

module Yousign
  class APIResource
    def created_at
      Time.parse(@created_at) if @created_at
    end

    def updated_at
      Time.parse(@updated_at) if @updated_at
    end
  end
end
