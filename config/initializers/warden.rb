Warden::Manager.after_set_user except: :fetch do |user, auth, opts|
  if auth.cookies.signed[:guest_token].present?
    if user.is_a?(Gesmew::User)

    end
  end
end

Warden::Manager.before_logout do |user, auth, opts|
  auth.cookies.delete :guest_token
end
