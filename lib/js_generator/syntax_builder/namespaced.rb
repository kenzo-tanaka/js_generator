module JsGenerator
  module SyntaxBuilder
    class Namespaced
      attr_reader :namespace, :model_name, :action_name, :top_level_js_namespace

      def initialize(app_js)
        @namespace = app_js.namespace
        @model_name = app_js.model_name
        @action_name = app_js.action_name
        @top_level_js_namespace = app_js.top_level_js_namespace
      end

      def action_namespace
        "window.#{top_level_js_namespace}.#{namespace.capitalize}.#{model_name.capitalize.pluralize}.#{action_name.capitalize}"
      end

      def model_namespace
        "window.#{top_level_js_namespace}.#{namespace.capitalize}.#{model_name.capitalize.pluralize}"
      end

      def import_path
        "./views/#{namespace}/#{model_name.pluralize}/#{action_name}"
      end

      def import_name
        "#{namespace.capitalize}#{model_name.capitalize.pluralize}#{action_name.capitalize}"
      end
    end
  end
end
