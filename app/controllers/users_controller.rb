# app/controllers/users_controller.rb

class UsersController < ApplicationController

  def new
  end
  
  def create
    password_digest = BCrypt::Password.create(user_params[:password_digest])
    puts "---------------------- #{password_digest}"
    @user = User.new(user_params)
    @user.password_digest = password_digest
    # p "Testing users --------------- #{@user.inspect}"
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      puts "create user field ................"
      redirect_to '/signup'
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password_digest)
  end

end