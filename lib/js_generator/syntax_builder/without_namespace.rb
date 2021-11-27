require_relative './syntax_builder_base'

module JsGenerator
  module SyntaxBuilder
    class WithoutNamespaced < SyntaxBuilderBase
      def action_namespace
        "window.#{top_level_js_namespace}.#{model_name.capitalize.pluralize}.#{action_name.capitalize}"
      end

      def script_for_append
        <<~TEXT
          #{define_namespace(model_namespace)}
          import #{import_name} from '#{import_path}';
          #{action_namespace} = #{action_namespace} || {};
          #{action_namespace} = #{import_name};
        TEXT
      end

      private

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
