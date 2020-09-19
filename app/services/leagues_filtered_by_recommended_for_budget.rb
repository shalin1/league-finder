class LeaguesFilteredByRecommendedForBudget
  def initialize(leagues:,budget:)
    @leagues = leagues.sort_by(&:price)
    @budget = budget.to_i
  end

  def self.call(leagues:,budget:)
    new(leagues: leagues, budget:budget).call
  end

  def call
    total_spend = 0

    @leagues.each_with_index do |league,idx|
      total_spend += league.price
      return @leagues.slice(0,idx) if total_spend > @budget
    end

    @leagues
  end
end