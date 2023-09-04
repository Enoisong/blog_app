require 'rails_helper'

RSpec.describe 'User Post Index Page', type: :system do
  before do
    driven_by(:rack_test)
    @user1 = User.create!(name: 'jane', photo: 'person.jpg', bio: 'Software developer')
    @user2 = User.create!(name: 'Jessica', photo: 'person2.jpg', bio: 'Software developer')
    @post1 = Post.create!(author: @user1, title: 'First Post', text: 'This is my first post!')
    @post2 = Post.create!(author: @user2, title: 'first post', text: 'This is my first post!')
    @post3 = Post.create!(author: @user1, title: 'Second Post', text: 'This is my second post!')
  end

  context 'when the page is loaded' do
    it 'shows the username of the user' do
      visit user_posts_path(@user1)

      expect(page).to have_content(@user1.name)
    end

    it 'shows the profile picture of the user' do
      visit user_posts_path(@user1)

      expect(page).to have_css("img[src*='person.jpg']")
    end

    it 'shows the number of posts the user has' do
      visit user_posts_path(@user1)

      expect(page).to have_content(@user1.posts.count)
    end

    it 'shows the title of the post' do
      visit user_posts_path(@user1)

      expect(page).to have_content(@user1.posts[0].title)
      expect(page).to have_content(@user1.posts[1].title)
    end

    it 'shows the text of the post' do
      visit user_posts_path(@user1)

      expect(page).to have_content(@user1.posts[0].text)
      expect(page).to have_content(@user1.posts[1].text)
    end

    it 'shows the first comments of each post' do
      Comment.create!(author: @user1, post: @post1, text: 'this is my first comment')
      Comment.create!(author: @user1, post: @post1, text: 'this is my second comment')
      visit user_posts_path(@user1)

      expect(page).to have_content(@user1.posts[0].comments[0]) unless @user1.posts[0].comments[0].nil?
      expect(page).to have_content(@user1.posts[0].comments[1]) unless @user1.posts[0].comments[1].nil?

    end

    it 'shows the comment count of each post' do
      Comment.create!(author: @user1, post: @post1, text: 'this is my first comment')
      Comment.create!(author: @user1, post: @post1, text: 'this is my second comment')
      visit user_posts_path(@user1)

      expect(page).to have_content(@user1.posts[0].comments_counter)
    end

    it 'shows the like count of each post' do
      Like.create!(author: @user1, post: @post1)
      Like.create!(author: @user1, post: @post1)
      Like.create!(author: @user1, post: @post2)
      visit user_posts_path(@user1)

      expect(page).to have_content(@user1.posts[0].likes_counter)
      expect(page).to have_content(@user1.posts[1].likes_counter)
    end
  end

  context 'when you click on a post' do     
    it 'redirects to the correct post show page' do
        visit user_posts_path(@user1)
        click_link(@user1.posts[0].title)
        expect(page).to have_current_path(user_post_path(@user1, @user1.posts[0]))
      end
      

    it 'redirects to the post2 show page' do
      visit user_posts_path(@user1)
      click_link(@user1.posts[1].title)

      expect(page).to have_current_path(user_post_path(@user1, @post3))
    end
  end
end 