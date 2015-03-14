class PokesController < ApplicationController

  def index
    @pokemons = Poke.sqlAll
  end

  def show
    @poke = Poke.find_by_id(params[:id])
  end

end
