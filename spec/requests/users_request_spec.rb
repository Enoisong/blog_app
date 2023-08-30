# require 'rails_helper'

# RSpec.describe 'Users', type: :request do
#   describe 'GET /index' do
#     pending "add some examples (or delete) #{__FILE__}"
#   end
# end
require 'rails_helper'

RSpec.describe 'User', type: :request do
  let(:user) { User.create!(name: 'enoisong', photo: 'person.jpg', bio: 'Software developer') }

  context 'GET #index' do
    it 'should renders a successful response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'should render the correct template' do
      get users_url
      expect(response.body).to render_template(:index)
    end

    it 'should return the correct placeholder text' do
      get users_url
      expect(response.body).to include('List of all users')
    end
  end

  context 'GET #show' do
    it 'should renders a successful response' do
      get "/users/#{user.id}"
      expect(response).to be_successful
    end

    it 'should render the correct template' do
      get user_url(user)
      expect(response.body).to render_template(:show)
    end

    it 'should return the correct placeholder text' do
      get user_url(user)
      expect(response.body).to include('User with the given id')
    end
  end
end
