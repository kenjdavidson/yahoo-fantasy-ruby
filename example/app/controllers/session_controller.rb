# Controller provides functionality for:
#
# Out of Bounds Login
# The login processing provided in this example uses the `oob` (out of bounds) callback_url which allows Yahoo to bypass
# the callback functionality and allow the user to manually provide the `code`.
#
# Session Start
# When a session is first started (ie. the user logs in through Yahoo!) their user is either retreived or created.  The
# session is then updated with the users `uid`.
#
# Session End
# Upon logging out the users credentials and session are destroyed.  Note that the user profile remains behind for future
# logins.  In order to delete the full profile, @see ProfileController
#
class SessionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :out_of_bounds

  def out_of_bounds
    render_with redirect_url: request.env['omniauth.redirect_url'],
                callback_path: request.env['omniauth.callback_path'],
                state: session['omniauth.state']
  end

  def auth_failure
    render_with error: request.env['omniauth.error']
  end

  def create
    user = find_or_create_user(request.env['omniauth.auth'])
    user.update_credential(create_credential(request.env['omniauth.auth']))

    session[:uid] = user.uid

    redirect_to controller: :profile, action: :edit
  end

  def destroy
    user = User.include(:credential).by_uid(session[:uid])
    user.credential.destroy if user&.credential

    session.delete(:uid)
    redirect_to root_path
  end

  private

  def find_or_create_user(omniauth)
    logger.debug "finding or creating User #{omniauth['uid']} with info: #{omniauth['info']}"

    User.find_or_create_by(uid: omniauth['uid']) do |u|
      u.first_name = omniauth['info']['first_name']
      u.last_name = omniauth['info']['last_name']
      u.nickname = omniauth['info']['nickname']
      u.location = omniauth['info']['location']
      u.image = omniauth['info']['picture']
    end
  end

  def create_credential(omniauth)
    logger.debug "creating Credential with #{omniauth['credentials']}"

    Credential.new(
      access_token: omniauth['credentials']['token'],
      refresh_token: omniauth['credentials']['refresh_token'],
      expires_at: omniauth['credentials']['expires_at']
    )
  end
end
