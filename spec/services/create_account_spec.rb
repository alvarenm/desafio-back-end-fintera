RSpec.describe CreateAccount do
  describe "#call" do
    subject(:call) { described_class.call(payload, from_fintera) }
    let(:from_fintera) { false }

    context "when account is created and the user is not from fintera" do
      let(:payload) do
        {
          name: Faker::Company.name,
          entity_name: Faker::Company.name,
          users: [
            {
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              phone: "(11) 97111-0101",
            },
          ],
        }
      end

      let(:expected_result) { ApplicationService::Result.new(true, Account.last, nil) }

      it { is_expected.to eql(expected_result) }
    end

    context "when account is created and the user is from fintera" do
      let(:payload) do
        {
          name: Faker::Company.name,
          users: [
            {
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              phone: "(11) 97111-0101",
            },
          ],
        }
      end

      let(:from_fintera) { true }

      let(:expected_result) { ApplicationService::Result.new(true, Account.last, nil) }

      it { is_expected.to eql(expected_result) }
    end

    context "when account is not created" do
      let(:payload) do
      {    
        name: "",
          users: [
            {
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              phone: "(11) 97111-0101",
            },
          ],
        }
      end
      let(:expected_result) { ApplicationService::Result.new(false, nil, "Name can't be blank") }

      it { is_expected.to eql(expected_result) }
    end

    context "when payload is invalid" do
      let(:payload) { {} }
      let(:expected_result) { ApplicationService::Result.new(false, nil, "Account is not valid") }

      it { is_expected.to eql(expected_result) }
    end
  end
end
