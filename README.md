# JsGenerator

This gem generates some JavaScript code with the specific rule.

# 📌 Dependency

- [dotenv](https://github.com/bkeepers/dotenv)

# 📚 How to work

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
$ bundle exec js_generate admin/blogs/new 
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
- Write `script` tag to the view file(e.g. `app/views/admin/blogs/new.html.erb`).
    ```html
    <script>
      window.Example.Admin.Blogs.New();
    </script>
    ```

# 🔍 `js_generate` command

Here is the `js_generate` syntax. The `namespace` is optional.

```shell
$ bundle exec js_generate [namespace(optional)]/[model_name]/[action_name]

# e.g. with namespace
$ bundle exec js_generate admin/blogs/new

# e.g.g without namespace
$ bundle exec js_generate blogs/index 
```

# 🖥 Development

```shell
$ bin/setup
```

```shell
$ bundle exec rspec
```
