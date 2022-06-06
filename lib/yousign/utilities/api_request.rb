# frozen_string_literal: true

require "uri"
require "net/http"
require "base64"
require "json"
require "active_support"
require "active_support/inflector/inflections"
require "active_support/core_ext/hash"

module Yousign
  ##
  # HTTP requests to Yousign API
  class APIRequest
    ##
    # Identify response errors from API as APIRequest::Failure
    class Failure < StandardError; end

    include ActiveSupport::Inflector

    class << self
      def post(end_point, body)
        new(end_point).post(body)
      end

      def get(end_point)
        new(end_point).get
      end
    end

    def initialize(end_point)
      @request_headers = {
        "Authorization" => "Bearer #{Yousign.config.api_key}",
        "Content-Type" => "application/json"
      }.freeze

      @end_point = end_point

      initialize_logger
    end

    def get
      send_request do
        logger.info "GET request to #{url}"
        Net::HTTP::Get.new(url, request_headers)
      end
    end

    def post(body)
      body.deep_transform_keys! { |key| camelize(key, false) }

      send_request do
        logger.info "POST request to #{url}"
        Net::HTTP::Post.new(url, request_headers).tap { |request| request.body = body.to_json }
      end
    end

    private

    attr_reader :end_point, :logger, :request_headers

    def initialize_logger
      @logger = Logger.new($stdout)
      logger.formatter = proc do |_severity, datetime, _progname, msg|
        "\e[1m\e[35mYousign - #{datetime} - #{msg}\n\e[0m"
      end
    end

    def send_request
      response = https_client.request(yield)

      parsed_response = JSON.parse(response.body)

      raise Failure, parsed_response["detail"] if parsed_response["detail"]

      return parsed_response unless parsed_response.is_a? Hash

      parsed_response.deep_transform_keys! { |key| underscore(key).to_sym }
    end

    def url
      @url ||= URI("#{Yousign.config.base_url}#{end_point}")
    end

    def https_client
      @https_client ||= Net::HTTP.new(url.host, url.port).tap { |client| client.use_ssl = true }
    end
  end
end
