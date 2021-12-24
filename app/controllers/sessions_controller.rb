class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_to_on_destroy
    head :ok
  end
end
