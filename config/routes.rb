Rails.application.routes.draw do
  require 'sidekiq/web'

  root 'hello#index'
  mount Sidekiq::Web => '/sidekiq'
  get 'json/:id', to: 'hello#info'
  get 'backoffice/', to: 'hello#backoffice', as: 'backoffice'

  get 'ok/:id', to: 'hello#ok'
  get 'fail/:id', to: 'hello#fail'
  get 'na/:id', to: 'hello#na'

  scope 'backoffice/' do
    get 'site/new/', to: 'hello#new', as: 'site_new'
    get 'site/edit/:id', to: 'hello#edit', as: 'site_edit'
    post 'site/create/', to: 'hello#create', as: 'site_create'
    patch 'site/update/:id', to: 'hello#update', as: 'site_update'
    delete 'site/destroy/:id', to: 'hello#destroy', as: 'site_destroy'
    get 'servidor/new/', to: 'hello#new_server', as: 'servidor_new'
    post 'servidor/create/', to: 'hello#create_server', as: 'servidor_create'
    delete 'servidor/destroy/:id', to: 'hello#destroy_server', as: 'servidor_destroy'
    post 'stopjob', to: 'hello#stopwork', as: 'stop_job'
  end

end
