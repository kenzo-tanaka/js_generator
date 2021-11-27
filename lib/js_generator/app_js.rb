require 'dotenv'
Dotenv.load
require_relative './syntax_builder/namespaced'
require_relative './syntax_builder/without_namespace'

module JsGenerator
  class AppJs
    attr_reader :namespace, :model_name, :action_name, :top_level_js_namespace

    def initialize(setup_js)
      @namespace = setup_js.namespace
      @model_name = setup_js.model_name
      @action_name = setup_js.action_name
      @top_level_js_namespace = setup_js.top_level_js_namespace
    end

    def append_script
      File.open("app/javascript/packs/application.js", 'a') do |f|
        f << syntax_builder.script_for_append
      end
    end

    def action_namespace
      syntax_builder.action_namespace
    end

    private

    def syntax_builder
      if namespace.present?
        SyntaxBuilder::Namespaced.new(self)
      else
        SyntaxBuilder::WithoutNamespaced.new(self)
      end
    end
  end
end
