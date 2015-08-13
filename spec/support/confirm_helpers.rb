module ConfirmHelpers
  def set_confirmable_option(value)
    Gesmew::Auth::Config[:confirmable] = value
    Gesmew.send(:remove_const, 'User')
    load File.expand_path("../../../app/models/gesmew/user.rb", __FILE__)
  end
end

RSpec.configure do |c|
  c.include ConfirmHelpers
end