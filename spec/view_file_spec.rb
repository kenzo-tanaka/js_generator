# frozen_string_literal: true

RSpec.describe JsGenerator::ViewFile do
  describe 'append_script' do

    context 'with namespace' do
      let(:view_path) { "app/views/admin/blogs/new.html.erb" }
      before { File.open(view_path, 'w') }
      after { File.delete(view_path) }

      let(:text) do
        <<~TEXT
          <script>
            window.Example.Admin.Blogs.New();
          </script>
        TEXT
      end

      it 'append script tag to view file' do
        setup_js = JsGenerator::SetupJs.new(namespace: 'admin', model_name: 'blog', action_name: 'new')
        with_namespace_builder = JsGenerator::SyntaxBuilder::WithNamespace.new(setup_js)
        view_file = JsGenerator::ViewFile.new(setup_js, with_namespace_builder)
        view_file.append_script
        expect(File.read(view_path)).to include text
      end
    end

    context 'without namespace' do
      let(:view_path) { "app/views/blogs/new.html.erb" }
      before { File.open(view_path, 'w') }
      after { File.delete(view_path) }

      let(:text) do
        <<~TEXT
          <script>
            window.Example.Blogs.New();
          </script>
        TEXT
      end

      it 'append script tag to view file' do
        setup_js = JsGenerator::SetupJs.new(model_name: 'blog', action_name: 'new')
        without_namespace_builder = JsGenerator::SyntaxBuilder::WithoutNamespaced.new(setup_js)

        view_file = JsGenerator::ViewFile.new(setup_js, without_namespace_builder)
        view_file.append_script
        expect(File.read(view_path)).to include text
      end
    end
  end
end
