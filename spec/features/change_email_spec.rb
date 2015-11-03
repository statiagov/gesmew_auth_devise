RSpec.feature 'Change email', type: :feature, js:true do

  background do
    user = create(:user)
    visit gesmew.root_path

    click_link 'Login'

    fill_in 'gesmew_user[email]', with: user.email
    fill_in 'gesmew_user[password]', with: 'secret'
    click_button 'Login'

    visit gesmew.edit_account_path(user)
  end

  scenario 'work with correct password' do
    fill_in 'user_email', with: 'tests@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Update'
    expect(page).to have_text 'Account updated'
  end
end
