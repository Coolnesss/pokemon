class PokesController < ApplicationController
  before_action :set_poke, only: [:show, :edit, :update, :destroy]
  before_action :check_if_admin, only: [:update, :destroy]

  def index
    @pokemons = Poke.sqlAll
  end

  def show
    @evolutions = JSON.parse(Pokegem.get("pokemon", @poke.name.downcase))["evolutions"]
    @types = JSON.parse(Pokegem.get("pokemon", @poke.name.downcase))["types"]
    if (current_user and current_user.has_poke_in_list? @poke) then
      @user_poke = UserPoke.find_by_poke_and_user(current_user.user_id, @poke.poke_id)
    else
      @user_poke = UserPoke.new
      @user_poke.poke = @poke
    end
  end

  def search
    if params[:search].nil? then @pokes = Poke.sqlAll
    else @pokes = Poke.search params[:search] end
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
      @poke = Poke.find_by_id(params[:id]).first
    end

    def poke_params
      params.require(:poke).permit(:name)
    end

    def check_if_admin
      current_user && current_user.admin?
    end
end
