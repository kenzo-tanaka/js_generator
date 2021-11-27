module JsGenerator
  class ViewFile
    attr_reader :namespace, :model_name, :action_name, :setup_js

    def initialize(setup_js)
      @namespace = setup_js.namespace
      @model_name = setup_js.model_name
      @action_name = setup_js.action_name
      @setup_js = setup_js
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
          #{AppJs.new(setup_js).action_namespace}();
        </script>
      TEXT
    end
  end
end
