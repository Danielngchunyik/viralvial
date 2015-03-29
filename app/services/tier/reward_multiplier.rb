class Tier::RewardMultiplier
# Reward Multiplier is defined here
  attr_accessor :score

  def get(score)

    case score

    when 0..25 
      0.0083
    when 26..50 
      0.025
    when 51..60 
      0.125
    when 61..70 
      0.25
    when 71..80 
      0.5
    when 81..100 
      1
    end
  end
end
