class SendUserEmail::CallOperation
  include Interactor
  include ValidationContract

  delegate :params, :contract, to: :context

  def call
    validate!(context)
    find_template_by_event!
  end

  private

  def find_template_by_event!
    case params[:event]
    when 'quote_update'
      SendUserEmailMailer.with(params).quote_update.deliver_later
    when 'forgot_password'
      SendUserEmailMailer.with(params).forgot_password.deliver_later
    when 'new_agreement'
      SendUserEmailMailer.with(params).new_agreement.deliver_later
    else
      context.fail!(errors: 'Not send email')
    end
  end
end
