RSpec.describe ApplicationController, type: :controller do
  before do
    stub_auth.authorize(self, described_class)
    Rails.application.routes.draw { post '/test' => 'application#test' }
  end

  after do
    Rails.application.reload_routes!
    described_class.remove_method('test')
  end

  describe 'Authorization' do
    context 'when application not authorized' do
      before do
        stub_auth.unauthorize(self, described_class)
        described_class.define_method('test', proc { nil })
      end

      it 'client_app or client_secret not declared' do
        post 'test'

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'client_app and client_secret declared, but incorrect' do
        request.env['HTTP_CLIENT_APP'] = 'TestApp'
        request.env['HTTP_CLIENT_SECRET'] = 'TestSecret'
        post 'test'

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  private

  def stub_auth
    @stub_auth ||= StubAuth.new
  end
end
