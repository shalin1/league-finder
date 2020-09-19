class LeaguesController < ApplicationController
  before_action :set_league, only: [:show]

  # GET /leagues
  def index
    # filter leagues by proximity to lat/long if params provided
    if league_params[:latitude].nil? || league_params[:longitude].nil? && league_params[:range].nil?
      @leagues = League.all
    else
      @leagues = League.near([params[:latitude],params[:longitude]],params[:range])
    end

    # render leagues filtered tot a set that fits within  budget if param provided
    budget = league_params[:budget]
    if budget.nil?
      render json: @leagues
    else
      render json: LeaguesFilteredByRecommendedForBudget.call(leagues:@leagues, budget:budget)
    end
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

  # POST /leagues/:id
  def show
    render json: @league
  end

  private

  def set_league
    @league = League.find(params[:id])
  end

  def league_params
    params.permit(:name, :price, :latitude, :longitude, :budget, :range)
  end
end
