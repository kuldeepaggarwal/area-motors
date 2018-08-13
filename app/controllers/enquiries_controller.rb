class EnquiriesController < ApplicationController
  def index
    @enquiries = Enquiry.page(params[:page])
                        .per(params[:per_page])
                        .includes(:enquirer)
  end
end
