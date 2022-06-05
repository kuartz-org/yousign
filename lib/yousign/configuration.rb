# frozen_string_literal: true

##
# `api_key` can be found in https://staging-app.yousign.com/admin/apikeys for staging.
#
# `base_url` depends on the desired environment.
# Available environments:
# Staging:    https://staging-api.yousign.com
# Production: https://api.yousign.com
#
# See https://dev.yousign.com for more information.
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
