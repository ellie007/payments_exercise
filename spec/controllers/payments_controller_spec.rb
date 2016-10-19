require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :index, loan_id: loan.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment) { Payment.create(loan_id: loan.id, amount: 10.0 ) }

    it 'responds with a 200' do
      get :show, id: payment.id
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
