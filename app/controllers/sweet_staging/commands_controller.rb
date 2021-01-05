require_relative './base_controller.rb'

module SweetStaging
  class CommandsController < SweetStaging::BaseController

    if SweetStaging.enabled
      def call
        item = SweetStaging.commands.detect {|e| e[:name] == params[:name]}
        @result, status = Open3.capture2e(item[:command])
      end
    end

  end
end