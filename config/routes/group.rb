resources :groups, only: [:index, :new, :create]

scope(path: 'groups/*group_id',
      module: :groups,
      as: :group,
      constraints: { group_id: Gitlab::Regex.namespace_route_regex }) do
  resources :group_members, only: [:index, :create, :update, :destroy], concerns: [:access_requestable, :access_requestable_with_secret] do
    post :resend_invite, on: :member
    delete :leave, on: :collection
  end

  resource :avatar, only: [:destroy]
  resources :milestones, constraints: { id: /[^\/]+/ }, only: [:index, :show, :update, :new, :create]

  resources :labels, except: [:show] do
    post :toggle_subscription, on: :member
  end
end

scope(path: 'groups/*id',
      controller: :groups,
      constraints: { id: Gitlab::Regex.namespace_route_regex }) do
  get :edit, as: :edit_group
  get :issues, as: :issues_group
  get :merge_requests, as: :merge_requests_group
  get :projects, as: :projects_group
  get :activity, as: :activity_group
end

# Must be last route in this file
get 'groups/*id' => 'groups#show', as: :group_canonical, constraints: { id: Gitlab::Regex.namespace_route_regex }
