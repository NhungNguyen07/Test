Rails.application.routes.draw do
  get "static_pages/home"
  get "static_pages/hello"
  root "static_pages#home"
end
