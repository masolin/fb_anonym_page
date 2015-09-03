class Post < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 63_206 }
end
