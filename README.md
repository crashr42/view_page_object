# Rails view model

It simple `rails` gem given you isolated abstract layer under views likes `helpers`.
It extend `helpers` concept with given advantages:
- split helpers into smaller class linked to views and partials
- simpler testing
- simpler support
- support namespaced controllers

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rails_view_model'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails_view_model
```

## Usage

Initialize gem:

```bash
bin/rails g rails_view_model:install
```

Create controller with action:

```bash
bin/rails g controller index one
```

Create page object:

```bash
bin/rails g rails_view_model:create index one
```

### Example

```ruby
app/controllers/index_controller.rb

class IndexController < ApplicationController
  def one
    @name = params[:name]
  end
end
```

```ruby
app/views_models/index/one_view_model.rb

module Index
  class OneViewModel
    include RailsViewModel::Base

    def hello
      content_tag :h1, "Hello, #{@name}!"
    end
  end
end
```

```ruby
app/views/index/one.html.erb

<%= vm.hello %>
```

```ruby
test/views_models/index/one_view_model_test.rb

module Index
  class OneViewModelTest < ActionDispatch::IntegrationTest
     test 'hello' do
       page = Index::OneViewModel.new(name: 'Henry')
       
       assert_equals 'Hello, Henry!', page.hello
     end
  end
end
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
