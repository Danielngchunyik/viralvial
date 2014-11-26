class ScoresWorker
  include Sidekiq::Worker

  def perform()
    User.set_social_scores
  end
end