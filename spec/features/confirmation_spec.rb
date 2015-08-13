require 'spec_helper'

feature 'Confirmation' do
  before do
    set_confirmable_option(true)
    Gesmew::UserMailer.stub(:confirmation_instructions).and_return(double(deliver: true))
  end

  after(:each) { set_confirmable_option(false) }

  background do
    ActionMailer::Base.default_url_options[:host] = 'http://example.com'
  end

  scenario 'create a new user' do
    pending("not implemented as yet")
    fail
  end
end
