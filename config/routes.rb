Rails.application.routes.draw do
  resources :records do
    post 'import_data', on: :collection
    get 'select_records', on: :collection
  end

  root 'records#index'
end
