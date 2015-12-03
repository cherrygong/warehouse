class Product < ActiveRecord::Base

  belongs_to :brand


  validates :name, presence: true

end
