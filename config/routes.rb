Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'decks#index'

  resources :decks do
    resources :cards, shallow: true
    resources :recalls, shallow: true

    get 'study', to: 'recalls#new'
  end
end
