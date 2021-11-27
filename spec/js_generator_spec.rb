# frozen_string_literal: true

require 'dotenv'
Dotenv.load

RSpec.describe JsGenerator do
  it "has a version number" do
    expect(JsGenerator::VERSION).not_to be nil
  end

  describe JsGenerator::SetupJs do
    context 'top level namespace not set' do
      xit 'raise error' do
        setup_js = JsGenerator::SetupJs.new('admin', 'blog', 'new')
        expect{ setup_js.run }.to raise_error(JsGenerator::Error)
      end
    end

    context 'top level namespace set' do
      let(:js_path) { "app/javascript/packs/views/admin/blogs/new.js" }
      after { File.delete(js_path) }

      let(:app_js_path) { "app/javascript/packs/application.js" }
      before { File.open(app_js_path, 'w') }
      after { File.delete(app_js_path) }

      let(:view_path) { "app/views/admin/blogs/new.html.erb" }
      before { File.open(view_path, 'w') }
      after { File.delete(view_path) }

      it 'create js file for view' do
        setup_js = JsGenerator::SetupJs.new('admin', 'blog', 'new')
        setup_js.run
        expect(File.exist?(js_path)).to eq true
      end
    end

  end
end
