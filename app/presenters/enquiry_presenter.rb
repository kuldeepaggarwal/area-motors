class EnquiryPresenter
  attr_reader :enquiry, :params
  def initialize(enquiry, params = {})
    @enquiry = enquiry
    @params = params
  end

  delegate :link_to, to: 'ActionController::Base.helpers'
  delegate :update_state_enquiry_path, to: 'Rails.application.routes.url_helpers'

  def actions
    enquiry.aasm.events(permitted: true).map do |state|
      link_to state.name.to_s.titleize,
              update_state_enquiry_path(enquiry, status: state.name, q: params[:q]),
              method: :put
    end.join('|').html_safe
  end
end
