module JsGenerator
  class JsForView
    attr_reader :namespace, :model_name, :action_name

    def initialize(namespace, model_name, action_name)
      @namespace = namespace
      @model_name = model_name
      @action_name = action_name
    end

    def create_file
      mkdir_view
      mkdir_namespace
      mkdir_model
      touch_file
    end

    private

    def mkdir_view
      Dir.mkdir(view_path) unless Dir.exist?(view_path)
    end

    def mkdir_namespace
      Dir.mkdir(namespace_path) unless Dir.exist?(namespace_path)
    end

    def mkdir_model
      Dir.mkdir(model_path) unless Dir.exist?(model_path)
    end

    def touch_file
      File.open(action_path, 'w') unless File.exist?(action_path)
    end

    def view_path
      "tmp/app/javascript/packs/views"
    end

    def namespace_path
      "tmp/app/javascript/packs/views/#{namespace}"
    end

    def model_path
      "#{namespace_path}/#{model_name.pluralize}"
    end

    def action_path
      "#{model_path}/#{action_name}.js"
    end
  end
end
