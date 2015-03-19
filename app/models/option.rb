class Option < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :interest_options

  # Selection of interests for users to choose from are defined here
  
end
