require 'rails_helper'

describe EnquiriesController, type: :controller do
  describe 'POST #synchronize' do
    it 'synchronizes the enquires from third part service with our DB' do
      expect { post :synchronize }.to change(Enquiry, :count).by(3)
    end

    it 'does not create duplicate records' do
      EnquirySynchronizer.synchronize
      expect { post :synchronize }.not_to change(Enquiry, :count)
    end

    it 'redirects to Enquiries listing page' do
      post :synchronize
      expect(response).to redirect_to(enquiries_path)
    end
  end

  describe 'GET #index' do
    it 'searches for a specific user' do
      EnquirySynchronizer.synchronize
      get :index
      expect(assigns(:enquiries).count).to eq(3)
      get :index, params: { q: 'smith', per_page: 1 }
      expect(assigns(:enquiries).count).to eq(1)
      expect(assigns(:enquiries).total_count).to eq(2)
    end
  end

  describe 'PUT #update_state' do
    context 'when correct params' do
      after  do
        expect(response).to redirect_to(enquiries_path)
      end

      let(:enquiry) { FactoryBot.create(:enquiry, :am_direct) }

      it 'updates the status of an enquiry to possible one' do
        expect do
          put :update_state, params: { id: enquiry.id, status: 'invalidate' }
        end.to change { enquiry.reload.aasm_state }
      end

      it 'sends success flash message' do
        put :update_state, params: { id: enquiry.id, status: 'invalidate' }
        expect(flash[:success]).to eq('Status updated successfully')
      end
    end

    context 'when invalid "id" param' do
      it 'sends error' do
        put :update_state, params: { id: -1, status: 'invalidate' }
        expect(flash[:error]).to eq('Resource not found')
      end

      it 'redirect to root page' do
        put :update_state, params: { id: -1, status: 'invalidate' }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when invalid "status" param' do
      let(:enquiry) { FactoryBot.create(:enquiry, :am_direct, :not_valid) }

      it 'sends error' do
        put :update_state, params: { id: enquiry.id, status: 'finish' }
        expect(flash[:error]).to eq("Unable to update the status of Enquiry(##{enquiry.id})")
      end

      it 'redirect to enquiries index page' do
        put :update_state, params: { id: enquiry.id, status: 'finish' }
        expect(response).to redirect_to(enquiries_path)
      end
    end
  end
end
