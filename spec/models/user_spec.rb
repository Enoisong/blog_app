require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(name: 'enoisong', photo: 'person.jpg', bio: 'Software developer', posts_counter: 0) }

  context 'Validation measures before saving into the database' do
    before { subject.save }

    it 'should have a valid name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should allow posts_counter with only an integer value' do
      subject.posts_counter = 'abc'
      expect(subject).to_not be_valid
    end

    it 'should only allow posts_counter value greater than or equal to 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end

  context '#recent_posts' do
    it 'should return the latest posts of the user' do
      5.times do |i|
        Post.create(author: subject, title: 'Hello', text: "This is my #{i + 1} post", comments_counter: 0,
                    likes_counter: 0)
      end
      expect(subject.recent_posts.count).to eq 3
      expect(subject.recent_posts[0].text).to eq 'This is my 5 post'
      expect(subject.recent_posts[1].text).to eq 'This is my 4 post'
      expect(subject.recent_posts[2].text).to eq 'This is my 3 post'
    end
  end
end
