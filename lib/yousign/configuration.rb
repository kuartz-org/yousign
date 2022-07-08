# frozen_string_literal: true

module Yousign
  ##
  # `api_key` can be found in https://staging-app.yousign.com/admin/apikeys for staging.
  #
  # `base_url` depends on the desired environment.
  # Available environments:
  # Staging:    https://staging-api.yousign.com (default)
  # Production: https://api.yousign.com
  #
  # `webapp_url` depends on the desired environment.
  # Available environments:
  # Staging:    https://staging-app.yousign.com (default)
  # Production: https://webapp.yousign.com
  #
  # See https://dev.yousign.com for more information.
  module Configuration
    class << self
      attr_accessor :api_key, :base_url, :webapp_url
    end

    DEFAULT = {
      base_url: "https://staging-api.yousign.com",
      webapp_url: "https://staging-webapp.yousign.com"
    }.freeze

    DEFAULT.each do |param, default_value|
      send("#{param}=", default_value)
    end
  end
end
