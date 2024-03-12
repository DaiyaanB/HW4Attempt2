class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Hello, Thank you for logging in!"
        redirect_to "/places"
      else
        flash["notice"] = "Error with credentials, try again!"
        redirect_to "/login"
      end
    else
      flash["notice"] = "No account with this email exists!"
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "You have logged out succesfully!"
    redirect_to "/login"
  end
end
