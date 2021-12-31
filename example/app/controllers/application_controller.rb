class ApplicationController < ActionController::Base
  protected

  def render_with(locals = {})
    render locals: locals
  end
end
