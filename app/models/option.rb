class Option < ActiveRecord::Base
  acts_as_taggable_on :interest_options, :social_media_platform_options

  # Selection of interests for users to choose from are defined here
  # Selection of social media platforms are defined here
end
