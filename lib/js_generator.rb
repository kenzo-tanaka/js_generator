# frozen_string_literal: true

require_relative "js_generator/version"
require_relative 'js_generator/js_for_view'
require_relative 'js_generator/app_js'
require_relative 'js_generator/view_file'
require 'active_support/inflector'

module JsGenerator
  class Error < StandardError; end
  class SetupJs
    attr_reader :namespace, :model_name, :action_name

    def initialize(namespace, model_name, action_name)
      @namespace = namespace
      @model_name = model_name
      @action_name = action_name
    end

    def run
      raise Error.new('Please set TOP_LEVEL_JS_NAMESPACE in .env') if AppJs.top_level_namespace.nil?

      JsForView.new(self).create_file
      AppJs.new(self).append_script
      ViewFile.new(self).append_script
    end
  end
end
