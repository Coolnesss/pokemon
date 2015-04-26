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

  end

  def create
    #@user = User.new(user_params)

    respond_to do |format|
      if User.validate?(user_params)
        password_salt = BCrypt::Engine.generate_salt
        password = BCrypt::Engine.hash_secret(user_params["password"], password_salt)
        User.createSql(user_params, password, password_salt)
        @user = User.find_by_username(user_params[:username])
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
