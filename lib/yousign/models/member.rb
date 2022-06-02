# frozen_string_literal: true

module Yousign
  class Member < APIResource
    attr_reader :id,
                :comment,
                :contact,
                :email,
                :fields,
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

    def file_objects
      @file_objects.map { |file_object| FileObject.new(file_object) }
    end
  end
end
