task update_viral_score: :environment do
  SocialScore::CalculatePercentile.new.perform
end