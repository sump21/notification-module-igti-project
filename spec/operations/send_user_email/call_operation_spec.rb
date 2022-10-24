RSpec.describe SendUserEmail::CallOperation do
  before do
    create(:application, name: 'quote_application')
    create(:application, name: 'login_application')
    create(:application, name: 'agreements_application')
    create(:events_notification, event: 'new_agreement')
    create(:events_notification, event: 'update_quote')
    create(:events_notification, event: 'forgot_password')
  end

  let(:operation_result) { described_class.call(params:, contract: Api::V1::SendUserEmailContract) }

  context 'when event new_agreement in params' do
    let(:params) do
      {
        "email": 'raphael.rsn.123@gmail.com',
        "name": 'Raphael',
        "last_name": 'Test',
        "company_name": 'CompanyTest',
        "event": 'new_agreement',
        "application": 'agreements_application',
        "agreement_title": 'Agreement Title',
        "link": 'url_to_agreement'
      }
    end

    it 'event new_agreement' do
      expect(operation_result.success?).to eq(true)
    end
  end

  context 'when event update_quote in params' do
    let(:params) do
      {
        "email": 'raphael.rsn.123@gmail.com',
        "name": 'Raphael',
        "last_name": 'Test',
        "company_name": 'CompanyTest',
        "event": 'update_quote',
        "application": 'quote_application',
        "quote_title": 'Quote Title',
        "link": 'url_to_quote'
      }
    end

    it 'event update_quote' do
      expect(operation_result.success?).to eq(true)
    end
  end

  context 'when event forgot_password in params' do
    let(:params) do
      {
        "email": 'raphael.rsn.123@gmail.com',
        "name": 'Raphael',
        "last_name": 'Test',
        "company_name": 'CompanyTest',
        "event": 'forgot_password',
        "application": 'login_application',
        "link": 'url_to_forgot_password'
      }
    end

    it 'event forgot_password' do
      expect(operation_result.success?).to eq(true)
    end
  end

  context 'when invalid params' do
    let(:params) do
      {
        "name": 'Raphael',
        "last_name": 'Test',
        "company_name": 'CompanyTest',
        "event": 'invalid',
        "application": 'invalid',
        "link": 'url_to_forgot_password'
      }
    end

    it 'return failed' do
      expect(operation_result.success?).to eq(false)
    end

    it 'return error' do
      expect(operation_result.errors).to eq({
                                              application: ['Application not exists'],
                                              email: ['is missing'],
                                              event: ['Event not exists']
                                            })
    end
  end
end
