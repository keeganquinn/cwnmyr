describe NodeDashboard do
  subject { NodeDashboard }

  let (:node) { build_stubbed :node }

  it "defines attribute types" do
    expect(subject.const_get(:ATTRIBUTE_TYPES).length).to eq(18)
  end

  it "defines collection attributes" do
    expect(subject.const_get(:COLLECTION_ATTRIBUTES).length).to eq(5)
  end

  it "defines show page attributes" do
    expect(subject.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(18)
  end

  it "defines form attributes" do
    expect(subject.const_get(:FORM_ATTRIBUTES).length).to eq(11)
  end

  it "#display_resource returns a string" do
    expect(subject.new.display_resource(node)).to match "^Node ##{node.to_param}$"
  end
end
