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

  # class SilentLogger < SimpleDelegator
  #   def initialize(logger)
  #     super
  #   end

  #   %i(debug info warn error fatal unknown).each do |method_name|
  #     define_method(method_name) { |*_args| }
  #   end
  # end

  class LogFile
    MAX_LINES = 1000
    attr_reader :path, :client_total_lines

    def initialize(path:, client_total_lines:)
      @path               = path
      @client_total_lines = client_total_lines.presence || MAX_LINES
    end

    def total_lines
      @total_lines ||= begin
        #puts "wc -l #{path}"
        `wc -l #{path}`.split.first.to_i
      end
    end

    def readlines
      #puts "tail -n #{amount} #{path}"
      `tail -n #{amount} #{path}`.split(/\n/)
    end

    def amount
      result = total_lines - client_total_lines.to_i
      result = MAX_LINES if result < 0
      result = MAX_LINES if result > MAX_LINES
      result
    end
  end

end

require "sweet_staging/engine"