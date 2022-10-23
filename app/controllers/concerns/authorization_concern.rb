module AuthorizationConcern
  def authentication_app
    client_app = request.headers['HTTP_CLIENT_APP'] if request.headers['HTTP_CLIENT_APP'].present?
    secret_key = request.headers['HTTP_CLIENT_SECRET'] if request.headers['HTTP_CLIENT_SECRET'].present?

    validate_credentials(client_app, secret_key)
  end

  private

  def validate_credentials(client_app, secret_key)
    if client_app.blank? || secret_key.blank?
      render json: {
        error: 'CLIENT_APP or CLIENT_SECRET header not declared'
      }, status: :unprocessable_entity
    elsif authorizer[client_app].nil? || authorizer[client_app]['secret_key'] != secret_key
      render json: { error: 'Access Denied' }, status: :unauthorized
    end
  end

  def authorizer
    @authorizer ||= Rails.application.secrets.services.as_json
  end
end
