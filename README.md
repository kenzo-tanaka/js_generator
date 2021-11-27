# JsGenerator

This gem generates some JavaScript code with the specific rule.

## 📌 Dependency

- [dotenv](https://github.com/bkeepers/dotenv)

## 📚 How to work

Add this line to your application's Gemfile:

```ruby
gem 'js_generator'
```

And then execute:

    $ bundle install

Add this lines to `.env`:

```text
# set your js top namespace
TOP_LEVEL_JS_NAMESPACE=Example
```

```shell
$ bundle exec setup_js admin blog new
# bundle exec setup_js [namespace] [model_name] [action_name]
```

This command generates these lines:

- Create the js file for the view like `app/javascript/packs/views/admin/blogs/new.js`.
- Write some codes below: 
    ```js
    // application.js
    window.Example.Admin = window.Example.Admin || {};
    window.Example.Admin.Blogs = window.Example.Admin.Blogs || {};
    import AdminBlogsNew from './views/admin/blogs/new';
    window.Example.Admin.Blogs.New = window.Example.Admin.Blogs.New || {};
    window.Example.Admin.Blogs.New = AdminBlogsNew;
    ```
- Write `script` tag to the view file.
    ```html
    <script>
      window.Example.Admin.Blogs.New();
    </script>
    ```

## 🖥 Development

```shell
$ bin/setup
```

```shell
$ bundle exec rspec
```
