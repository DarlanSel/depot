class AddPriceToLineItem < ActiveRecord::Migration[5.1]
  def change
    add_column :line_items, :price, :decimal
  end
end
