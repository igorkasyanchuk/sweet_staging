# Sweet Staging

We often need access to the staging.logs (or production), sidekiq.log, etc. And often direct access to the server is closed and you cannot get them. The idea of this gem is let developer or QA get access to the logs which you want to share.

This gem allows to access files which are ONLY specified in config. Same about shell commands. Same about Rails console.

### Very Important

```

Use this gem CAREFULLY on the environment which you need!!!
To protect access to the logs and other commands you can use various configuration options.

```

## Demo

See in action demo of the gem (opened app and `/sweet/staging` in a separate window)

[<img src="https://github.com/igorkasyanchuk/sweet_staging/blob/main/docs/res_sweet_staging.gif?raw=true"
/>](https://github.com/igorkasyanchuk/sweet_staging/blob/main/docs/res_sweet_staging.gif?raw=true)

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
  
  # protect your Performance Dashboard with HTTP BASIC password
  # config.http_basic_authentication_enabled   = false
  # config.http_basic_authentication_user_name = 'sweet'
  # config.http_basic_authentication_password  = 'password12'

  # if you need an additional rules to check user permissions
  # config.verify_access_proc = proc { |controller| true }
  # for example when you have `current_user`
  # config.verify_access_proc = proc { |controller| controller.current_user && controller.current_user.admin? }

end if defined?(SweetStaging)
```

You can use configuration options above to protect access to the logs for a specific user or by HTTP BASIC auth.

Please note, that this is not a real Rails console as we used, it's basically evaluating Ruby code sent to the server (stateless).

## Installation

Add this gem to the needed group of gems. For example for staging env. Be careful with production env and access to the logs.

```ruby
group :staging do
  gem 'sweet_staging'
end
```

And then execute:
```bash
$ bundle
```

After the installation start the server and open the `/sweet/staging`. Make sure that before you created an initializer and condifured all needed commands and files.

You need to have a "tail" and "wc" utils commands on the server to make everything working.

## TODO

- on scroll put on pause, on scroll to the bottom continue scrolling
- on selection put on pause
- implement link to log line feature
- specs
- support for Ruby <2.5 (open3 gem looks like was extracted into a separate gem)

## Contributing

You are welcome to contribute.

## Contributors

- https://github.com/ulianadzoba

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[<img src="https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/more_gems.png?raw=true"
/>](https://www.railsjazz.com/)
