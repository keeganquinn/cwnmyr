describe NodeLinkDashboard do
  subject { NodeLinkDashboard }

  let (:node_link) { build_stubbed :node_link }

  it "defines attribute types" do
    expect(subject.const_get(:ATTRIBUTE_TYPES).length).to eq(6)
  end

  it "defines collection attributes" do
    expect(subject.const_get(:COLLECTION_ATTRIBUTES).length).to eq(2)
  end

  it "defines show page attributes" do
    expect(subject.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(6)
  end

  it "defines form attributes" do
    expect(subject.const_get(:FORM_ATTRIBUTES).length).to eq(3)
  end

  it "#display_resource returns a string" do
    expect(subject.new.display_resource(node_link)).to match "^NodeLink ##{node_link.to_param}$"
  end
end
