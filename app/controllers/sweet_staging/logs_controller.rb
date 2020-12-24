require_relative './base_controller.rb'

module SweetStaging
  class LogsController < SweetStaging::BaseController

    if SweetStaging.enabled
      def watch
      end

      def changes
        @lines       = log_file.readlines
        @total_lines = log_file.total_lines
      end

      def log_file
        @log_file ||= begin
          item = SweetStaging.logs.detect {|e| e[:name] == params[:name]}
          LogFile.new(path: "#{::Rails.root}/#{item[:path]}", client_total_lines: params[:client_total_lines])
        end
      end
    end

  end
end