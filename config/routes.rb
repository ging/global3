
Global::Application.routes.draw do
  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}

  #resource :agendas
  resource :settings
  resource :tie
  match "/settings/update_relation/:id" => "settings#update_relation"

resource :settings
resource :tie
resource :events

resource :actor
match "/settings/update_relation/:id" => "settings#update_relation"

  # Social Stream subjects configured in config/initializers/social_stream.rb

  SocialStream.subjects.each do |actor|
    resources actor.to_s.pluralize do
      resources :events do
        resource :agendas do
        resources :sessions
        end
      end
    end
  end


  match "events/:id/agenda" => "agendas#show"
  match "events/:id/sessions" => "sessions#show"
  match "events/:id/sessions/create" => "sessions#create"

  match "events/:id/agenda/get_sessions" => "agendas#get_sessions"

  match "sessions/:id/move" => "sessions#move"
  match "sessions/:id/resize" => "sessions#resize"
  match "sessions/:id/destroy" => "sessions#destroy"




  
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
