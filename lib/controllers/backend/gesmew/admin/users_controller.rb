# class Gesmew::Admin::UsersController < Gesmew::BaseController
#   prepend_before_filter :load_object, :only => [:show, :edit, :update]
#   prepend_before_filter :authorize_actions, :only => :new
#
#   layout 'gesmew/layouts/admin'
#
#   include Gesmew::Core::ControllerHelpers
#
#   def show
#     # @inspections = @user.inspections.complete.order('completed_at desc')
#   end
#
#   def create
#     @user = Gesmew::User.new(user_params)
#     if @user.save
#       redirect_back_or_default(root_url)
#     else
#       render :new
#     end
#   end
#
#   def update
#     if @user.update_attributes(user_params)
#       if params[:user][:password].present?
#         # this logic needed b/c devise wants to log us out after password changes
#         user = Gesmew::User.reset_password_by_token(params[:user])
#         sign_in(@user, :event => :authentication, :bypass => !Gesmew::Auth::Config[:signout_after_password_change])
#       end
#       redirect_to gesmew.account_url, :notice => Gesmew.t(:account_updated)
#     else
#       render :edit
#     end
#   end
#
#   private
#     def user_params
#       params.require(:user).permit(Gesmew::PermittedAttributes.user_attributes)
#     end
#
#     def load_object
#       @user ||= gesmew_current_user
#       authorize! params[:action].to_sym, @user
#     end
#
#     def authorize_actions
#       authorize! params[:action].to_sym, Gesmew::User.new
#     end
#
#     def accurate_title
#       Gesmew.t(:my_account)
#     end
# end
