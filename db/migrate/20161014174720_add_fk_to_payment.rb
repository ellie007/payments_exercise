class AddFkToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :loan_id, :integer
  end
end
