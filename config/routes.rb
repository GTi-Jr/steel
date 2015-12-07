Rails.application.routes.draw do
  root 'pages#dashboard'

  devise_for :users

  patch '/language/:locale', to: 'application#language', as: :language

  devise_scope :user do
    get 'log_in' => 'devise/sessions#new'
  end

  scope "/admin" do
    resources :users do
      collection do
        get :new_admin
        post :create_admin
        get :customers
        get :admins
        get :query
      end
    end
  end

  resources :projects do
    collection do
      get :canceled
      get :query
    end

    member do
      patch :complete, as: :complete
      patch :uncomplete, as: :uncomplete
      patch :cancel
      patch :uncancel
    end
  end

  resources :notices
  resources :attachments
  resources :documents

  get '/dashboard' => 'pages#dashboard'
  get '/admin' => 'pages#dashboard_admin'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :attachments, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
