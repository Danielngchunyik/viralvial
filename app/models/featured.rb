class Featured < ActiveRecord::Base
  belongs_to :featurable, polymorphic: true
end