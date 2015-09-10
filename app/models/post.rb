class Post < ActiveRecord::Base
  acts_as_taggable_on :categories

  validates :content, presence: true, length: { maximum: 63_206 }

  scope :published, -> (boolean = true) { where(published: boolean) }
  scope :recent, -> { order(created_at: :desc) }

  def to_fb_page
    return if published
    publish_number = PublishToFbService.instance.publish(self)
    update_attributes(published: true, publish_number: publish_number)
  end
end
