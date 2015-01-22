class Option < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :interest_options
end
