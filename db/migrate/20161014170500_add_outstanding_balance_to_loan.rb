class AddOutstandingBalanceToLoan < ActiveRecord::Migration
  def change
    add_column :loans, :outstanding_balance, :decimal, precision: 8, scale: 2
  end
end
