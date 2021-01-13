Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # this is a test V2
  scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :links, only: :index
  end

  # namespace the controllers without affecting the URI
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :links
    resources :redirect

    get '/s/:slug', to: 'redirects#index'
  end
end
