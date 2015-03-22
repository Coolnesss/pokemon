class PokesController < ApplicationController
  before_action :set_poke, only: [:show, :edit, :update, :destroy]

  def index
    @pokemons = Poke.sqlAll
  end

  def show
    @user_poke = UserPoke.new
    @user_poke.poke = @poke
  end

  def new
    @poke = Poke.new
  end

  def create
    @poke = Poke.new(poke_params)

    respond_to do |format|
      if @poke.save
        format.html { redirect_to @poke, notice: 'Pokemon was successfully created.' }
        format.json { render :show, status: :created, location: @poke }
      else
        format.html { render :new }
        format.json { render json: @poke.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    def set_poke
      @poke = Poke.find_by_id(params[:id])
    end

    def poke_params
      params.require(:poke).permit(:name)
    end

end
