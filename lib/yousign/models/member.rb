# frozen_string_literal: true

module Yousign
  ##
  # See https://dev.yousign.com/#c12b75be-8bf2-4feb-a2be-65074338b5c8
  class Member < APIResource
    attr_reader :id,
                :created_at,
                :updated_at,
                :finished_at,
                :comment,
                :contact,
                :email,
                :fields,
                :file_objects,
                :firstname,
                :lastname,
                :notifications_email,
                :operation_custom_modes,
                :operation_level,
                :operation_mode_email_config,
                :operation_mode_sms_config,
                :parent,
                :phone,
                :position,
                :status,
                :type,
                :user

    def signable_document_url
      URI("#{Yousign.config.webapp_url}/procedure/sign?members=#{id}").to_s
    end
  end
end
