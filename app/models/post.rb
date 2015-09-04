class Post < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 63_206 }

  def to_fb_page
    @@page_graph ||= Koala::Facebook::API.new(ENV['page_token'])
    @@page_graph.put_wall_post(content)
    update_attribute(:published, true)
  end
end
