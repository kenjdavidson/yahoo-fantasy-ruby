class SessionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :out_of_bounds

  # When providing the OOB form it's important that either the `state` is provided or that
  # the configuration sets `provider_ignores_state=true` (assumed CSRF).
  #
  def out_of_bounds
    render_with redirect_url: request.env['omniauth.redirect_url'],
                callback_path: request.env['omniauth.callback_path'],
                state: session['omniauth.state']
  end

  def auth_failure
    render_with error: request.env['omniauth.error']
  end

  def create
    user = find_or_create_user
    user.credentials = create_credentials
    user.save

    session[:uid] = user.uid
    logger.debug "set session uid: #{user.uid}"

    render_with user: user
  end

  def destroy
    user = User.include(:credential).by_uid(session[:uid])
    user.credential.destroy if user&.credential

    session.delete(:uid)
    redirect_to root_path
  end

  private

  def find_or_create_user
    omniauth = request.env['omniauth.auth']
    logger.debug "finding or creating User by #{omniauth}"

    User.find_or_create_by(uid: omniauth['uid']) do |u|
      u.first_name = omniauth['given_name']
      u.first_name = omniauth['family_name']
      u.nickname = omniauth['nickname']
      u.location = omniauth['location']
      u.image = omniauth['picture']
    end
  end

  def create_credentials
    omniauth = request.env['omniauth.auth']
    logger.debug "finding or creating Credential by #{omniauth}"

    Credential.new(
      access_token: omniauth['access_token'],
      refresh_token: omniauth['refresh_token'],
      expires_at: omniauth['expires_at']
    )
  end
end
