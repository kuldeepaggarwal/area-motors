class EnquirySynchronizer
  def self.synchronize(feeder = EnquiryFeeder.new)
    new(feeder).synchronize
  end

  private_class_method :new

  attr_reader :enquiry_feeder
  def initialize(enquiry_feeder)
    @enquiry_feeder = enquiry_feeder
  end

  def synchronize
    enquiry_feeder.enquiries.each do |enquiry|
      User.transaction do
        user = User.create_with(enquiry.slice(:name))
                   .find_or_create_by(email: enquiry[:email])

        if user.persisted?
          user.enquiries
              .create_with(enquiry.slice(:vehicle_attributes).merge(message: enquiry[:enquiry]))
              .find_or_create_by!(enquiry.slice(:source, :identifier))
        end
      end
    end
  end
end
