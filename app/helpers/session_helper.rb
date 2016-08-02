helpers do

  def logged_in?
    session[:user_id] != nil
  end

  def current_user
    @_cached_user ||= User.find(session[:user_id]) if logged_in?
  end

  def authorize!
    redirect '/users/login' unless logged_in?
  end

end
