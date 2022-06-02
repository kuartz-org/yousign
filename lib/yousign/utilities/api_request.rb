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
      @logger = Logger.new(STDOUT)
      logger.formatter = proc do |severity, datetime, progname, msg|
        "\e[1m\e[35mYousign - #{datetime} - #{msg}\n\e[0m"
      end

      @end_point = end_point
    end

    def get
      url = URI("#{Yousign.config.base_url}#{end_point}")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url, request_headers)

      logger.info "GET request to #{url.to_s}}"

      response = https.request(request)

      parsed_response = JSON.parse(response.body).tap do |parsed_response|
        logger.info "Response [#{response.code}]:\n#{parsed_response}"
      end

      return parsed_response unless parsed_response.is_a? Hash

      parsed_response.deep_transform_keys! do |key|
        underscore(key).to_sym
      end
    end

    def post(body)
      response = request(body)

      parsed_response = JSON.parse(response.body).tap do |parsed_response|
        logger.info "Response [#{response.code}]:\n#{parsed_response}"
      end

      parsed_response.deep_transform_keys! do |key|
        underscore(key).to_sym
      end
    end

    private

    attr_reader :end_point, :logger

    def request_headers
      {
        "Authorization" => "Bearer #{Yousign.config.api_key}",
        "Content-Type" => "application/json"
      }.freeze
    end

    def request(body)
      url = URI("#{Yousign.config.base_url}/#{end_point}")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(url, request_headers)

      body.deep_transform_keys! do |key|
       camelize(key, false)
      end

      request.body = body.to_json

      logger.info "POST request to #{url.to_s}\nbody:\n#{body}"

      https.request(request)
    end
  end
end
