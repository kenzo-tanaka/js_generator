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
      File.open(file_path, 'a') { |f| f << script_for_append }
    end

    # TODO: refactor namespace.present?
    def action_namespace
      syntax_builder.action_namespace
    end

    private

    def file_path
      "app/javascript/packs/application.js"
    end

    def syntax_builder
      namespace.present? ? SyntaxBuilder::Namespaced.new(self) : SyntaxBuilder::WithoutNamespaced.new(self)
    end

    def script_for_append
      <<~TEXT
        #{define_namespace(custom_namespace) if namespace.present?}
        #{define_namespace(model_namespace)}
        import #{import_name} from '#{import_path}';
        #{action_namespace} = #{action_namespace} || {};
        #{action_namespace} = #{import_name};
      TEXT
    end

    def define_namespace(text)
      File.read(file_path).include?(text) ? nil : "#{text} = #{text} || {};"
    end

    def custom_namespace
      "window.#{top_level_js_namespace}.#{namespace.capitalize}"
    end

    def model_namespace
      syntax_builder.model_namespace
    end

    def import_path
      syntax_builder.import_path
    end

    def import_name
      syntax_builder.import_name
    end
  end
end
