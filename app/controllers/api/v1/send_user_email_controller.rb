class Api::V1::SendUserEmailController < ApplicationController
  def call
    operation = SendUserEmail::CallOperation.call(
      params: call_params.to_unsafe_h,
      contract: Api::V1::SendUserEmailContract
    )

    if operation.success?
      render json: { send_email: 'success' }, status: :ok
    else
      render json: { errors: operation.errors }, status: :unprocessable_entity
    end
  end

  private

  def call_params
    params.require(:send_user_email)
          .permit(:email, :name, :last_name, :company_name, :event, :application, :quote_title, :agreement_title, :link)
  end
end
