Zapchasti35::Application.routes.draw do

  get "password_resets/new"

  get "sessions/new"

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  get 'cart', to: 'cart#index', as: 'cart'
  get 'add_to_cart', to: 'cart#add', as: 'add_to_cart'
  get 'remove_from_cart', to: 'cart#remove', as: 'remove_from_cart'
  get 'add_quantity', to: 'cart#add_quantity', as: 'add_quantity'
  get 'remove_quantity', to: 'cart#remove_quantity', as: 'remove_quantity'
  get 'checkout', to: 'cart#checkout', as: 'checkout'
  post 'complete_checkout', to: 'cart#complete_checkout', as: 'complete_checkout'
  get 'thanks_for_checkout', to: 'cart#thanks_for_checkout', as: 'thanks_for_checkout'

  match '/search' => 'home#search', :as => :global_search
  resources :sessions
  resources :users do 
    collection do
      get :email_check
      get :phone_check 
    end
  end
  
  resources :password_resets


  get "admin/index"

  get "home/index"

  match "/thank_you" => 'home#thank_you'

  match 'admin' => "admin#index"

  namespace :admin do
    resources :prices do
      member do
        get :calculate
      end
    end
    resources :payment_methods
    resources :delivery_methods
    resources :pages
    resources :vendors
    resources :sea_pro_motors do
      collection do 
        post :sort_two_strokes
        post :sort_four_strokes
        post :update_prices
      end
      member do
        get :toggle_active
      end
    end
    resources :categories do
      resources :category_options do
        collection do 
          post :sort
        end
      end
      collection do
        post :sort
      end
    end
    resources :boat_categories do
      collection do
        post :sort
      end
    end    
    resources :boats do
      collection do
        post :sort
        post :update_prices
      end
    end       
  end

  resources :orders 
   # collection do
    #  get 'refresh_captcha'
    #  get 'check_captcha'
   # end
  # end

  resources :boats

  resources :motors do
    member do
      get 'order'
    end
  end


  match '/lodki/:category' => 'boats#category'
  match '/lodki/:category/:url_title' => 'boats#show', :as => :boat_with_category
  match '/lodki' => 'boats#rework'
  match '/lodochnie_motory' => 'pages#motors_rework'
  match '/lodochnie_motory/:slug' => 'pages#motors'
  match '/lodochnie_motory_sea_pro' => 'pages#motors', :slug => 'sea_pro'
  match '/o_nas' => 'pages#about'
  match '/oplata' => 'pages#oplata'
  match '/dostavka' => 'pages#dostavka'  

  match '/zapchasti_dlya_inomarok' => 'pages#zapchasti_dlya_inomarok'
  match '/zapchasti_dlya_lodochnih_motorov' => 'pages#zapchasti_dlya_lodochnih_motorov'
  match '/zapchasti_dlya_kitaiskih_avtobusov' => 'pages#zapchasti_dlya_kitaiskih_avtobusov'
  match '/zapchasti' => 'pages#zapchasti'

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
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', :on => :collection
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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'

  match '/:url' => 'pages#show'
end
