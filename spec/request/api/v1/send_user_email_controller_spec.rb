RSpec.describe 'Send email to user request', type: :request do
  before do
    create(:application, name: 'quote_application')
    create(:application, name: 'login_application')
    create(:application, name: 'agreements_application')
    create(:events_notification, event: 'new_agreement')
    create(:events_notification, event: 'update_quote')
    create(:events_notification, event: 'forgot_password')
    StubAuth.new.authorize(self, Api::V1::SendUserEmailController)
  end

  let(:call_route) { post '/api/v1/send_user_email/call', params: }

  context 'when send email to user' do
    let(:params) do
      {
        "send_user_email": {
          "email": 'raphael.rsn.123@gmail.com',
          "name": 'Raphael',
          "last_name": 'Test',
          "company_name": 'CompanyTest',
          "event": 'forgot_password',
          "application": 'login_application',
          "link": 'url_to_forgot_password'
        }
      }
    end

    before { call_route }

    it 'return success' do
      expect(response).to have_http_status(:success)
    end

    it 'return response body' do
      expect(JSON.parse(response.body)).to eq('send_email' => 'success')
    end
  end

  context 'when send email results in failure' do
    let(:params) do
      {
        "send_user_email": {
          "email": 'raphael.rsn.123@gmail.com',
          "name": 'Raphael',
          "last_name": 'Test',
          "company_name": 'CompanyTest',
          "event": 'error',
          "application": 'login_application',
          "link": 'url_to_forgot_password'
        }
      }
    end

    before { call_route }

    it 'return unprocessable entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'return errors' do
      expect(JSON.parse(response.body)).to eq('errors' => { 'event' => ['Event not exists'] })
    end
  end
end
