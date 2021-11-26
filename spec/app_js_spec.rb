# frozen_string_literal: true

RSpec.describe JsGenerator::AppJs do
  describe 'append_script' do
    let(:app_js_path) { "tmp/app/javascript/packs/application.js" }

    context 'not exist namespace in application.js' do
      before { File.open(app_js_path, 'w') }
      after { File.delete(app_js_path) }

      let(:text) do
        <<~TEXT
          window.Example.Admin = window.Example.Admin || {};
          window.Example.Admin.Blogs = window.Example.Admin.Blogs || {};
          import AdminBlogsNew from './views/admin/blogs/new';
          window.Example.Admin.Blogs.New = window.Example.Admin.Blogs.New || {};
          window.Example.Admin.Blogs.New = AdminBlogsNew;
        TEXT
      end
      it 'append some js lines to application.js' do
        setup_js = JsGenerator::AppJs.new('admin', 'blog', 'new')
        setup_js.append_script
        expect(File.read(app_js_path)).to include text
      end
    end

    context 'already exists namespace in application.js' do
      before { File.open(app_js_path, 'w') { |f| f.write original_text } }
      after { File.delete(app_js_path) }

      let(:original_text) do
        <<~TEXT
          window.Example.Admin = window.Example.Admin || {};
          window.Example.Admin.Blogs = window.Example.Admin.Blogs || {};
          import AdminBlogsEdit from './views/admin/blogs/edit';
          window.Example.Admin.Blogs.Edit = window.Example.Admin.Blogs.Edit || {};
          window.Example.Admin.Blogs.Edit = AdminBlogsEdit;
        TEXT
      end
      let(:expect_text) do
        <<~TEXT
          window.Example.Admin = window.Example.Admin || {};
          window.Example.Admin.Blogs = window.Example.Admin.Blogs || {};
          import AdminBlogsEdit from './views/admin/blogs/edit';
          window.Example.Admin.Blogs.Edit = window.Example.Admin.Blogs.Edit || {};
          window.Example.Admin.Blogs.Edit = AdminBlogsEdit;


          import AdminBlogsNew from './views/admin/blogs/new';
          window.Example.Admin.Blogs.New = window.Example.Admin.Blogs.New || {};
          window.Example.Admin.Blogs.New = AdminBlogsNew;
        TEXT
      end

      it 'does not overwrite namespace, append script' do
        setup_js = JsGenerator::AppJs.new('admin', 'blog', 'new')
        setup_js.append_script
        expect(File.read(app_js_path)).to eq expect_text
      end
    end

  end
end
