# frozen_string_literal: true

require "uri"
require "net/http"
require "base64"
require "json"
require "active_support"
require "active_support/inflector/inflections"
require "active_support/core_ext/hash"

module Yousign
  class APIRequest
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
      @end_point = end_point
      initialize_logger
    end

    def get
      send_request do |url|
        logger.info "GET request to #{url.to_s}}"
        Net::HTTP::Get.new(url, request_headers)
      end
    end

    def post(body)
      body.deep_transform_keys! { |key| camelize(key, false) }

      send_request do |url|
        logger.info "POST request to #{url.to_s}}"
        Net::HTTP::Post.new(url, request_headers).tap { |request| request.body = body.to_json }
      end
    end

    private

    attr_reader :end_point, :logger

    def initialize_logger
      @logger = Logger.new(STDOUT)
      logger.formatter = proc do |_severity, datetime, _progname, msg|
        "\e[1m\e[35mYousign - #{datetime} - #{msg}\n\e[0m"
      end
    end

    def request_headers
      {
        "Authorization" => "Bearer #{Yousign.config.api_key}",
        "Content-Type" => "application/json"
      }.freeze
    end

    def send_request
      url = URI("#{Yousign.config.base_url}#{end_point}")
      https_client = Net::HTTP.new(url.host, url.port).tap { |client| client.use_ssl = true }
      response = https_client.request(yield(url))
      parsed_response = JSON.parse(response.body)

      return parsed_response unless parsed_response.is_a? Hash

      parsed_response.deep_transform_keys! { |key| underscore(key).to_sym }
    end
  end
end
