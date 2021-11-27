require 'dotenv'
Dotenv.load

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

    def action_namespace
      "window.#{top_level_js_namespace}.#{namespace.capitalize}.#{model_name.capitalize.pluralize}.#{action_name.capitalize}"
    end

    private

    def file_path
      "app/javascript/packs/application.js"
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

    def define_namespace(text)
      File.read(file_path).include?(text) ? nil : "#{text} = #{text} || {};"
    end

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
