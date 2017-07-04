describe InterfacePropertyDashboard do
  subject { InterfacePropertyDashboard }

  let (:interface_property) { build_stubbed :interface_property }

  it "defines attribute types" do
    expect(subject.const_get(:ATTRIBUTE_TYPES).length).to eq(6)
  end

  it "defines collection attributes" do
    expect(subject.const_get(:COLLECTION_ATTRIBUTES).length).to eq(3)
  end

  it "defines show page attributes" do
    expect(subject.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(6)
  end

  it "defines form attributes" do
    expect(subject.const_get(:FORM_ATTRIBUTES).length).to eq(3)
  end

  it "#display_resource returns a string" do
    expect(subject.new.display_resource(interface_property)).to match "^Interface Property ##{interface_property.to_param}$"
  end
end
