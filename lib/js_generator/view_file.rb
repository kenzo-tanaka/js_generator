module JsGenerator
  class ViewFile
    attr_reader :namespace, :model_name, :action_name

    def initialize(namespace, model_name, action_name)
      @namespace = namespace
      @model_name = model_name
      @action_name = action_name
    end

    def append_script
      File.open(file_path, 'a') { |f| f << script_tag }
    end

    private

    def file_path
      "app/views/#{namespace}/#{model_name.pluralize}/#{action_name}.html.erb"
    end

    def script_tag
      <<~TEXT
        <script>
          #{AppJs.new(namespace, model_name, action_name).action_namespace}();
        </script>
      TEXT
    end
  end
end
