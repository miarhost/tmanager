Rails.application.routes.draw do
  
devise_for :users 

  resources :users do
   	resources :projects 
   end

  resources :projects do 
    resources :tasks
   end

  resources :users do
  resources :tasks
   end

 resources :projects 
 resources :tasks
 
devise_scope :user do
  authenticated :user do
    root 'main_pages#home', as: :authenticated_root
  end

  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end

end