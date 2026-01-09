class JewelleryCategory < ApplicationRecord
  belongs_to :metal
  has_many :sale_items, dependent: :destroy

  validates :name, presence: true
  scope :active, -> { where(active: true) }
end
