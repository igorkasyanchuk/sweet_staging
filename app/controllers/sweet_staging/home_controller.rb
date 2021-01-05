require_relative './base_controller.rb'

module SweetStaging
  class HomeController < SweetStaging::BaseController

    if SweetStaging.enabled
      def index
        if SweetStaging.logs.any?
          redirect_to sweet_staging.watch_url(name: SweetStaging.logs[0][:name])
        else
          render text: "Please configure initializer: https://github.com/igorkasyanchuk/sweet_staging"
        end
      end
    end

  end
end