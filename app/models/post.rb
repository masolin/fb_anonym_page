class Post < ActiveRecord::Base
  acts_as_taggable

  validates :content, presence: true, length: { maximum: 63_206 }

  scope :published, -> (boolean = true) { where(published: boolean) }
  scope :recent, -> { order(created_at: :desc) }

  def to_fb_page
    publish_number = PublishToFbService.instance.publish(self)
    update_attributes(published: true, publish_number: publish_number)
  end
end
