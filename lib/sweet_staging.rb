require "sweet_staging/version"

module SweetStaging
  mattr_accessor :enabled
  @@enabled = true

  # default path where to mount gem
  mattr_accessor :mount_at
  @@mount_at = "/sweet/staging"

  # Enable http basic authentication
  mattr_accessor :http_basic_authentication_enabled
  @@http_basic_authentication_enabled = false

  # Enable http basic authentication
  mattr_accessor :http_basic_authentication_user_name
  @@http_basic_authentication_user_name = 'sweet'

  # Enable http basic authentication
  mattr_accessor :http_basic_authentication_password
  @@http_basic_authentication_password = 'password12'

  # If you want to enable access by specific conditions
  mattr_accessor :verify_access_proc
  @@verify_access_proc = proc { |controller| true }

  mattr_accessor :logs
  @@logs = []

  def self.setup
    yield(self)
  end

end

require "sweet_staging/engine"