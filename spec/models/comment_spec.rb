# require 'rails_helper'

# RSpec.describe Comment, type: :model do
#   it 'should update the comments_counter of the post' do
#     user = User.create(name: 'enoisong', photo: 'person.jpg', bio: 'Software developer', posts_counter: 0)
#     post = Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
#                        likes_counter: 0)
#     comment = described_class.new(post:, author: user, text: 'This is my first comment')

#     expect(post.comments_counter).to eq 0
#     comment.save
#     post.reload
#     expect(post.comments_counter).to eq 1

#     comment.destroy
#     post.reload
#     expect(post.comments_counter).to eq 0
#   end
# end
require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'anbehindY', photo: 'person.jpg', bio: 'Full-stack developer', posts_counter: 0)
  post = Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
  subject { described_class.new(post: post, author: user, text: 'This is my first comment') }

  context '#comments_counter' do
    it 'should update the comments_counter of the post' do
      expect(post.comments_counter).to eq 0
      subject.save
      expect(post.comments_counter).to eq 1
      subject.destroy
      expect(post.comments_counter).to eq 0
    end
  end
end
