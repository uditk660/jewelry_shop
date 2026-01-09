class SaleItem < ApplicationRecord
  belongs_to :sale
  belongs_to :metal
  belongs_to :purity
  belongs_to :jewellery_category

  enum making_type: {
    percentage: "percentage",
    amount: "amount"
  }

  validates :weight, :rate, presence: true
  before_validation :calculate_amounts
  # validate :stock_must_be_available

  # def stock_must_be_available
  #   stock = StockLedger.where(
  #     metal_id: metal_id,
  #     purity_id: purity_id,
  #     jewellery_category_id: jewellery_category_id,
  #     transaction_type: "in_stock"
  #   ).sum(:unit)

  #   if unit.present? && unit > stock
  #     errors.add(:unit, "exceeds available stock (#{stock})")
  #   end
  # end

  def calculate_amounts
    self.metal_value = (weight.to_d * rate.to_d).round(2)

    self.making_amount =
      if making_type == "percentage"
        (metal_value * making_value.to_d / 100).round(2)
      else
        making_value.to_d
      end

    self.total_line_amount = metal_value + making_amount
  end
end