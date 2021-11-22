# Yahoo Fantasy (Ruby)

Provides Ruby wrapping of the [Yahoo Fantasy Sports API](https://developer.yahoo.com/fantasysports/guide).

> The main goal of this project is to provide a realistic environment/library for the sole purpose of me learning Ruby.   

The library may:

- Not work at all - although that would be a failure of the adventure
- Come no where close to **best practices** with regards to designing Ruby libraries

> If you come across this repo and you see anyting that I could have done better.  Please don't hesitate to shoot me a note or a pull request (with some whys and whats of the changes) so that I can continue my Ruby journey on the right path!!

## Installation

> At this point in time the name `yahoo-fantasy-ruby` may change.   I guess the ruby part is a little superfluous, but it was the name of the folder I needed so I rolled with it.

Add this line to your application's Gemfile:

```ruby
gem 'yahoo-fantasy-ruby'
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
$ gem install yahoo-fantasy-ruby
```

## Usage

The library provides/allows for a number of different usage methods - or at least that was the goal.  You can pull and use as much or as little of as needed.   

At this point in time the `client` and `resources` are tied to an `OAuth2::AccessToken` (or atleast some object that responds to the `#request` method).

### Client

The `YahooFantasy::Client`, an extension of the `OAuth2::Client` providing sensible defaults and `Response` parsing is meant to be used.  Obviously this can be skipped if you're using your own custom `client` or `access_token#request` during processing.

```
# Create a new access token using the 
# This can be created and maintained at the server level
client = YahooFantasy::Client.new(ENV['yf_client_id], ENV['yf_client_secret'], redirect_uri: ENV['webroot_url])

# The access token is created at the request level
# Once you've gotten your user from the session/re-login
access_token = OAuth2::AccessToken.from_hash(client, 
                                             access_token: token.token, 
                                             refresh_token: token.refresh_token, 
                                             expiry_time: token.expiry_time)
```

I chose to use the `OAuth2::Client` and `OAuth2::AccessToken` instead of creating and maintaining my own `connection` (Faraday or other) as the library and classes were already well designed and provided the backing I needed without much change.  There are other libraries out there that only required setting of `access_token` to work, but I felt it important to be able to:
- make calls
- handle refreshes
- etc

within the same `client` that the users were making for requests.

> One interesting thing with Yahoo tokens is that the refresh token doesn't update (from what I've seen).  For example the same `access_token` and `refresh_token` can be used to refresh and work.  You don't need to save the new tokens to the database (although you probably should) you don't need to.

### Resources

Once you've got your `access_token` you supply the users token to the resources:

```
# With the access_token above
YahooFantasy::Resource::Base.access_token = access_token
```

> The `access_token` is stored at the `Thread[]` level so you need to ensure that it's removed after the request (server based).  One of the next steps is providing the `Rails` specific classes to assist with this.

### Games

### Leagues

### Teams

## XML 

The decision to use XML over JSON was made due to how Yahoo serializes data.  Although people tend to dislike XML due to its verboseness (I know there's a war on verbosity these days in development) the structure makes sense:

```
<games>
    <leagues>
        <scoreboard></scoreboard>
    </leagues>
</games>
```

where JSON is serialized as an array (0 based with the meta data):

```
games: [
    0: {
        // this is meta
    },
    1: {
        // this is the first sub resource
        // standings
    },
    2: {
        // this is the second sub resource
        // scoreboard
    }
]
```

which I just find annoying, and although it seems like the indices are based on the alphabetical name of the subresource, I still don't want to deal with it.

> Will definitely accept a pull request for the JSON representers allowing configuration between both XML or JSON

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Development Container

Development is done within a [development container](https://code.visualstudio.com/docs/remote/containers) that can easily be used within **vscode** (and possibly/eventually) (Github Codespaces)[https://github.com/features/codespaces]:

> Should make a `docker-compose` file at some point, but that's future Ken's problem

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kenjdavidson/yahoo_fantasy-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the YahooFantasy project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kenjdavidson/yahoo_fantasy-ruby/blob/master/CODE_OF_CONDUCT.md).
