Servicetrac::Application.routes.draw do

  #get "users/index"
  #get "users/show"
  #get "users/new"
  #get "users/create"
  #get "users/update"
  #get "users/edit"
  #get "users/destroy"
  namespace :admin do
    resources :tech_supports
  end

  resources :messages

  devise_for :users 

  resources :users_service_centers
 
  resources :service_alerts

  resources :service_center_reviews

  resources :alert_details do
    collection do
      post 'get_route'
    end
  end

  namespace :admin do
    resources :service_centers
    root to: "admin#index"
    resources :companies
    resources :eobr_models
    resources :eobr_makes do
      collection  do
        get 'getmodal' 
      end
    end
  end

  match 'api/eobr-makes' => 'admin/eobr_makes#index',  :via => :get,  :defaults => { :format => 'json' }

  match 'api/eobr-models/:id' => 'admin/eobr_models#index',  :via => :get,  :defaults => { :format => 'json' }

  match 'api/companies' => 'admin/companies#index',  :via => :get,  :defaults => { :format => 'json' }

  match 'api/service-centers' => 'admin/service_centers#index',  :via => :get,  :defaults => { :format => 'json' }
  
  match 'api/tech-support' => 'admin/tech_supports#index',  :via => :get,  :defaults => { :format => 'json' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'service_alerts#index'

  post 'register_app_user' => 'users#register_app_user'

  post 'login' => 'users#login'

  match 'driver-status' => 'service_alerts#driver_status',  :via => :post

  #post 'post_review' => 'service_center_reviews#post_review'

  match 'post-review' => 'service_center_reviews#post_review',  :via => :post

  #post 'get_reviews' => 'service_center_reviews#get_reviews'  

  match 'get-reviews/:service_center_id' => 'service_center_reviews#get_reviews',  :via => :get,  :defaults => { :format => 'json' }

  post 'post_message' => 'messages#post_message'

  match 'all-messages' => 'messages#all_messages',  :via => :post,  :defaults => { :format => 'json' }

  post 'settings' => 'users#settings'

  post 'recover_password' => 'users#recover_password'
  
  get 'edit_alert' => 'alert_details#edit_alert'

  post 'update_alert' => 'alert_details#update_alert'

  match 'admin/manage_dispatch_user' => 'admin/admin#manage_dispatch_user',  :via => :get

  match 'admin/manage_dispatch_user_edit' => 'admin/admin#manage_dispatch_user_edit',  :via => :get
  
  get 'edit_service_center' => 'alert_details#edit_service_center'

  post 'update_service_center' => 'alert_details#update_service_center'  

  get 'service_ticket' => 'alert_details#service_ticket'

  post 'update_ticket' => 'alert_details#update_ticket'

  match 'create_user' => 'users#create_user',  :via => :post

  get 'service_center' => 'service_center_reviews#service_center'
  
  post 'getCenter' => 'service_center_reviews#getCenter'

  match 'add-notes' => 'alert_details#add_notes',  :via => :post

  match 'get-notes' => 'alert_details#get_notes', :via => :get, :defaults => { :format => 'json' }

  get 'notes' => 'alert_details#notes'
  #   get 'register' => 'welcome#index'
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
