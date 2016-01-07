class Brand < ActiveRecord::Base


  has_many :products, :dependent => :destroy

  accepts_nested_attributes_for :products


  validates :brandname, presence: true

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "50x50#" }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  def children
    @children ||= (self.products).sort(&:created_at)
  end



end
