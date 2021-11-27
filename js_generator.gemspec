# frozen_string_literal: true

require_relative "lib/js_generator/version"

Gem::Specification.new do |spec|
  spec.name          = "js_generator"
  spec.version       = JsGenerator::VERSION
  spec.authors       = ["kenzo-tanaka"]
  spec.email         = ["kenzou.kenzou104809@gmail.com"]

  spec.summary       = "Generate JavaScript codes with the specific rule."
  spec.description   = "Generate JavaScript codes with the specific rule."
  spec.homepage      = "https://github.com/kenzo-tanaka/js_generator"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"
  spec.executables   = ['setup_js']

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kenzo-tanaka/js_generator"
  spec.metadata["changelog_uri"] = "https://github.com/kenzo-tanaka/js_generator/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
