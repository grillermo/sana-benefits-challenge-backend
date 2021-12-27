describe AQIWarningsController, type: :request do
  describe "GET /aqi_warning" do
    let(:user) { create(:user) }

    subject(:get_aqi_warning) do
      get '/aqi_warning', as: :json, headers: auth_headers(user)
    end

    context 'the user has an aqi_warning' do
      let!(:aqi_warning) { create(:aqi_warning, user: user) }

      it 'returns the serialized aqi_warning' do
        get_aqi_warning

        expect(response.body).to eql aqi_warning.to_json
      end
    end

    context 'the user does not have an aqi_warning' do
      it 'returns an empty response' do
        get_aqi_warning

        expect(JSON.parse(response.body)).to be_blank
      end
    end
  end
end
