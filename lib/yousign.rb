# frozen_string_literal: true

require_relative "yousign/version"
require_relative "yousign/configuration"

module Yousign
  class Error < StandardError; end

  def self.configure
    yield Configuration
  end

  def self.config
    Configuration
  end
end

require "yousign/utilities/api_request"
require "yousign/models/api_resource"
require "yousign/models/file"
require "yousign/models/member"
require "yousign/models/file_object"
require "yousign/models/procedure"
