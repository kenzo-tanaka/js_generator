# frozen_string_literal: true

RSpec.describe JsGenerator::JsForView do
  describe 'create_file' do
    let(:path) { 'app/javascript/packs/views/admin/blogs/new.js' }
    after { File.delete(path) }

    it 'create js file for view' do
      setup_js = JsGenerator::SetupJs.new('admin', 'blog', 'new')
      js_for_view = JsGenerator::JsForView.new(setup_js)
      js_for_view.create_file
      expect(File.exist?(path)).to eq true
    end
  end
end
