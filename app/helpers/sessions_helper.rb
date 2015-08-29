module SessionsHelper
  #define create_session. create_session sets user_id on the session object to user.id
  def create_session(user)
    session[:user_id] = user.id
  end
  #define destroy_session. We clear the user id on the session object by setting it to nil, which effectively destroys the user session
  def destroy_session(user)
    session[:user_id] = nil
  end
  #define current_user, which returns the current user of the application.
  def current_user
    User.find_by(id: session[:user_id])
  end
end
