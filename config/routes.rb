Rails.application.routes.draw do
  root 'payments#new'

  resources :payments, only: %i(new create) do
    collection do
      get :done
      get :cancel
    end
  end
end
