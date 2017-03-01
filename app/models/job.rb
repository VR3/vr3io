class Job < ApplicationRecord
  
  extend FriendlyId
  friendly_id :position,  use: :slugged

end
