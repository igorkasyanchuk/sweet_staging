# Sweet Staging

We often need access to the staging.logs (or production), sidekiq.log, etc. And often direct access to the server is closed and you cannot get them. The idea of this gem is let developer or QA get access to the logs which you want to share.

## Usage

Basically just add this gem to the Gemfile and open `/sweet/staging` path.

Additionaly you need to configure files which you want to get access to `confif/initializers/sweet_staging.rb`:

```ruby
SweetStaging.setup do |config|
  config.enabled = true
  config.fetch_timeout = 1000
  config.console = true
  config.logs = [
    {
      name: "staging.log",
      path: "log/staging.log"
    },
    {
      name: "sidekiq.log",
      path: "log/sidekiq.log"
    },
    {
      name: "cron.log",
      path: "log/cron.log"
    }
  ]
  config.commands = [
    {
      name: "ps aux",
      command: "ps aux"
    },
    {
      name: "free -m",
      command: "free -m"
    }
  ]
end if defined?(SweetStaging)
```

## Installation

```ruby
gem 'sweet_staging'
```

And then execute:
```bash
$ bundle
```

## TODO

- on scroll put on pause, on scroll to the bottom continue scrolling
- on selection put on pause
- implement link to log line feature

## Contributing

You are welcome to contribute.

## Contributors

- https://github.com/ulianadzoba

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
