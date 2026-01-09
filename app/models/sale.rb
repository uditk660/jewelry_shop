class Sale < ApplicationRecord
  belongs_to :user
  has_many :sale_items, inverse_of: :sale

  accepts_nested_attributes_for :sale_items, allow_destroy: true

  validates :sale_date, presence: true

  before_save :calculate_totals

  def calculate_totals
    self.subtotal = sale_items.sum(&:metal_value)
    self.making_total = sale_items.sum(&:making_amount)

    taxable_amount = subtotal + making_total

    self.cgst = (taxable_amount * 0.09).round(2)
    self.sgst = (taxable_amount * 0.09).round(2)
    self.total_amount = taxable_amount + cgst + sgst
  end
end