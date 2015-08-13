# For the API
ActionController::Metal.class_eval do
  def gesmew_current_user
    @gesmew_current_user ||= env['warden'].user
  end
end
