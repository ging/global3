Global::Application.routes.draw do |map|
  # Authentication
  devise_for :users
  # Default authentication routes, compatible with global2
  match 'login' => 'devise/sessions#new', :as => :login
  match 'logout' => 'devise/sessions#destroy', :as => :logout
  match 'signup(.:format)' => 'devise/registrations#new', :as => :signup
  match 'lost_password' => 'devise/passwords#new', :as => :lost_password
  
  match 'home' => 'home#index', :as => :home
  map.help 'help', :controller => 'help', :action => 'index'  
  resources :feedback
  resource :session_locale  
  
  map.search 'search', :controller => 'browse', :action => 'index'
  
  resources :activities do 
    resource :like
  end

  resources :posts  
  resources :videos

  map.resources :spaces, :member => {:enable => :post} do |space|
    space.resources :users do |user|
      user.resource :profile
    end

    space.resources :readers
    space.resources :events,
                     :collection => [:add_time, :copy_next_week, :remove_time],
                     :member => { :token => :get, :spam => :post, :spam_lightbox => :get, :start => :post } do |event|
      event.resources :invitations
      event.resources :participants
      event.resource :agenda, :member => {:generate_pdf => :get}
      event.resource :agenda do |agenda|
        agenda.resources :agenda_dividers
        agenda.resources :agenda_entries
        agenda.resources :agenda_entries do |entry|
          entry.resource :attachment
        end
        agenda.resources :agenda_record_entries
      end
      event.resource :logo, :controller => 'event_logos', :member => {:precrop => :post}
    end

    space.resources :posts, :member => {:spam => :post, :spam_lightbox => :get}
    
    #Route to delete attachment collections with a DELETE to /:space_id/attachments
    space.attachments 'attachments', :controller => 'attachments' , :action => 'delete_collection', :conditions => { :method => :delete }
    space.resources :attachments,
                    :member => {:edit_tags => :get} 
    
    space.resources :entries
    space.resource :logo, :member => {:precrop => :post}

    space.resources :groups
    space.resources :admissions
    space.resources :invitations
    space.resources :join_requests
#    space.resources :event_invitations
    space.resources :performances
    space.resources :news
  end
        

  # The priority is based upon order of creation: first created -> highest priority.

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
  root :to => "frontpage#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
