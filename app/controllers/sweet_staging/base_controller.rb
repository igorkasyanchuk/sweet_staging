module SweetStaging
  class BaseController < ActionController::Base
    include SweetStaging::ApplicationHelper
    layout 'sweet_staging/layouts/sweet_staging'

    # self.logger = SweetStaging::SilentLogger.new(config.logger)

    before_action :verify_access

    if SweetStaging.http_basic_authentication_enabled
      http_basic_authenticate_with \
        name: SweetStaging.http_basic_authentication_user_name,
        password: SweetStaging.http_basic_authentication_password
    end

    private

    def verify_access
      result = SweetStaging.verify_access_proc.call(self)
      redirect_to('/', error: 'Access Denied', status: 401) unless result
    end

  end
end