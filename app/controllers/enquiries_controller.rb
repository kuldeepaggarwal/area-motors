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

  def update_state
    if enquiry.public_send("#{params[:status]}!")
      flash[:success] = "Status updated successfully"
    else
      flash[:error] = "Unable to update the status of Enquiry(##{enquiry.id})"
    end
    redirect_to enquiries_path(q: params[:q])
  end

  private

    def enquiry
      @enquiry ||= Enquiry.find_by!(id: params[:id])
    end
end
