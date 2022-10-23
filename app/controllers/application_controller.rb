class ApplicationController < ActionController::API
  include AuthorizationConcern

  before_action :authentication_app
end
