module JsGenerator
  module SyntaxBuilder
    class SyntaxBuilderBase
      attr_reader :namespace, :model_name, :action_name, :top_level_js_namespace

      def initialize(app_js)
        @namespace = app_js.namespace
        @model_name = app_js.model_name
        @action_name = app_js.action_name
        @top_level_js_namespace = app_js.top_level_js_namespace
      end

      private

      def define_namespace(text)
        File.read("app/javascript/packs/application.js").include?(text) ? nil : "#{text} = #{text} || {};"
      end
    end
  end
end
