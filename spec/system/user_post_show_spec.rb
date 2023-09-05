require 'rails_helper'

RSpec.describe 'User Post Show Page', type: :system do
  before do
    driven_by(:rack_test)
    @user1 = User.create!(name: 'enoisong', photo: 'person.jpg', bio: 'Software developer')
    @post1 = Post.create!(author: @user1, title: 'First Post', text: 'This is my first post!')
  end

  context 'when the page is loaded' do
    it 'shows the title of the post' do
      visit user_post_path(@user1, @post1)

      expect(page).to have_content(@post1.title)
    end

    it 'shows the author of the post' do
      user1 = User.create(name: 'enoisong')
      post1 = Post.create(title: 'My Post', author: user1)

      visit user_post_path(user1, post1)

      author_name_in_database = User.find(post1.author_id).name
      puts "Author's name in the database: #{author_name_in_database}"
      expect(post1.author.name).to eq(author_name_in_database)
    end

    it 'shows the text of the post' do
      visit user_post_path(@user1, @post1)

      expect(page).to have_content(@post1.text)
    end

    it 'shows the comment count of the post' do
      visit user_post_path(@user1, @post1)

      expect(page).to have_content(@post1.comments_counter)
    end

    it 'shows the like count of the post' do
      visit user_post_path(@user1, @post1)

      expect(page).to have_content(@post1.likes_counter)
    end

    it 'shows the username of each commentator' do
      Comment.create!(author: @user1, post: @post1, text: 'this is my first comment')
      visit user_post_path(@user1, @post1)

      expect(page).to have_content(@post1.comments[0].author.name)
    end

    it 'shows the comment text of each commentator' do
      Comment.create!(author: @user1, post: @post1, text: 'this is my first comment')
      visit user_post_path(@user1, @post1)

      expect(page).to have_content(@post1.comments[0].text)
    end
  end
end
