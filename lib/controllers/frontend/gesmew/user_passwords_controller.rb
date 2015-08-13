class Gesmew::UserPasswordsController < Devise::PasswordsController
  helper 'gesmew/base'

  include Gesmew::Core::ControllerHelpers::Auth
  include Gesmew::Core::ControllerHelpers::Common

  # Overridden due to bug in Devise.
  #   respond_with resource, :location => new_session_path(resource_name)
  # is generating bad url /session/new.user
  #
  # overridden to:
  #   respond_with resource, :location => gesmew.login_path
  #
  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])

    if resource.errors.empty?
      set_flash_message(:notice, :send_instructions) if is_navigational_format?
      respond_with resource, :location => gesmew.login_path
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  # Devise::PasswordsController allows for blank passwords.
  # Silly Devise::PasswordsController!
  # Fixes gesmew/gesmew#2190.
  def update
    if params[:gesmew_user][:password].blank?
      self.resource = resource_class.new
      resource.reset_password_token = params[:gesmew_user][:reset_password_token]
      set_flash_message(:error, :cannot_be_blank)
      render :edit
    else
      super
    end
  end

  protected

  def new_session_path(resource_name)
    gesmew.send("new_#{resource_name}_session_path")
  end
end
