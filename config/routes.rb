Hadean::Application.routes.draw do # |map|

  resources :user_sessions
  match 'login'   => 'user_sessions#new'
  match 'logout'  => 'user_sessions#destroy'
  match 'signup'  => 'shopping/cart_items#new'
  
  resources :products
  resources :cart_items
  resources :wish_items

  #devise_for :admins
  #devise_for :admins, :controllers => { :sessions => "admin/sessions" }
  resources :admins

  #devise_for :users

  
  root :to => "welcome#index"
  
  namespace :customer do
    resources :registrations
  end
  
  namespace :shopping do
    resources :cart_items
  end
  
  namespace :admin do
    resources :users
    
    namespace :generic do
      resources :shipping_categories
    end
    namespace :inventory do
      resources :suppliers
      resources :overviews
      resources :purchase_orders
      resources :receivings
    end
    
    namespace :merchandise do
      namespace :images do
        resources :products
      end
      resources :properties
      resources :prototypes
      resources :product_types
      resources :prototype_properties
      resources :products do 
        member do 
          get :add_properties
        end
        resources :variants
      end
    end
    
  end
  
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
