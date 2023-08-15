Rails.application.routes.draw do
  resources :quartos
  get 'home/index'
  resources :reservas
  resources :clientes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/reserva/buscar', to: 'reservas#buscar', as: :busca_reservas
  get '/reserva/resultado', to: 'reservas#resultado', as: :resultado_busca_reservas

  # Rota para a busca de clientes
  get '/cliente/buscar', to: 'clientes#buscar', as: :busca_clientes
  get '/cliente/resultado', to: 'clientes#resultado', as: :resultado_busca_clientes

  # Rota para a busca de quartos
  get 'buscar_quartos', to: 'quartos#buscar', as: 'buscar_quartos'

  # Defines the root path route ("/")
  root "home#index"
  get '/home', to: 'home#index'
end
