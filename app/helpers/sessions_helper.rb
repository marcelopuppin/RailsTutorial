module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    #cookies.permanent[:remember_token] = user.remember_token
    current_user=user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session[:user_id] = nil
    #cookies.delete :remember_token
    current_user=nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_session_id
    #@current_user ||= user_from_remember_token
  end

  def current_user?(user)
      user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  private

    def user_from_session_id
      user_id = session[:user_id]
      User.find(user_id) unless user_id.nil?
    end

    def clear_return_to
      session.delete(:return_to)
    end

    #def user_from_remember_token
    #  remember_token = cookies[:remember_token]
    #  User.find_by_remember_token(remember_token) unless remember_token.nil?
    #end

end
