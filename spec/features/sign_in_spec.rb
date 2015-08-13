RSpec.feature 'Sign In', type: :feature, js:true do

  background do
    @user = create(:user, email: 'email@person.com', password: 'secret', password_confirmation: 'secret')
    visit gesmew.login_path
  end

  scenario 'ask user to sign in' do
    visit gesmew.admin_path
    expect(page).not_to have_text 'Authorization Failure'
  end

  scenario 'let a user sign in successfully' do
    @user.gesmew_roles << Gesmew::Role.find_or_create_by(name: 'admin')
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Login'

    find("a.dropdown-toggle").click
    expect(page).to have_text 'Logged in successfully'
    expect(page).to have_text @user.email
    expect(page).not_to have_text 'Login'
    expect(page).to have_text 'Logout'

    expect(current_path).to eq '/admin/inspections'
  end

  scenario 'show validation errors' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'wrong_password'
    click_button 'Login'

    expect(page).to have_text 'Invalid email or password'
    expect(page).to have_text 'Login'
  end
  it "should store the user previous location" do
    pending("not implemented as yet")
    fail
  end
end
