describe UsersController, type: :request do
  let!(:username) { Faker::Name.first_name.downcase }

  describe '#register' do
    context 'success' do
      before do
        post users_register_path, params: { username: username, email: 'example@example.de', email_confirmation: 'example@example.de',
          password: 'test', password_confirmation: 'test' }
      end

      it 'has created a new user' do
        expect(User.find_by(username: username)).to be_a(User)
      end

      it 'sets the user_id in the session' do
        expect(session[:user_id]).to eq(User.find_by!(username: username).id)
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
