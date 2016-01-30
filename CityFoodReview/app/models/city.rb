class City < ActiveRecord::Base
  has_many :restaurants
  validates :name, presence: true,
                    length: { minimum: 5 }
end
