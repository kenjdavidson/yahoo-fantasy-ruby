# Yahoo Fantasy (Ruby)

> This project is basically an attempt at me learning Ruby (with a sprinkle of Docker development).  Yahoo Fantasy API is my general go to when learning new languages or technologies since it combines a large number of different (and important) things: language features and best practices, advanced language structures, and OAuth (among other things).
> Plus it's Fantasy Sports, so it's easy to keep engaged!!

## YahooFantasy Gem

The `yahoo-fantasy` gem provides, what I believe to be, some of the most common functionality used while working with the [Yahoo Fantasy API](https://developer.yahoo.com/fantasysports/guide).  I've taken some liberties with what I think are some important or commonly used shortcuts - but I've attempt to leave the ability to make raw requests when they are required.

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'yahoo_fantasy_ruby'
```

or add to your `gemspec`:

```
spec.add_dependency "yahoo_fantasy_ruby"
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install yahoo_fantasy_ruby
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Docker

Development and testing done within Docker (for the time being):

```
$ > docker build -t yahoo-fantasy-ruby .
$ > docker run -v ${PWD}:/yahoo-fantasy-ruby -v ${PWD}/bundle:/bundle --name yahoo-fantasy-ruby -it yahoo-fantasy-ruby /bin/bash
```

> Should make a `docker-compose` file at some point

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yahoo_fantasy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the YahooFantasy project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/yahoo_fantasy/blob/master/CODE_OF_CONDUCT.md).
