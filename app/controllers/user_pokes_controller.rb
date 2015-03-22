class UserPokesController < ApplicationController
  before_action :set_user_poke, only: [:show, :edit, :update, :destroy]



  def new
    @user_poke = UserPoke.new
  end

  def create
    @user_poke = UserPoke.new(user_poke_params)
    respond_to do |format|
      current_user.user_pokes << @user_poke
      if @user_poke.save
        format.html { redirect_to @user_poke.user, notice:
          "Success" }
          format.json { render :show, status: :created, location: @user_poke }
        else
          format.html { render :new }
          format.json { render json: @user_poke.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user_poke.destroy
      respond_to do |format|
        format.html { redirect_to current_user, notice: "Pokemon removed from list" }
        format.json { head :no_content }
      end
    end

  private

  def set_poke
    @user_poke = UserPoke.find_by_id(params[:user_poke_id])
  end

  def user_poke_params
    params.require(:user_poke).permit(:user_id, :poke_id)
  end

end
