RSpec.describe User do
  describe "associations" do
    it { is_expected.to have_many :entity_user }
  end
end
