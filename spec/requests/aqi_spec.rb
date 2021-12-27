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

  describe 'POST /aqi_warning' do
    let(:user) { create(:user) }

    subject(:post_aqi_warning) do
      post '/aqi_warning', as: :json, headers: auth_headers(user), params: params
    end

    context 'valid attributes to create an aqi_warning' do
      let(:aqi_warning_attributes) { attributes_for(:aqi_warning) }
      let(:params)                 { { aqi_warning: aqi_warning_attributes } }

      it 'returns the aqi_warning latitude' do
        post_aqi_warning

        expect(json_response['latitude']).to eq aqi_warning_attributes[:latitude]
      end

      it 'creates an aqi_warning' do
        expect{ post_aqi_warning }.to change { AQIWarning.count }.by 1

        aqi_warning = AQIWarning.last

        expect(aqi_warning.longitude).to eql aqi_warning_attributes[:longitude]
        expect(aqi_warning.latitude).to eql aqi_warning_attributes[:latitude]
        expect(aqi_warning.location).to eql aqi_warning_attributes[:location]
        expect(aqi_warning.user).to eql user
      end

      it 'returns the aqi_warning serialized' do
        post_aqi_warning

        aqi_warning = AQIWarning.last

        expect(json_response).to eq(
          {
            'id' => aqi_warning.id,
            'latitude' => aqi_warning.latitude,
            'longitude' => aqi_warning.longitude,
            'location' => aqi_warning.location,
            'threshold' => aqi_warning.threshold,
          }
        )
      end
    end

    context 'invalid attributes to create an aqi_warning' do
      let(:params) do
        {
          aqi_warning: {
            latitude: nil,
            longitude: nil,
            location: nil,
            threshold: nil,
          }
        }
      end

      it 'returns the error message' do
        post_aqi_warning

        expect(json_response['message']).to eql(
          "Threshold can't be blank, "\
          "Longitude can't be blank, "\
          "Latitude can't be blank, "\
          "Location can't be blank, "\
          "Threshold is not a number"
        )
      end
    end
  end
end
