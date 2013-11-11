Angularails::Application.routes.draw do

  resources :items, except: [:new, :edit]
  get '/' => 'items#index_render'

  root :to => 'items#index_render'
end
