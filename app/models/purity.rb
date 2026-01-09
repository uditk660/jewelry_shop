class Purity < ApplicationRecord
  belongs_to :metal
  has_many :sale_items, dependent: :destroy

  validates :name, presence: true
  validates :purity_percent, presence: true, numericality: true
  validates :updated_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  scope :active, -> { where(active: true) }
end
