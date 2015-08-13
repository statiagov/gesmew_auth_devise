class Gesmew::UserSessionsController < Devise::SessionsController
  helper 'gesmew/base'

  include Gesmew::Core::ControllerHelpers::Auth
  include Gesmew::Core::ControllerHelpers::Common

  def create
    authenticate_gesmew_user!

    if gesmew_user_signed_in?
      respond_to do |format|
        format.html {
          flash[:success] = Gesmew.t(:logged_in_succesfully)
          redirect_to admin_inspections_path
        }
        format.js {
          render :json => {:user => gesmew_current_user,
                           :contact_information => gesmew_current_user.contact_information
                          }
        }
      end
    else
      respond_to do |format|
        format.html {
          flash.now[:error] = t('devise.failure.invalid')
          render :new
        }
        format.js {
          render :json => { error: t('devise.failure.invalid') }, status: :unprocessable_entity
        }
      end
    end
  end

  private
    def accurate_title
      Gesmew.t(:login)
    end
end
