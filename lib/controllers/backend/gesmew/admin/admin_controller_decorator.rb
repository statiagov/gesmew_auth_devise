Gesmew::Admin::BaseController.class_eval do

  # Redirect as appropriate when an access request fails.  The default action is to redirect to the login screen.
  # Override this method in your controllers if you want to have special behavior in case the user is not authorized
  # to access the requested action.  For example, a popup window might simply close itself.
  def unauthorized
    if try_gesmew_current_user
      flash[:error] = Gesmew.t(:authorization_failure)
      redirect_to gesmew.admin_unauthorized_path
    else
      store_location
      redirect_to gesmew.admin_login_path
    end
  end

  protected

    def model_class
      const_name = controller_name.classify
      if Gesmew.const_defined?(const_name, false)
        return "Gesmew::#{const_name}".constantize
      end
      nil
    end

end
