class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  private

    def resource_not_found
      flash[:error] = 'Resource not found'
      redirect_to root_path(q: params[:q])
    end
end
