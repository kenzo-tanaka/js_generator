module JsGenerator
  class AppJs
    # TODO: enable to setting
    TOP_LEVEL_NAMESPACE = 'Example'.freeze

    attr_reader :namespace, :model_name, :action_name

    def initialize(namespace, model_name, action_name)
      @namespace = namespace
      @model_name = model_name
      @action_name = action_name
    end

    def append_script
      File.open(file_path, 'a') { |f| f << script_for_append }
    end

    def action_namespace
      "window.#{TOP_LEVEL_NAMESPACE}.#{namespace.capitalize}.#{model_name.capitalize.pluralize}.#{action_name.capitalize}"
    end

    private

    def file_path
      "tmp/app/javascript/packs/application.js"
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
      "window.#{TOP_LEVEL_NAMESPACE}.#{namespace.capitalize}"
    end

    def model_namespace
      "window.#{TOP_LEVEL_NAMESPACE}.#{namespace.capitalize}.#{model_name.capitalize.pluralize}"
    end

    def import_path
      "./views/#{namespace}/#{model_name.pluralize}/#{action_name}"
    end

    def import_name
      "#{namespace.capitalize}#{model_name.capitalize.pluralize}#{action_name.capitalize}"
    end
  end
end
