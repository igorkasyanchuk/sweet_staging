require_relative './base_controller.rb'

module SweetStaging
  class HomeController < SweetStaging::BaseController
    include SweetStaging::ApplicationHelper

    if SweetStaging.enabled
      def index
      end
    end

  end
end