Rails.application.routes.draw do
  resources :loans, defaults: {format: :json} do
    resources :payments, defaults: {format: :json}, shallow: true
  end
end
