Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'decks#index'

  resources :decks, except: %i[edit update destroy] do
    resources :recalls, only: %i[new]

    resources :cards, only: %i[index new create], shallow: true do
      resources :recalls, only: %i[create]
    end

    get 'study', to: 'recalls#index'
  end
end
