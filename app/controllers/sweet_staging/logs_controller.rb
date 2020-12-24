require_relative './base_controller.rb'

module SweetStaging
  class LogsController < SweetStaging::BaseController

    if SweetStaging.enabled
      def watch
      end

      def changes
        @lines = lines
      end

      def log_file_path
        item = SweetStaging.logs.detect {|e| e[:name] == params[:name]}
        "#{::Rails.root}/#{item[:path]}"
      end

      def lines
        puts "  [Reading] => #{log_file_path}"
        File.open(log_file_path).readlines.last(600)
      end
    end

  end
end