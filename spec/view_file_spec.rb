# frozen_string_literal: true

RSpec.describe JsGenerator::ViewFile do
  describe 'append_script' do
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
      setup_js = JsGenerator::SetupJs.new('admin', 'blog', 'new')
      view_file = JsGenerator::ViewFile.new(setup_js)
      view_file.append_script
      expect(File.read(view_path)).to include text
    end
  end
end
