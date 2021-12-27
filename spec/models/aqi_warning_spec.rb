describe AQIWarning, type: :model do
  describe 'factory' do
    subject { build(:aqi_warning) }

    it { is_expected.to be_valid }
  end
end
