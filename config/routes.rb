SweetStaging::Engine.routes.draw do
  get '/' => 'home#index', as: :home
end

Rails.application.routes.draw do
  begin
    mount SweetStaging::Engine => SweetStaging.mount_at, as: 'sweet_staging'
  rescue ArgumentError
      # already added
      # this code exist here because engine not includes routing automatically
  end
end