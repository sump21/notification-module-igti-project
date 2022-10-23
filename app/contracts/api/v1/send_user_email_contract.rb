class Api::V1::SendUserEmailContract < Dry::Validation::Contract
  params do
    required(:email).filled(:string)
    required(:name).filled(:string)
    required(:last_name).filled(:string)
    required(:company_name).filled(:string)
    required(:event).filled(:string)
    required(:application).filled(:string)
    required(:details).filled(:string)
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('has invalid format')
    end
  end

  rule(:event) { key.failure('Event not exists') unless EventsNotification.exists?(event: value) }

  rule(:application) { key.failure('Application not exists') unless Application.exists?(name: value) }
end
