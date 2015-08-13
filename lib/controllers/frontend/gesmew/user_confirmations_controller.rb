class Gesmew::UserConfirmationsController < Devise::ConfirmationsController
  helper 'gesmew/base'

  include Gesmew::Core::ControllerHelpers::Auth
  include Gesmew::Core::ControllerHelpers::Common

  protected

  def after_confirmation_path_for(resource_name, resource)
    signed_in?(resource_name) ? signed_in_root_path(resource) : gesmew.login_path
  end
end
