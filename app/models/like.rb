class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :likes_counter
  after_destroy :likes_counter

  private

  def likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
