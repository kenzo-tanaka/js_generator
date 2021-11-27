module JsGenerator
  module SyntaxBuilder
    class WithoutNamespaced
      attr_reader :namespace, :model_name, :action_name, :top_level_js_namespace

      def initialize(app_js)
        @namespace = app_js.namespace
        @model_name = app_js.model_name
        @action_name = app_js.action_name
        @top_level_js_namespace = app_js.top_level_js_namespace
      end

      def action_namespace
        "window.#{top_level_js_namespace}.#{model_name.capitalize.pluralize}.#{action_name.capitalize}"
      end

      def model_namespace
        "window.#{top_level_js_namespace}.#{model_name.capitalize.pluralize}"
      end

      def import_path
        "./views/#{model_name.pluralize}/#{action_name}"
      end

      def import_name
        "#{model_name.capitalize.pluralize}#{action_name.capitalize}"
      end
    end
  end
end
