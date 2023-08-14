Rails.application.routes.draw do
  resources :quartos
  get 'home/index'
  resources :reservas
  resources :clientes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/reserva/buscar', to: 'reservas#buscar', as: :busca_reservas
  get '/reserva/resultado', to: 'reservas#resultado', as: :resultado_busca_reservas
  # Defines the root path route ("/")
  root "home#index"
  get '/home', to: 'home#index'
end
