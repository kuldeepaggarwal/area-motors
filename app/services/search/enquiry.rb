module Search
  class Enquiry
    def self.search(search_term)
      if search_term.present?
        search_term = "%#{search_term}%"
        ::Enquiry.joins(:enquirer).where(::User.arel_table[:name].matches(search_term)
              .or(::User.arel_table[:email].matches(search_term))
             )
      else
        ::Enquiry
      end
    end
  end
end
