class Api::V1::SendUserEmailContract < Dry::Validation::Contract
  params do
    required(:email).filled(:string)
    required(:name).filled(:string)
    required(:last_name).filled(:string)
    required(:company_name).filled(:string)
    required(:event).filled(:string)
    required(:application).filled(:string)
    optional(:quote_title).filled(:string)
    optional(:agreement_title).filled(:string)
    optional(:link).filled(:string)
  end

  rule(:email) do
    key.failure('has invalid format') unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
  end

  rule(:event) { key.failure('Event not exists') unless EventsNotification.exists?(event: value) }

  rule(:application) { key.failure('Application not exists') unless Application.exists?(name: value) }
end
