Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/welcome', to: 'welcome#index'

  # namespace :api, path: '', defaults: { format: :json }, constraints: { subdomain: 'api' } do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/welcome_api_v1', to: 'welcome#index'

       # Using 4 digit invite_codes => 9000 pending invites possible at any given time.
       # Expired invites are flushed every 24 hrs.
       # Should not be an issue, but can be improved later
      resources :invite_codes, only: [:index, :create]

      resources :users, except: [:destroy]

      shallow do
        resources :labs do
          resources :devices, except: [:destroy] do
            resources :bookings
          end

        end
      end
    end
  end
end
