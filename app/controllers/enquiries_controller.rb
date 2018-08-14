class EnquiriesController < ApplicationController
  def index
    @enquiries = Search::Enquiry
                        .search(params[:q])
                        .page(params[:page])
                        .per(params[:per_page])
                        .includes(:enquirer)
  end

  def synchronize
    # This task should be done in the background
    EnquirySynchronizer.synchronize
    redirect_to enquiries_path
  end
end
