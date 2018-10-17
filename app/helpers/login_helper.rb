module LoginHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id] if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def current_user? user
    user == current_user
  end

  def admin?
    current_user.position_id == 1
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def login_require
    return if logged_in?
    store_location
    flash[:danger] = t "login_require"
    redirect_to login_url
  end

  # always go with login_require
  def admin_require
    return if current_user.position_id == 1
    flash[:danger] = t "admin_require"
    redirect_to root_path
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
