module ValidationContract
  def validate!(context)
    context.validate_result = context.contract.new.call(context.params)

    if context.validate_result.errors.any?
      context.fail!(
        errors: context.validate_result.errors.to_h
      )
    end
  end
end
