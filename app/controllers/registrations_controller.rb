class RegistrationsController < Devise::RegistrationsController
  # Needed by devise to authenticate the user after registration and return the auth token
  prepend_before_action :allow_params_authentication!, only: :create

  respond_to :json

  # Sign in after sign up
  def sign_up(resource_name, resource)
    resource = warden.authenticate!
    sign_in(resource_name, resource)
  end

  # By default devise tries to build the resources with a session like this:
  # resource_class.new_with_session(hash, session)
  # but because we are on API mode we don't have a session so we need to build the user
  # without it
  def build_resource(hash = {})
    self.resource = resource_class.new(hash)
  end
end
