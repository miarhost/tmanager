Rails.application.routes.draw do

  get 'main_pages/home'
  devise_for :users
  
root to: "main_pages#home"
 
end
