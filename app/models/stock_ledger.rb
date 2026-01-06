class StockLedger < ApplicationRecord
  belongs_to :metal
  belongs_to :purity
  belongs_to :jewellery_category
  belongs_to :user # who made the entry
  belongs_to :referenceable, polymorphic: true, optional: true # e.g., Invoice, Purchase

  enum transaction_type: { in_stock: "in", out_stock: "out" }

  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :rate, presence: true, numericality: { greater_than: 0 }

  before_save :calculate_value

  def calculate_value
    self.value = (weight * rate).round(2)
  end
end