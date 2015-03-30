class Tier::RewardMultiplier
# Reward Multiplier is defined here
  attr_accessor :score

  def get(score)

    case score

    # Tier 1 - 100%
    when 81..100 
      1

    # Tier 2 - 50%
    when 71..80 
      0.5

    # Tier 3 - 25%
    when 61..70 
      0.25

    # Tier 4 - 12.5%
    when 51..60 
      0.125

    # Tier 5 - 2.5%
    when 26..50 
      0.025 

    # Tier 6 - 0.83%
    when 0..25 
      0.0083 
    end
  end
end
