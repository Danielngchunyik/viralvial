class Option < ActiveRecord::Base
  # Selection of interests for users to choose from are defined here
  # Selection of social media platforms are defined here

  acts_as_taggable_on :interest_options, :social_media_platform_options
end
