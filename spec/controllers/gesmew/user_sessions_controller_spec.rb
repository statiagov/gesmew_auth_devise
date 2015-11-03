RSpec.describe Gesmew::UserSessionsController, type: :controller do

  let(:user) { create(:user) }

  before { @request.env['devise.mapping'] = Devise.mappings[:gesmew_user] }

  context "#create" do
    context "using correct login information" do
      context "and html format is used" do
        it "redirects to inspections listing after signing in" do
          gesmew_post :create, gesmew_user: { email: user.email, password: 'secret' }
          expect(response).to redirect_to gesmew.admin_inspections_path
        end
      end

      context "and js format is used" do
        it "returns a json string with the user and contact information" do
          gesmew_post :create, gesmew_user: { email: user.email, password: 'secret' }, format: 'js'
          parsed = ActiveSupport::JSON.decode(response.body)
          expect(parsed).to have_key("user")
        end
      end
    end

    context "using incorrect login information" do
      context "and html format is used" do
        it "renders new template again with errors" do
          gesmew_post :create, gesmew_user: { email: user.email, password: 'wrong' }
          expect(response).to render_template('new')
          expect(flash[:error]).to eq I18n.t(:'devise.failure.invalid')
        end
      end

      context "and js format is used" do
        it "returns a json with the error" do
          gesmew_post :create, gesmew_user: { email: user.email, password: 'wrong' }, format: 'js'
          parsed = ActiveSupport::JSON.decode(response.body)
          expect(parsed).to have_key("error")
        end
      end
    end
  end
end
