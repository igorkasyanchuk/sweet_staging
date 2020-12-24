require_relative './base_controller.rb'

module SweetStaging
  class HomeController < SweetStaging::BaseController

    if SweetStaging.enabled
      def index
        redirect_to sweet_staging.watch_url(name: SweetStaging.logs[0][:name])
      end
    end

  end
end