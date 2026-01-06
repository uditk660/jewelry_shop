class Purity < ApplicationRecord
  belongs_to :metal

  validates :name, presence: true
  validates :purity_percent, presence: true, numericality: true

  scope :active, -> { where(active: true) }
end
