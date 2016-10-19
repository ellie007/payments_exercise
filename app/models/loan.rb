class Loan < ActiveRecord::Base

  has_many :payments

  after_create :set_original_outstanding_balance

  def set_original_outstanding_balance
    self.update_attribute(:outstanding_balance, funded_amount)
  end

  def update_outstanding_balance(amount)
    self.update_attribute(:outstanding_balance, outstanding_balance - amount)
  end

end

