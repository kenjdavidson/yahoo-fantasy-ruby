module CurrentUser
  extend ActiveSupport::Concern

  def current_user
    User.find_by(uid: session['uid'])
  end
end
