class SetLineItemPrice < ActiveRecord::Migration[5.1]
  def up
    LineItem.all.each do |li|
      li.price = li.product.price * li.quantity
      li.save
    end
  end

  def down
    LineItem.all.each do |li|
      li.price = nil
      li.save
    end
  end
end
