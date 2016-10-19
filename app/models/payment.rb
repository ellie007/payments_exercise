class Payment < ActiveRecord::Base

  belongs_to :loan

  after_create :update_loan_outstanding_balance

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :loan, presence: { message: "ID is not a valid ID." }
  validate :amount_does_not_exceed_outstanding_balance

  def amount_does_not_exceed_outstanding_balance
    if self.loan && (self.loan.outstanding_balance < amount)
      errors.add(:amount, "payment exceeds outstanding loan balance.")
    end
  end

  private

  def update_loan_outstanding_balance
    loan.update_outstanding_balance(amount)
  end

end
