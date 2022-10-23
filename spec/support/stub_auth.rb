class StubAuth
  def authorize(spec, controller)
    spec.allow_any_instance_of(controller).to(spec.receive(:authentication_app))
  end

  def unauthorize(spec, controller)
    spec.allow_any_instance_of(controller).to(spec.receive(:authentication_app)).and_call_original
  end
end
