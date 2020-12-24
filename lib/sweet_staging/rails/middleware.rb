module SweetStaging
  module Rails
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        dup.call!(env)
      end

      def call!(env)
        if env['PATH_INFO'] =~ /sweet\/staging/
          in_silence { @status, @headers, @response = @app.call(env) }
        else
          @status, @headers, @response = @app.call(env)
        end

        [@status, @headers, @response]
      end

      def in_silence
        old_level = ::Rails.logger.level
        begin
          ::Rails.logger.level = Logger::ERROR
          yield
        ensure
          ::Rails.logger.level = old_level
        end
      end

    end
  end
end