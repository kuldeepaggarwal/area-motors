class EnquiryFeeder
  attr_reader :folder
  def initialize(folder = Rails.root.join('public/enquiries'))
    @folder = folder
  end

  def enquiries
    return to_enum(__method__) unless block_given?

    Dir["#{folder}/*.html"].each do |file_path|
      path = Pathname.new(file_path)
      file_name = path.basename.to_s
      parser = EmailParsers.find_parser(file_name)
      response = parser.parse(File.read(file_path)).merge(identifier: file_name)
      yield response
    end
  end
end
