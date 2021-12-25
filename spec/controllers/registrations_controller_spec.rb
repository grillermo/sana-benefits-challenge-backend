describe RegistrationsController, type: :request do
  describe 'POST #create' do
    let(:password) { :password }
    let(:user)     { attributes_for(:user) }

    subject(:create_user) do
      post '/signup',
        as: :json,
        params: {
          user: {
            email: user[:email],
            password: password,
            confirm_password: password
          }
        }
    end

    it 'creates a user' do
      expect { create_user }.to change { User.count }
    end

    it 'returns a JWT token upon successful registration' do
      create_user
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.headers).to have_key('Authorization')
        expect(response.headers['Authorization']).to be_starts_with('Bearer')
      end
    end

    it 'returns the user email on the token' do
      create_user

      authorization_header = response.headers['Authorization']
      decoded_token        = decode_authorization_header(authorization_header)

      expect(decoded_token).to have_key('email')
      expect(decoded_token['email']).to eql user[:email]
    end
  end
end
