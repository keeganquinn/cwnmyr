RSpec::Matchers.define :respond_with_content_type do |expected|
  def lookup(short)
    Mime::Type.lookup_by_extension(short.to_sym).to_s
  end

  match do |actual|
    expect(actual.content_type).to eq lookup(expected)
  end

  failure_message do |actual|
    "expected content type #{lookup(expected)} but found #{actual.content_type}"
  end

  failure_message_when_negated do |actual|
    "expected content type other than #{actual.content_type}"
  end
end
