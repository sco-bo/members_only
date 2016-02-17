class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user
  #This logs the user in, giving them a temporary 
  #session and encrypting their user.id as the session[:user_id]
  def log_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end

  #This gives the user a new token, saving the digest to the database
  #It then adds that user's user.id to the permanent cookies and 
  #adds the new token to the permanent cookies
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      current_user=(user)
    else
      @current_user = nil
    end
  end

  def current_user=(user)
    if user && user.authenticated?(cookies[:remember_token])
      log_in user 
      @current_user = user
    end
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
