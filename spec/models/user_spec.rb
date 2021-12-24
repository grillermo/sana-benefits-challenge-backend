describe User, type: :model do
  describe 'factory' do
    subject { build(:user) }

    it { is_expected.to be_valid }
  end
end


