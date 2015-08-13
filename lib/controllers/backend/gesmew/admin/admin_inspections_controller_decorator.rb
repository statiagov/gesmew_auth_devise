Gesmew::Admin::InspectionsController.class_eval do
  before_filter :check_authorization

  private
    def load_inspection_action
      [:edit, :update, :cancel, :resume, :approve, :resend, :open_adjustments, :close_adjustments, :cart]
    end

    def check_authorization
      action = params[:action].to_sym
      if load_inspection_action.include?(action)
        load_inspection
        session[:access_token] ||= params[:token]
        resource = @inspection || Gesmew::Inspection.new
        authorize! action, resource, session[:access_token]
      else
        authorize! :index, Gesmew::Inspection
      end
    end
end
