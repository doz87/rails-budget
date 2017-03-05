Rails.application.routes.draw do



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'budget#index'

  get 'configuration', :to => 'configuration#index'

  resources :income
  resources :expense do
    collection do

      get 'import', :to => 'expense#import'
      post 'import', :to => 'expense#import'
    end
  end

end
