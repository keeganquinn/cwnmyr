describe NodeLinkPolicy do
  subject { NodeLinkPolicy }

  let (:current_user) { build_stubbed :user }
  let (:other_user) { build_stubbed :user }
  let (:admin) { build_stubbed :user, :admin }

  let (:node) { build_stubbed :node, user: current_user }
  let (:node_link) { build_stubbed :node_link, node: node }

  permissions :index? do
    it "always allows access" do
      expect(subject).to permit(nil)
    end
  end

  permissions :show? do
    it "always allows access" do
      expect(subject).to permit(nil)
    end
  end

  permissions :create? do
    it "prevents unauthenticated access" do
      expect(subject).not_to permit(nil)
    end
    it "prevents other users from creating node links" do
      expect(subject).not_to permit(other_user, node_link)
    end
    it "allows the user who created a node to create a node link" do
      expect(subject).to permit(current_user, node_link)
    end
    it "allows an admin to create a node link" do
      expect(subject).to permit(admin, node_link)
    end
  end

  permissions :update? do
    it "prevents unauthenticated access" do
      expect(subject).not_to permit(nil)
    end
    it "prevents other users from updating node links" do
      expect(subject).not_to permit(other_user, node_link)
    end
    it "allows the user who created a node to update a node link" do
      expect(subject).to permit(current_user, node_link)
    end
    it "allows an admin to update a node link" do
      expect(subject).to permit(admin, node_link)
    end
  end

  permissions :destroy? do
    it "prevents unauthenticated access" do
      expect(subject).not_to permit(nil)
    end
    it "prevents other users from destroying node links" do
      expect(subject).not_to permit(other_user, node_link)
    end
    it "allows the user who created a node to destroy a node link" do
      expect(subject).to permit(current_user, node_link)
    end
    it "allows an admin to update a node link" do
      expect(subject).to permit(admin, node_link)
    end
  end
end
