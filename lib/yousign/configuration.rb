# frozen_string_literal: true

module Yousign
  module Configuration
    class << self
      attr_accessor :api_key, :base_url
    end

    DEFAULT = {
      base_url: "https://staging-api.yousign.com"
    }.freeze

    DEFAULT.each do |param, default_value|
      send("#{param}=", default_value)
    end
  end
end
