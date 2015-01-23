class Campaign < ActiveRecord::Base
  include Campaigns::Filters
  include Campaigns::Invitations
  extend Campaigns::Filters::ClassMethods
  extend Campaigns::Invitations::ClassMethods

  acts_as_taggable
  acts_as_taggable_on :categories, :religions, :races, :countries,
                      :marital_status
  acts_as_taggable_on :invitations, :username

  store_accessor :criteria, :min_age, :max_age, :min_socialite_score,
                 :max_socialite_score, :language

  has_many :topics
  has_many :posts
  validates :title, :description, presence: true
  validate :at_least_one_topic_required
  enum language: [:unspecified, :chinese, :english, :malay]

  accepts_nested_attributes_for :topics, allow_destroy: true
  mount_uploader :image, ImageUploader
  
  def time_remaining
    endTime = self.end_date.to_time
    timeDifference = endTime - Time.now    
    if timeDifference <= 24.hours
      time_remaining = time_diff
    elsif timeDifference > 1.weeks
      weekDiv = 3600*24*7
      time_remaining = timeDifference.divmod(weekDiv).first
      timeDifference > 3.weeks ? "#{time_remaining} weeks left" : "#{time_remaining} weeks left!"
    elsif timeDifference > 1.day and timeDifference < 1.weeks
      dayDiv = 3600*24
      time_remaining = timeDifference.divmod(dayDiv).first
      "#{time_remaining} days left!"
    end
  end

  private

  def time_diff
    startTime = Time.now
    endTime = self.end_date.to_time
    seconds_diff = (startTime - endTime).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  def at_least_one_topic_required
    return if topics.present?
    errors.add(:topic, 'is missing. At least one topic is required.')
  end
end
