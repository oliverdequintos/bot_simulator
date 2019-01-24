Rails.application.routes.draw do
  get 'bot_interface/index'
  post 'bot_interface/perform', as: 'perform_bot'
  root to: 'bot_interface#index'
end
