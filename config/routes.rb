Rails.application.routes.draw do
  devise_for :users

  # -------- Public / Landing --------
  unauthenticated do
    root to: "home#index", as: :unauthenticated_root
  end

  # -------- Authenticated Area --------
  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root

    resources :metals, only: [:index, :new, :create, :edit, :update]
    resources :purities, only: [:index, :new, :create, :edit, :update]
    resources :jewellery_categories, only: [:index, :new, :create, :edit, :update]
    resources :stock_ledgers
    resources :sales, only: [:index, :new, :create, :show]
  end
end