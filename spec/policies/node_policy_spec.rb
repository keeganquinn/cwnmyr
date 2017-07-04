describe NodePolicy do
  subject { NodePolicy }

  let (:current_user) { build_stubbed :user }
  let (:other_user) { build_stubbed :user }
  let (:admin) { build_stubbed :user, :admin }
  let (:node) { build_stubbed :node, user: current_user }

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

  permissions :new? do
    it "prevents unauthenticated access" do
      expect(subject).not_to permit(nil)
    end
    it "allows a user to see the new node form" do
      expect(subject).to permit(current_user)
    end
  end

  permissions :create? do
    it "prevents unauthenticated access" do
      expect(subject).not_to permit(nil)
    end
    it "allows a user to create a node" do
      expect(subject).to permit(current_user)
    end
  end

  permissions :edit? do
    it "prevents other users from editing a node" do
      expect(subject).not_to permit(other_user, node)
    end
    it "allows the user who created a node to edit it" do
      expect(subject).to permit(current_user, node)
    end
    it "allows an admin to edit any node" do
      expect(subject).to permit(admin, node)
    end
  end

  permissions :update? do
    it "prevents other users from updating a node" do
      expect(subject).not_to permit(other_user, node)
    end
    it "allows the user who created a node to update it" do
      expect(subject).to permit(current_user, node)
    end
    it "allows an admin to update any node" do
      expect(subject).to permit(admin, node)
    end
  end

  permissions :destroy? do
    it "prevents other users from destroying a node" do
      expect(subject).not_to permit(other_user, node)
    end
    it "allows the user who created a node to destroy it" do
      expect(subject).to permit(current_user, node)
    end
    it "allows an admin to destroy any node" do
      expect(subject).to permit(admin, node)
    end
  end

  permissions :graph? do
    it "always allows access" do
      expect(subject).to permit(nil)
    end
  end

  permissions :markers? do
    it "always allows access" do
      expect(subject).to permit(nil)
    end
  end

  permissions :wl? do
    it "always allows access" do
      expect(subject).to permit(nil)
    end
  end
end
