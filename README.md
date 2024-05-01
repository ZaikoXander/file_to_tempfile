# FileToTempfile

Easily convert a File object to a Tempfile object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubyt'
```

And then execute:

```sh
$ bundle install
```

## Usage

```ruby
require 'file_to_tempfile'

file = File.open '.gitignore'

tempfile = FileToTempfile.convert(file)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ZaikoXander/file_to_tempfile.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
