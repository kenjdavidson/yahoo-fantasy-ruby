class UserController < ApplicationController
  include CurrentUser

  def edit
    render_with user: current_user
  end

  def update; end

  def destroy; end
end
