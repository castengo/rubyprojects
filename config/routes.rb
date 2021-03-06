Rails.application.routes.draw do

  # scanner test
  get 'scanner' => 'scanner#scan'

  resources :tutorials, only: [:create, :destroy, :show]

  get 'account' => "accounts#show"
  resources :profiles, only: [:new, :create, :update, :edit, :destroy], path: 'account/profiles/', as: 'account_profile'


  resources :profiles, only: [:show] do
    # resources :looks, only: [:new, :create, :edit, :update, :destroy]
    resources :looks, shallow: true
  end

  get 'looks' => "looks#index"


  devise_for :users

  root 'static_pages#home'
  get 'static_pages/about'
  get 'static_pages/help'


  resources :brands do
    resources :products, only: [:new, :create]
  end
  resources :products, only: [:index, :edit, :update, :show, :destroy] do
    resources :shades, only: [:new, :create, :show, :destroy]
  end

  resources :shades, only: [:index]

  get "/shades/search" => "shades#search"
  get "/shades/paginate" => "shades#paginate"

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
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
