class UsersController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = User.find_by(uid: auth_hash[:uid], provider: auth_hash['provider'])
      if user.nil?
        user = User.new(uid: auth_hash[:uid],
                        provider: auth_hash[:provider],
                        username: auth_hash[:info][:name],
                        email: auth_hash[:info][:email]
                      )
        if user.save
          flash[:status] = :success
          flash[:result] = "Welcome #{user.username}"
        else
          flash[:status] = :failure
          flash[:result] = "Unable to save user"
        end
      else
        flash[:status] = :success
        flash[:result] = "Logged in successfully"
      end
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:status] = :failure
      flash[:result] = "Could not log in"
      redirect_to root_path
    end
  end

  def logout
    if session[:user_id]
      session[:user_id] = nil
      flash[:status] = :success
      flash[:result] = "Successfully logged out"
    end
    redirect_to root_path
  end
end
