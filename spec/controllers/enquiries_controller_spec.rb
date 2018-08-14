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
end
