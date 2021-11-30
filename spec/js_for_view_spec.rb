# frozen_string_literal: true

RSpec.describe JsGenerator::JsForView do
  describe 'create_file' do

    let(:text) do
      <<~TEXT
        export default() => {}
      TEXT
    end

    context 'with namespace' do
      let(:path) { 'app/javascript/packs/views/admin/blogs/new.js' }
      let(:setup_js) { JsGenerator::SetupJs.new(namespace: 'admin', model_name: 'blog', action_name: 'new') }
      let(:js_for_view) { JsGenerator::JsForView.new(setup_js) }

      after { File.delete(path) }

      it 'create js file for view' do
        js_for_view.create_file
        expect(File.exist?(path)).to eq true
      end

      it 'js file exported' do
        js_for_view.create_file
        expect(File.read(path)).to eq text
      end
    end

    context 'without namespace' do
      let(:path) { 'app/javascript/packs/views/blogs/new.js' }
      let(:setup_js) { JsGenerator::SetupJs.new(model_name: 'blog', action_name: 'new') }
      let(:js_for_view) { JsGenerator::JsForView.new(setup_js) }

      after { File.delete(path) }

      it 'create js file for view' do
        js_for_view.create_file
        expect(File.exist?(path)).to eq true
      end
    end
  end
end
