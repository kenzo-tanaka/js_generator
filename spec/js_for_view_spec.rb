# frozen_string_literal: true

RSpec.describe JsGenerator::JsForView do
  describe 'create_file' do
    let(:path) { 'tmp/app/javascript/packs/views/admin/blogs/index.js' }
    after { File.delete(path) }

    it 'create js file for view' do
      js_for_view = JsGenerator::JsForView.new('admin', 'blog', 'index')
      js_for_view.create_file
      expect(File.exist?(path)).to eq true
    end
  end
end
