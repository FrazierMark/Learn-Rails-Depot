class Cart < ApplicationRecord
  # dependent: :destroy indicates that the existence of line
  # items is dependent on the existence of the cart
  # If we destroy the cart, we want Rails to destroy any line items
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end

  def total_price
    line_items.sum { |item| item.total_price }
  end

end
