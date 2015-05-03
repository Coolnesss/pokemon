class UsersController < ApplicationController
  require 'bcrypt'
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_if_current_user, only: [:edit, :destroy]

  def index
    @users = User.sqlAll
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_path, notice: "User destroyed"
    @user.destroySql
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
        session[:user_id] = @user.id
        redirect_to @user, notice: 'User was successfully created.'
      else
        redirect_to :back, notice: "Too short username or password mismatch"
      end
  end

  def show
    redirect_to root_path unless not @user.nil?
  end

  private

  def check_if_current_user
    redirect_to :back, notice: "You can't modify other users" unless (current_user and session[:user_id] == params[:id].to_i)
  end

  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
