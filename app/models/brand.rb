class Brand < ActiveRecord::Base

  has_many :products, :dependent => :destroy

  accepts_nested_attributes_for :products

  validates :brandname, presence: true



end
