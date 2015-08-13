RSpec.describe Gesmew::UsersController, type: :controller do

  let(:admin_user) { create(:confirmed_user) }
  let(:user) { create(:user) }
  let(:role) { create(:role) }

  before { allow(controller).to receive(:gesmew_current_user) { user } }

  context '#load_object' do
    it 'redirects to signup path if user is not found' do
      allow(controller).to receive(:gesmew_current_user) { nil }
      gesmew_put :update, { user: { email: 'foobar@example.com' } }
      expect(response).to redirect_to gesmew.login_path
    end
  end

  context '#create' do
    it 'creates a new user' do
      gesmew_post :create, { user: { email: 'foobar@example.com', password: 'foobar123', password_confirmation: 'foobar123' } }
      expect(assigns[:user].new_record?).to be false
    end
  end

  context '#update' do
    context 'when updating own account' do
      it 'performs update' do
        put :update, { user: { email: 'mynew@email-address.com' } }
        # expect(assigns[:user].email).to eq 'mynew@email-address.com'
        expect(response).to redirect_to gesmew.account_url(only_path: true)
      end
    end

    it 'does not update roles' do
      gesmew_put :update, user: { gesmew_role_ids: [role.id] }
      expect(assigns[:user].gesmew_roles).to_not include role
    end
  end
end
