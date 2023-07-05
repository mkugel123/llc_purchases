class AddDocAmountToProperties < ActiveRecord::Migration[6.1]
  def change
    add_column :properties, :doc_amount, :bigint
  end
end
