Rails.application.routes.draw do
  resources :tasks
  resources :projects
devise_for :users

devise_scope :user do
  authenticated :user do
    root 'main_pages#home', as: :authenticated_root
  end

  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end

end