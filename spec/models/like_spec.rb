require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'enoisong', photo: 'person.jpg', bio: 'Software developer', posts_counter: 0)
  post = Post.create(author: user, title: 'Hey', text: 'Good morning', comments_counter: 0, likes_counter: 0)
  subject = described_class.new(author: user, post: post)

  context '#likes_counter' do
    it 'should update the likes_counter of the post' do
      expect(post.likes_counter).to eq 0
      subject.save
      expect(post.reload.likes_counter).to eq 1
      subject.destroy
      expect(post.reload.likes_counter).to eq 0
    end
  end
end
