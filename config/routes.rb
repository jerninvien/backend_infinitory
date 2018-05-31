Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/welcome', to: 'welcome#index'

  namespace :api, path: '', defaults: { format: :json }, constraints: { subdomain: 'api' } do
    namespace :v1 do
      get '/welcome_api_v1', to: 'welcome#index'

       # Using 4 digit invite_codes => 9000 pending invites possible
       # at any given time.
       # Expired invites are flushed every 24 hrs.
       # Should not be an issue, but can be improved later
      resources :invite_codes

      shallow do
        resources :labs do
          resources :devices do
            resources :bookings
          end

          resources :users
        end
      end
    end
  end
end
