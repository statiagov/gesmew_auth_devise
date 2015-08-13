# RSpec.describe Gesmew::UserMailer, type: :mailer do
#   let(:user) { create(:user) }
#
#   before do
#     user = create(:user)
#     Gesmew::UserMailer.reset_password_instructions(user, 'token goes here').deliver_later
#     @message = ActionMailer::Base.deliveries.last
#   end
#
#   describe '#reset_password_instructions' do
#     describe 'message contents' do
#       before do
#         described_class.reset_password_instructions(user, 'token goes here').deliver_later
#         @message = ActionMailer::Base.deliveries.last
#       end
#
#       context 'subject includes' do
#         it 'translated devise instructions' do
#           expect(@message.subject).to include(
#             I18n.t(:subject, scope: [:devise, :mailer, :reset_password_instructions])
#           )
#         end
#       end
#
#       context 'body includes' do
#         it 'password reset url' do
#           expect(@message.body.raw_source).to include "user/gesmew_user/password/edit"
#         end
#       end
#     end
#
#     describe 'legacy support for User object' do
#       it 'sends an email' do
#         expect {
#           described_class.reset_password_instructions(user, 'token goes here').deliver_later
#         }.to change(ActionMailer::Base.deliveries, :size).by(1)
#       end
#     end
#   end
# end
