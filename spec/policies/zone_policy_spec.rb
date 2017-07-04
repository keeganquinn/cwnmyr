describe ZonePolicy do
  subject { ZonePolicy }

  let (:current_user) { build_stubbed :user }
  let (:other_user) { build_stubbed :user }
  let (:admin) { build_stubbed :user, :admin }

  let (:zone) { build_stubbed :zone }

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

  permissions :markers? do
    it "always allows access" do
      expect(subject).to permit(nil)
    end
  end
end
