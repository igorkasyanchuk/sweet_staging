require_relative './rails/middleware.rb'

module SweetStaging
  class Engine < ::Rails::Engine
    isolate_namespace SweetStaging

    if SweetStaging.try(:enabled) # for rails c
      if ::Rails::VERSION::MAJOR.to_i >= 5
        config.app_middleware.insert_after ActionDispatch::Executor, SweetStaging::Rails::Middleware
      else
        config.app_middleware.insert_after ActionDispatch::Static, SweetStaging::Rails::Middleware
      end
    end

  end
end