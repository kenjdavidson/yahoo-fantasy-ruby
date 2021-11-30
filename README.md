# Yahoo Fantasy (Ruby)

Provides Ruby wrapping of the [Yahoo Fantasy Sports API](https://developer.yahoo.com/fantasysports/guide).

> I make no guarantees about this code working or without some poor Ruby choices.

This was my first attempt at a Ruby library (at Ruby at all to be honest) and may:

- Not work at all - although that would be a failure of the adventure
- Come no where close to **best practices** with regards to designing Ruby libraries
- Need a lot of love in order to get to a **realistic Ruby** place

> If you come across this repo and you see anyting that I could have done better.  Please don't hesitate to shoot me a note or a pull request (with some whys and whats of the changes) so that I can continue my Ruby journey on the right path!!

## Installation

> At this point in time the name `yahoo-fantasy` may change.   I guess the ruby part is a little superfluous, but it was the name of the folder I needed so I rolled with it.

### Gem

Add this line to your application's Gemfile:

```ruby
gem 'yahoo-fantasy'
```

### Gemspec

Add to your `gemspec`:

```
spec.add_dependency "yahoo_fantasy_ruby"
```

Then install dependencies:

```
$ bundle install
```

### Install Directly

Install the gem directly:

```
$ gem install yahoo-fantasy
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

#### Base

The `YahooFantasy::Resource::Base` class provides access to the `access_token`:

```
# With the access_token above
YahooFantasy::Resource::Base.access_token = access_token
```

> The `access_token` is stored at the `Thread[]` level so you need to ensure that it's removed after the request (server based).  One of the next steps is providing the `Rails` specific classes to assist with this.

Once the access token is provided, requests can be made through the `.api` method:

```
fantasy_content = YahooFantasy::Resource::Base.api(:get, '/users;use_login=1/games/leagues)
fantasy_content.games.each do |game|
  puts "#{game.code.upcase}"                            # => NFL
  game.leagues.each do |league|
    puts "- #{league.name} (#{league.league_key})"      # => - League Name (404.l.12345)
  end 
end
```

The `Base` resource also has methods:

- `.get(key, options, &block)` to get a single resource
- `.all(filters, options, &block)` to get a collection of resources

Which will attempt to create the appropriate resource url from the provided arguments (need some love and handling) and will return a `YahooFantasy::Resource::FantasyContent` or what is returned from the `->(fantasy_content) {}` block provided.

> This is where it would make more sense to provide `YahooFantasy::Api::Resource` and `YahooFantasy::Api::Collection` as mentioned elsewhere in here.  

#### Game(s)

The `YahooFantasy::Resource::Game::Game` resource provides some consistent and common access to the API.

> Ya, I get the name `Game::Game` isn't optimal.  I've been playing around with the idea of `Game::Meta` (which is how Yahoo references it) or `Api::Game`.  I'll leave that for future Ken once I start actually using it.

> Also available at `YahooFantasy::Games` shortcut.

##### Resource

[Game Resource](https://developer.yahoo.com/fantasysports/guide/#game-resource) details can be found on the Yahoo developer portal.

For the most part the only the `game_key` is required when making a request, but there are subresources available:

**Game metadata**

```
# Get Game metadata
game = YahooFantasy::Resource::Game::Game.get('406')
```

**Game with subresources**

```
# Get the Game metadata with subresources
game = YahooFantasy::Resource::Game::Game.get('406', subresources: %w[game_weeks stat_categories roster_positions leagues])
```

> The teams subresource is not currently available

> The leagues subresource is available. BUT it's only available in terms of the logged in user.  At this point there is no way to request a subresource with further filters.   Although I do plan on getting this working once I get more comfortable with Ruby.

##### Collection

[Games collection](https://developer.yahoo.com/fantasysports/guide/#games-collection) provides access to multiple games using a set of specified filters.

#### Leagues

#### Teams

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
