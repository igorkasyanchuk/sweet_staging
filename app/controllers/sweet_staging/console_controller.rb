require_relative './base_controller.rb'

module SweetStaging
  class ConsoleController < SweetStaging::BaseController

    if SweetStaging.enabled && SweetStaging.console
      def index
      end

      def execute
        @result = eval(params[:code])
      rescue Exception => ex
        @result = ex.message
      end
    end

  end
end