# JsGenerator

This gem generates some JavaScript code with the specific rule.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'js_generator'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install js_generator

Add this lines to `config/environments/development.rb`:

```ruby
config.after_initialize do
  JsGenerator::AppJs.top_level_namespace = 'MySuperApp' # set your js top namespace
end
```

## Development

```shell
$ bin/setup
```

```shell
$ bundle exec rspec
```
