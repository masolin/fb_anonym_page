module ApplicationHelper
  def published_posts_path
    posts_path(published: true)
  end

  def published_posts_url
    posts_url(published: true)
  end
end
