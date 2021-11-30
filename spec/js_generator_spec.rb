# frozen_string_literal: true

RSpec.describe JsGenerator do
  it 'has a version number' do
    expect(JsGenerator::VERSION).not_to be nil
  end

  describe JsGenerator::SetupJs do
    context 'top level namespace not set' do
      let(:setup_js) { JsGenerator::SetupJs.new(namespace: 'admin', model_name: 'blog', action_name: 'new') }
      before { setup_js.top_level_js_namespace = nil }
      it 'raise error' do
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

      let(:setup_js) { JsGenerator::SetupJs.new(namespace: 'admin', model_name: 'blog', action_name: 'new') }

      it 'create js file for view' do
        setup_js.run
        expect(File.exist?(js_path)).to eq true
      end
    end

    context 'without namespace arg' do
      let(:js_path) { "app/javascript/packs/views/blogs/new.js" }
      after { File.delete(js_path) }

      let(:app_js_path) { "app/javascript/packs/application.js" }
      before { File.open(app_js_path, 'w') }
      after { File.delete(app_js_path) }

      let(:view_path) { "app/views/blogs/new.html.erb" }
      before { File.open(view_path, 'w') }
      after { File.delete(view_path) }

      let(:setup_js) { JsGenerator::SetupJs.new(model_name: 'blog', action_name: 'new') }

      it 'create js file for view' do
        setup_js.run
        expect(File.exist?(js_path)).to eq true
      end
    end
  end
end
