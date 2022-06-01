# frozen_string_literal: true

module Yousign
  module Inflector
    ##
    # Inspired from ActiveSupport::Inflector#underscore
    def underscore(camel_cased_word)
      return camel_cased_word.to_s unless /[A-Z-]|::/.match?(camel_cased_word)

      word = camel_cased_word.to_s.gsub("::", "/")
      word.gsub!(/([A-Z]+)(?=[A-Z][a-z])|([a-z\d])(?=[A-Z])/) { (Regexp.lastmatch(1) || Regexp.lastmatch(2)) << "_" }
      word.tr!("-", "_")
      word.downcase!
      word
    end
  end
end
