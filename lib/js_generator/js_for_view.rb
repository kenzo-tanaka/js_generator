module JsGenerator
  class JsForView
    attr_reader :namespace, :model_name, :action_name

    def initialize(setup_js)
      @namespace = setup_js.namespace
      @model_name = setup_js.model_name
      @action_name = setup_js.action_name
    end

    def create_file
      make_view_dir
      make_namespace_dir
      make_model_dir
      touch_file

      puts "📂 Created #{action_path}"
    end

    private

    def make_view_dir
      Dir.mkdir(view_path) unless Dir.exist?(view_path)
    end

    def make_namespace_dir
      return if Dir.exist?(namespace_path)
      return if namespace.nil?

      Dir.mkdir(namespace_path)
    end

    def make_model_dir
      Dir.mkdir(model_path) unless Dir.exist?(model_path)
    end

    def touch_file
      return if File.exist?(action_path)

      File.open(action_path, 'w') { |f| f.write export_statement }
    end

    def view_path
      "app/javascript/packs/views"
    end

    def namespace_path
      "#{view_path}/#{namespace}"
    end

    def model_path
      "#{namespace_path}/#{model_name.pluralize}"
    end

    def action_path
      "#{model_path}/#{action_name}.js"
    end

    def export_statement
      <<~TEXT
        export default() => {}
      TEXT
    end
  end
end
