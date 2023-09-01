require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'enoisong', photo: 'person.jpg', bio: 'Software developer', posts_counter: 0) }
  subject do
    described_class.new(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
  end

  context 'Validation measures before saving into database' do
    before { subject.save }

    it 'should have a valid title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'should have a title with maximum 250 characters' do
      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'should allow comments_counter with only integer value' do
      subject.comments_counter = 'abc'
      expect(subject).to_not be_valid
    end

    it 'should only allow comments_counter value greater than or equal to 0' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should allow likes_counter with only interger value' do
      subject.likes_counter = 'abc'
      expect(subject).to_not be_valid
    end

    it 'should only allow likes_counter values greater than or equal to 0' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end

  context '#recent_comments' do
    it 'should return the recent comments of the post' do
      8.times do |i|
        Comment.create(post: subject, author: user, text: "This is my #{i + 1} comment")
      end
      expect(subject.recent_comments.count).to eq 5
      expect(subject.recent_comments.first.text).to eq 'This is my 8 comment'
      expect(subject.recent_comments.last.text).to eq 'This is my 4 comment'
    end
  end

  context '#post_counter' do
    it 'should update the posts_counter of the author' do
      subject.save
      expect(user.posts_counter).to eq 1
      subject.destroy
      expect(user.posts_counter).to eq 0
    end
  end
end
