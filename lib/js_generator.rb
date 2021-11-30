# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'
require_relative 'js_generator/version'
require_relative 'js_generator/js_for_view'
require_relative 'js_generator/app_js'
require_relative 'js_generator/view_file'
require 'active_support/inflector'

module JsGenerator
  class Error < StandardError; end
  class SetupJs
    attr_reader :namespace, :model_name, :action_name
    attr_accessor :top_level_js_namespace

    def initialize(namespace: nil, model_name:, action_name:)
      @namespace = namespace
      @model_name = model_name
      @action_name = action_name
      @top_level_js_namespace = ENV['TOP_LEVEL_JS_NAMESPACE']
    end

    def run
      if top_level_js_namespace.nil?
        raise Error.new('Please set TOP_LEVEL_JS_NAMESPACE in .env')
      end

      create_file
      append_script
      append_script_tag

      puts "✨ All done!"
    end

    delegate :create_file, to: :js_for_view
    delegate :append_script, to: :app_js
    delegate :append_script_tag, to: :view_file

    private

    def js_for_view
      JsForView.new(self)
    end

    def app_js
      AppJs.new(syntax_builder)
    end

    def view_file
      ViewFile.new(self, syntax_builder)
    end

    def syntax_builder
      if namespace.present?
        SyntaxBuilder::WithNamespace.new(self)
      else
        SyntaxBuilder::WithoutNamespace.new(self)
      end
    end
  end
end
