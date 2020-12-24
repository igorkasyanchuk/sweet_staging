SweetStaging.setup do |config|
  config.enabled  = true
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
    }
  ]

end if defined?(SweetStaging)