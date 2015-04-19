class UserPokesController < ApplicationController
  before_action :set_user_poke, only: [:show, :edit, :update, :destroy]

  def new
    @user_poke = UserPoke.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if UserPoke.validate?(user_poke_params)
        @user_poke.updateSql(user_poke_params)
        format.html { redirect_to @user_poke.user, notice: 'Pokemon was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_poke.poke }
      else
        @error = 'Annoit virheellisiä arvoja.';
        format.html { render :edit }
        format.json { render json: @user_poke.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    respond_to do |format|
        UserPoke.createSql(current_user.user_id, user_poke_params["poke_id"])
        format.html { redirect_to current_user, notice: "Success" }
        format.json { render :show, status: :created, location: @user_poke.user }
    end
  end

    def destroy
      respond_to do |format|
        UserPoke.destroySql(params[:id])
        format.html { redirect_to current_user, notice: "Pokemon removed from watchlist" }
        format.json { head :no_content }
      end
    end

  private

  def set_user_poke
    @user_poke = UserPoke.find_by user_poke_id:(params[:id])
  end

  def user_poke_params
    params.require(:user_poke).permit(:user_id, :poke_id, :ev, :level)
  end

end
