class Gesmew::Admin::UserSessionsController < Devise::SessionsController
  helper 'gesmew/base'

  include Gesmew::Core::ControllerHelpers::Auth
  include Gesmew::Core::ControllerHelpers::Common

  helper 'gesmew/admin/navigation'
  helper 'gesmew/admin/tables'
  layout :resolve_layout

  def create
    authenticate_gesmew_user!

    if gesmew_user_signed_in?
      respond_to do |format|
        format.html {
          flash[:success] = Gesmew.t(:logged_in_succesfully)
          redirect_to admin_inspections_path
        }
        format.js {
          user = resource.record
          render :json => {:ship_address => user.ship_address, :bill_address => user.bill_address}.to_json
        }
      end
    else
      flash.now[:error] = t('devise.failure.invalid')
      render :new
    end
  end

  def authorization_failure
  end

  private
    def accurate_title
      Gesmew.t(:login)
    end

    def redirect_back_or_default(default)
      redirect_to(session["gesmew_user_return_to"] || default)
      session["gesmew_user_return_to"] = nil
    end

    def resolve_layout
      case action_name
      when "new", "create"
        "gesmew/layouts/login"
      else
        "gesmew/layouts/admin"
      end
    end
end
