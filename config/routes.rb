SweetStaging::Engine.routes.draw do
  get '/'              => 'home#index', as: :home
  get '/watch'         => 'logs#watch', as: :watch
  get '/watch/changes' => 'logs#changes', as: :changes

  get '/console'  => 'console#index', as: :console
  post '/execute' => 'console#execute', as: :execute

  get '/call'         => 'commands#call', as: :call

  ["ansi_up.js.map", "perfect-scrollbar.min.js.map", "bulmaswatch.min.css.map", "ansi_up.js.map", "perfect-scrollbar.min.js.map", "bulmaswatch.min.css.map"].each do |res|
    get "/#{res}", to: -> (env) do
      [200, { 'Content-Type' => 'text/plain' }, ['']]
    end
  end
end

Rails.application.routes.draw do
  begin
    mount SweetStaging::Engine => SweetStaging.mount_at, as: 'sweet_staging'
  rescue ArgumentError
      # already added
      # this code exist here because engine not includes routing automatically
  end
end