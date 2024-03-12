require 'bcrypt'

class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = BCrypt::Password.create(params[:password])
    
    # Check if the email is already present in the database
    if User.exists?(email: @user.email)
      flash[:notice] = "Email already exists. Please use a different email."
      redirect_to "/users/new" and return
    end

    if @user.save
      flash[:notice] = "Thanks for signing up. Now login."
      redirect_to "/login"
    else
      flash[:notice] = "Failed to create user. Please try again."
      render :new
    end
  end
end
