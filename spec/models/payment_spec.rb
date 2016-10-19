require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:loan) { Loan.create!(funded_amount: 100.0) }
  let(:payment) { Payment.create!(loan_id: loan.id, amount: 10.0) }

  describe 'when a payment is created' do
    it 'the payment has date and amount attributes' do
      expect(payment.has_attribute?(:created_at)).to be(true)
      expect(payment.has_attribute?(:amount)).to be(true)
    end

    it "the payment updates the loan's oustanding balance amount" do
      payment
      loan.reload
      expect(loan.outstanding_balance).to eq(BigDecimal.new(90))
    end
  end

  describe 'does not create invalid payment records' do
    it '- a payment amount for a nonexistent loan' do
      expect { Payment.create!(loan_id: 10000, amount: 10.0) }.to raise_error(ActiveRecord::RecordInvalid, /Loan is not a valid Loan ID/)
    end

    it "- a payment amount above the loan's outstanding balance" do
      expect { Payment.create!(loan_id: loan.id, amount: 1000.0) }.to raise_error(ActiveRecord::RecordInvalid, /Amount payment exceeds outstanding loan balance/)
    end

    it ' a payment amount that is negative' do
       expect { Payment.create!(loan_id: loan.id, amount: -10.0) }.to raise_error(ActiveRecord::RecordInvalid, /Amount must be greater than 0/)
    end
  end
end
