FactoryBot.define do
  factory :events_notification do
    event { 'forgot_password' }
    action { 'send_email' }
  end
end
