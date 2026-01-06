class JewelleryCategory < ApplicationRecord
  belongs_to :metal

  validates :name, presence: true
  scope :active, -> { where(active: true) }
end
