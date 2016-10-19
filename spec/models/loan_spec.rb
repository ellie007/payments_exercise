require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  describe 'when a loan is created' do
    it 'the loan has an outstanding_balance field' do
      expect(loan.has_attribute?(:outstanding_balance)).to be(true)
    end

    it "the loan's outstanding_balance is initialized with the same amount as funded_amount" do
      expect(loan.outstanding_balance).to eq(loan.funded_amount)
    end
  end
end
