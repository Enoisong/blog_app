require 'rails_helper'

RSpec.describe 'User Show Page', type: :system do
  before do
    driven_by(:rack_test)
    @user = User.create!(name: 'enoisong', photo: 'person.jpg', bio: 'Software developer')
    @post = Post.create!(author: @user, title: 'First Post', text: 'This is my first post!')
    @post2 = Post.create!(author: @user, title: 'Second Post', text: 'This is my second post!')
    @post3 = Post.create!(author: @user, title: 'Third Post', text: 'This is my third post!')
  end

  context 'when the page is loaded' do
    it 'shows the username' do
      visit user_path(@user)

      expect(page).to have_content(@user.name)
    end

    it 'shows the profile picture' do
      visit user_path(@user)

      expect(page).to have_css("img[src*='person.jpg']")
    end

    it 'shows the number of posts by the user' do
      visit user_path(@user)

      expect(page).to have_content(@user.posts.count)
    end

    it 'shows the bio of the user' do
      visit user_path(@user)

      expect(page).to have_content(@user.bio)
    end

    it 'shows the first three posts by the user' do
      visit user_path(@user)

      expect(page).to have_content(@user.posts.first.title)
      expect(page).to have_content(@user.posts.second.title)
      expect(page).to have_content(@user.posts.third.title)
    end

    it 'shows see all posts button' do
      visit user_path(@user)

      expect(page).to have_link('See all posts')
    end
  end

  context 'when you click the links on the page' do
    it 'redirects to the user posts page when the see all posts button is clicked' do
      visit user_path(@user)

      click_link('See all posts')

      expect(page).to have_current_path(user_posts_path(@user))
    end

    it 'redirects to the post when the post title is clicked' do
      visit user_path(@user)

      click_link(@post.title)

      expect(page).to have_current_path(user_post_path(@user, @post))
    end
  end
end
