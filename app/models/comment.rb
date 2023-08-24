class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :comments_counter
  after_destroy :comments_counter

  private

  def comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
