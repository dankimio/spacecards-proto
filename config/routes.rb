Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'pages#index'

  resources :decks, except: %i[show] do
    resources :recalls, only: %i[new]

    resources :cards, except: %i[edit], shallow: true

    get 'study', to: 'recalls#index'
  end
  resources :recalls, only: %i[create]
end
