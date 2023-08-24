class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_create :update_post_counter
  after_destroy :update_post_counter
  after_save :update_post_counter

  def recent_comments
    comments.last(5).reverse
  end

  private

  def update_post_counter
    author.update(posts_counter: author.posts.count)
  end
end
