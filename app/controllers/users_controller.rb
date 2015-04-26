class UsersController < ApplicationController
  require 'bcrypt'
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if User.validate?(user_params)
      password_salt = BCrypt::Engine.generate_salt
      password = BCrypt::Engine.hash_secret(user_params["password"], password_salt)
      @user.updateSql(password, password_salt)
      redirect_to @user, notice: "User was successfully updated"
    else
      redirect_to :back, notice: "Passwords don't match"
    end
  end

  def create
      if User.validate?(user_params)
        if not User.find_by_username(user_params["username"]).nil?
          redirect_to :back, notice: "Username taken, pick a new one"
          return
        end
        password_salt = BCrypt::Engine.generate_salt
        password = BCrypt::Engine.hash_secret(user_params["password"], password_salt)
        User.createSql(user_params, password, password_salt)
        @user = User.find_by_username!(user_params[:username])
        redirect_to @user, notice: 'User was successfully created.'
      else
        redirect_to :back, notice: "Too short username or password mismatch"
      end
  end

  def show
  end

  private
  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
