module ApplicationHelper
  def admin_published_posts_path
    admin_posts_path(published: true)
  end

  def admin_published_posts_url
    admin_posts_url(published: true)
  end
end
