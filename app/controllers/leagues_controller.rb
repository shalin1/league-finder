class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :update, :destroy]

  # GET /leagues
  def index
    @leagues = League.all
    if(league_params[:latitude] && league_params[:longitude])
      @leagues = League.near([params[:latitude],params[:longitude],params[:range] || 5])
    end
    puts league_params[:budget] if(league_params[:budget])
    render json: @leagues
  end

  # GET /leagues/1
  def show
    puts @league.location
    render json: @league
  end

  # POST /leagues
  def create
    @league = League.new(league_params)

    if @league.save
      render json: @league, status: :created, location: @league
    else
      render json: @league.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /leagues/1
  def update
    if @league.update(league_params)
      render json: @league
    else
      render json: @league.errors, status: :unprocessable_entity
    end
  end

  # DELETE /leagues/1
  def destroy
    @league.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def league_params
      puts params
      params.permit(:league, :name, :price, :latitude, :longitude, :budget)
    end
end
