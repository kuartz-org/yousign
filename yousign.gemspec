# frozen_string_literal: true

require_relative "lib/yousign/version"

Gem::Specification.new do |spec|
  spec.name = "yousign"
  spec.version = Yousign::VERSION
  spec.authors = ["Guillaume Cabanel"]
  spec.email = ["guillaume.cabanel@kuartz.fr"]

  spec.summary = "Wrapper for Yousign API"
  spec.homepage = "https://github.com/kuartz-org/yousign"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.4"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
