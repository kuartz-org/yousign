# frozen_string_literal: true

module Yousign
  class Member
    attr_reader :first_name, :last_name, :email, :phone, :file_objects

    def initialize(first_name:, last_name:, email:, phone:, file_objects: [])
      @first_name = first_name
      @last_name = last_name
      @email = email
      @phone = phone
      @file_objects = file_objects
    end

    def to_hash
      {
        first_name: first_name,
        last_name: last_name,
        email: email,
        phone: phone,
        file_objects: file_objects.map(&:to_hash)
      }
    end
  end
end
