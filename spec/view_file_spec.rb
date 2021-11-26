# frozen_string_literal: true

RSpec.describe JsGenerator::ViewFile do
  describe 'append_script' do
    let(:view_path) { "tmp/app/views/admin/blogs/new.html.erb" }
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
      setup_js = JsGenerator::ViewFile.new('admin', 'blog', 'new')
      setup_js.append_script
      expect(File.read(view_path)).to include text
    end
  end
end
