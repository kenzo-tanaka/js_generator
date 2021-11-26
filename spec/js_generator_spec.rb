# frozen_string_literal: true

RSpec.describe JsGenerator do
  it "has a version number" do
    expect(JsGenerator::VERSION).not_to be nil
  end

  describe JsGenerator::SetupJs do
    let(:js_path) { "tmp/app/javascript/packs/views/admin/blogs/new.js" }
    after { File.delete(js_path) }
    it 'create js file for view' do
      setup_js = JsGenerator::SetupJs.new('admin', 'blog', 'new')
      setup_js.run
      expect(File.exist?(js_path)).to eq true
    end
  end
end
