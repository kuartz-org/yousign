# frozen_string_literal: true

module Yousign
  class APIRequest
    extend Inflector

    class << self
      def post(end_point, body)
        response = request(end_point, body)
        parsed_response = JSON.parse(response.body)

        parsed_response.transform_keys! do |key|
          underscore(key).to_sym
        end
      end

      private

      def request_headers
        {
          "Authorization" => "Bearer #{Yousign.config.api_key}",
          "Content-Type" => "application/json"
        }.freeze
      end

      def request(end_point, body)
        url = URI("#{Yousign.config.base_url}/#{end_point}")
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(url, request_headers)
        request.body = body.to_json
        https.request(request)
      end
    end
  end
end
