module JsGenerator
  class ViewFile
    attr_reader :namespace, :model_name, :action_name, :syntax_builder

    def initialize(setup_js, syntax_builder)
      @namespace = setup_js.namespace
      @model_name = setup_js.model_name
      @action_name = setup_js.action_name
      @syntax_builder = syntax_builder
    end

    def append_script_tag
      File.open(file_path, 'a') { |f| f << script_tag }
    end

    private

    def file_path
      "app/views/#{namespace}/#{model_name.pluralize}/#{action_name}.html.erb"
    end

    def script_tag
      <<~TEXT
        <script>
          #{syntax_builder.action_namespace}();
        </script>
      TEXT
    end
  end
end
