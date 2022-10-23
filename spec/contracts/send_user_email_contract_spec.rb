RSpec.describe Api::V1::SendUserEmailContract do
  describe 'Validate params' do
    let(:validate_result) { described_class.new.call(params) }

    let(:valid_params) do
      {
        email: 'test@test.test',
        name: 'Name',
        last_name: 'Test',
        company_name: 'Company Test',
        event: 'new_quote',
        application: 'quote_application',
        details: "{quote_title: 'Quote Test'}"
      }
    end

    before do
      create(:application, name: 'quote_application')
      create(:events_notification, event: 'new_quote')
    end

    context 'when valid params' do
      let(:params) { valid_params }

      it 'should success with params valid' do
        expect(validate_result.success?).to eq(true)
      end
    end

    context 'when invalid email' do
      let(:params) do
        valid_params['email'] = 'NotEmail'
        valid_params
      end

      it 'should return failure ' do
        expect(validate_result.success?).to eq(false)
      end

      it 'should failed if email not valid' do
        expect(validate_result.errors.to_h).to eq(email: ['has invalid format'])
      end
    end
  end
end
