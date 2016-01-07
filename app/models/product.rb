class Product < ActiveRecord::Base

  belongs_to :brand

  validates :name, presence: true

  delegate :brandname, to: :brand, prefix: true
  delegate :id, to: :brand, prefix: true

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end






end
