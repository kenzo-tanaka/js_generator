require 'dotenv'
Dotenv.load
require_relative './syntax_builder/with_namespace'
require_relative './syntax_builder/without_namespace'

module JsGenerator
  class AppJs
    attr_reader :syntax_builder

    def initialize(syntax_builder)
      @syntax_builder = syntax_builder
    end

    def append_script
      File.open(file_path, 'a') do |f|
        f << syntax_builder.script_for_append
      end

      puts "📝️ Appended script to #{file_path}"
    end

    private

    def file_path
      "app/javascript/packs/application.js"
    end
  end
end
