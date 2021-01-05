SweetStaging.setup do |config|
  config.enabled  = true
  config.fetch_timeout = 2000
  config.console = true
  config.logs = [
    {
      name: "development.log",
      path: "log/development.log"
    },
    {
      name: "sidekiq.log",
      path: "log/sidekiq.log"
    },
    {
      name: "staging.log",
      path: "log/staging.log"
    },
    {
      name: "cron.log",
      path: "log/cron.log"
    },
    {
      name: "not-exists.log",
      path: "log/not-exists.log"
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
    },
    {
      name: "list files",
      command: "ls -l"
    },
  ]

end if defined?(SweetStaging)