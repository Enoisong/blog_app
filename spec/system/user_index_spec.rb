require 'rails_helper'

RSpec.describe 'User Index Page', type: :system do
  before do
    driven_by(:rack_test)
    @user1 = User.create!(name: 'Eny', photo: 'person.jpg', bio: 'Software developer')
    @user2 = User.create!(name: 'mAli', photo: 'person2.jpg', bio: 'Software developer')
    @post1 = Post.create!(author: @user1, title: 'First Post', text: 'This is my first post!')
    @post2 = Post.create!(author: @user2, title: 'first post', text: 'This is my first post!')
  end

  context 'when the page is loaded' do
    it 'shows the username of all users' do
      visit users_path

      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
    end

    it 'shows the profile picture of each user' do
      visit users_path

      expect(page).to have_css("img[src*='person.jpg']")
      expect(page).to have_css("img[src*='person2.jpg']")
    end

    it 'shows the number of posts each user has' do
      visit users_path

      expect(page).to have_content(@user1.posts.count)
      expect(page).to have_content(@user2.posts.count)
    end
  end

  context 'when you click on the name of a user' do
    it 'redirects to the user1 show page' do
      visit users_path

      click_link(@user1.name)

      expect(page).to have_current_path(user_path(@user1))
    end

    it 'redirects to the user2 show page' do
      visit users_path

      click_link(@user2.name)

      expect(page).to have_current_path(user_path(@user2))
    end
  end
end
