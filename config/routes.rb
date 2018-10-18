Rails.application.routes.draw do
  

devise_for :users
   

   resources :projects do 
   	resources :tasks
   end
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