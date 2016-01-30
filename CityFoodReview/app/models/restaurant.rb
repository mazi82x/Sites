class Restaurant < ActiveRecord::Base
  has_many :votes
  belongs_to :city
end
