class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :update, :destroy]

  # GET /leagues
  def index
    if league_params[:latitude] && league_params[:longitude]
      range = params[:range] || 5 # in miles
      @leagues = League.near([params[:latitude],params[:longitude]],range)
    else
      @leagues = League.all
    end

   if league_params[:budget]
     budget = league_params[:budget].to_i
     @leagues = @leagues.sort_by(&:price)
     total_spend = 0
     i = 0
     while i < @leagues.length
       total_spend += @leagues[i].price
       puts total_spend,'total_spend'
       break if total_spend > budget
       i+=1
     end
     @leagues = @leagues.slice!(0, i)
   end

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
      params.permit(:name, :price, :latitude, :longitude, :budget, :range)
    end
end
