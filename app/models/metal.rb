class Metal < ApplicationRecord
  has_many :purities, dependent: :restrict_with_error
  has_many :jewellery_categories, dependent: :restrict_with_error

  scope :active, -> { where(active: true) }
  
  validates :name, presence: true, uniqueness: true
end