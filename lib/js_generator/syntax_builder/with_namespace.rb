require_relative './syntax_builder_base'

module JsGenerator
  module SyntaxBuilder
    class WithNamespace < SyntaxBuilderBase
      def action_namespace
        "window.#{top_level_js_namespace}.#{namespace.capitalize}.#{model_name.capitalize.pluralize}.#{action_name.capitalize}"
      end

      def script_for_append
        <<~TEXT
          #{define_namespace(custom_namespace)}
          #{define_namespace(model_namespace)}
          import #{import_name} from '#{import_path}';
          #{action_namespace} = #{action_namespace} || {};
          #{action_namespace} = #{import_name};
        TEXT
      end

      private

      def custom_namespace
        "window.#{top_level_js_namespace}.#{namespace.capitalize}"
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
