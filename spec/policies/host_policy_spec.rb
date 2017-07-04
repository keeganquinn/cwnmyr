describe HostPolicy do
  subject { HostPolicy }

  let (:current_user) { build_stubbed :user }
  let (:other_user) { build_stubbed :user }
  let (:admin) { build_stubbed :user, :admin }

  let (:node) { build_stubbed :node, user: current_user }
  let (:host) { build_stubbed :host, node: node }

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
    it "prevents other users from creating hosts" do
      expect(subject).not_to permit(other_user, host)
    end
    it "allows the user who created a node to create a host" do
      expect(subject).to permit(current_user, host)
    end
    it "allows an admin to create a host" do
      expect(subject).to permit(admin, host)
    end
  end

  permissions :update? do
    it "prevents unauthenticated access" do
      expect(subject).not_to permit(nil)
    end
    it "prevents other users from updating hosts" do
      expect(subject).not_to permit(other_user, host)
    end
    it "allows the user who created a node to update a host" do
      expect(subject).to permit(current_user, host)
    end
    it "allows an admin to update a host" do
      expect(subject).to permit(admin, host)
    end
  end

  permissions :destroy? do
    it "prevents unauthenticated access" do
      expect(subject).not_to permit(nil)
    end
    it "prevents other users from destroying hosts" do
      expect(subject).not_to permit(other_user, host)
    end
    it "allows the user who created a node to destroy a host" do
      expect(subject).to permit(current_user, host)
    end
    it "allows an admin to destroy a host" do
      expect(subject).to permit(admin, host)
    end
  end
end
