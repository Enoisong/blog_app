require 'rails_helper'

RSpec.describe 'Post', type: :request do
  let(:user) { User.create!(name: 'enoisong', photo: 'person.jpg', bio: 'Software developer') }
  let(:post) { Post.create!(author: user, title: 'Programming', text: 'Software development is an iterative process') }

  context 'GET #index' do
    it 'should renders a successful response' do
      get "/users/#{user.id}/posts"
      expect(response).to be_successful
    end

    it 'should render the correct template' do
      get user_posts_url(user)
      expect(response.body).to render_template(:index)
    end

    it 'should return the correct placeholder text' do
      get user_posts_url(user)
      expect(response.body).to include('enoisong')
    end
  end

  context 'GET #show' do
    it 'should render the successful response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'should render the correct template' do
      get user_post_url(user, post)
      expect(response.body).to render_template(:show)
    end

    it 'should return the correct placeholder text' do
      get user_post_url(user, post)
      expect(response.body).to include('Programming')
    end
  end
end
