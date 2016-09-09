# ViewPageObject

It simple `rails` gem given you isolated abstract layer under views likes `helpers`.
It extend `helpers` concept with given advantages:
- split helpers into smaller class linked to actions
- simpler testing
- simpler support
- support namespaced controllers

## Usage

Create file under 'app/page_objects' directory. Write you logic. And call logic from view.

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
app/page_objects/index/one_page_object.rb

module Index
  class OnePageObject
    include ViewPageObject::Base

    def hello
      "Hello, #{@name}!"
    end
  end
end
```

```ruby
app/views/index/one.html.erb

<h1><%= page.hello %></h1>
```

```ruby
test/page_objects/index/one_page_object_test.rb

module Index
  class OnePageObjectTest < ActionDispatch::IntegrationTest
     test 'hello' do
       page = Index::OnePageObject.new(name: 'Henry')
       
       assert_equals 'Hello, Henry!', page.hello
     end
  end
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'view_page_object'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install view_page_object
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
