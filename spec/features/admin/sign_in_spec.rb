RSpec.feature 'Admin - Sign In', type: :feature, js:true do

  background do
    @user = create(:admin_user, email: 'email@person.com')
    visit gesmew.admin_login_path
  end

  scenario 'asks user to sign in' do
    visit gesmew.admin_path
    expect(page).not_to have_text 'Authorization Failure'
  end

  scenario 'lets a user sign in successfully' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'secret'
    click_button 'Login'
    find("a.dropdown-toggle").click

    expect(page).to have_text 'Logged in successfully'
    expect(page).not_to have_text 'Login'
    expect(page).to have_text 'Logout'
    expect(current_path).to eq '/admin/inspections'
  end

  scenario 'shows validation errors' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'wrong_password'
    click_button 'Login'

    expect(page).to have_text 'Invalid email or password'
    expect(page).to have_button 'Login'
  end
end
