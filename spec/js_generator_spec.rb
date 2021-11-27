# frozen_string_literal: true

RSpec.describe JsGenerator do
  it "has a version number" do
    expect(JsGenerator::VERSION).not_to be nil
  end

  describe JsGenerator::SetupJs do
    let(:js_path) { "app/javascript/packs/views/admin/blogs/new.js" }
    before { JsGenerator::AppJs.top_level_namespace = 'Example' }

    let(:app_js_path) { "app/javascript/packs/application.js" }
    before { File.open(app_js_path, 'w') }
    after { File.delete(app_js_path) }

    let(:view_path) { "app/views/admin/blogs/new.html.erb" }
    before { File.open(view_path, 'w') }
    after { File.delete(view_path) }

    after { File.delete(js_path) }
    it 'create js file for view' do
      setup_js = JsGenerator::SetupJs.new('admin', 'blog', 'new')
      setup_js.run
      expect(File.exist?(js_path)).to eq true
    end
  end
end
