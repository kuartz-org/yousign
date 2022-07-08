# frozen_string_literal: true

require_relative "yousign/version"

##
# Ruby wrapper for Yousign API
module Yousign
  autoload :Configuration, "yousign/configuration"
  autoload :APIRequest, "yousign/utilities/api_request"
  autoload :APIResource, "yousign/models/api_resource"
  autoload :File, "yousign/models/file"
  autoload :Member, "yousign/models/member"
  autoload :FileObject, "yousign/models/file_object"
  autoload :Procedure, "yousign/models/procedure"

  def self.configure
    yield Configuration
  end

  def self.config
    Configuration
  end
end
