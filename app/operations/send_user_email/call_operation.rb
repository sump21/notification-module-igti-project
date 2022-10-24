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
    when 'update_quote'
      logs(params[:application], params[:event])
      SendUserEmailMailer.with(params).quote_update.deliver_later
    when 'forgot_password'
      logs(params[:application], params[:event])
      SendUserEmailMailer.with(params).forgot_password.deliver_later
    when 'new_agreement'
      logs(params[:application], params[:event])
      SendUserEmailMailer.with(params).new_agreement.deliver_later
    end
  end

  def logs(app_name, event_name)
    application = Application.find_by(name: app_name)
    event_notification = EventsNotification.find_by(event: event_name)
    log = LogsNotification.new
    log.application_id = application.id
    log.events_notification_id = event_notification.id
    log.save!
  end
end
