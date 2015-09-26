require 'singleton'

class PublishToFbService
  include Singleton

  def initialize
    @oauth = Koala::Facebook::OAuth.new(ENV["FACEBOOK_KEY"], ENV["FACEBOOK_SECRET"])
    @page_name = Setting['page_name'].gsub(/\s+/, "")
  end

  def publish(post)
    return nil unless get_page_graph
    current_number = post_number
    page_name_tag = '#' + @page_name + current_number.to_s
    post_category = post.category_list.map { |t| '#' + t }.join(' ')
    content = page_name_tag + ' ' + post_category + "\n" + post.content
    get_page_graph.put_wall_post(content)
    self.post_number += 1
    current_number
  end

  def post_number
    Setting['start_number'].to_i
  end

  def get_admin_pages(auth_token)
    @longer_user_graph ||= get_longer_user_graph(auth_token)
    pages = @longer_user_graph.get_connections('me', 'accounts')
    admin_pages_names = pages.map do |page|
      page['name'] if page['perms'].include?('ADMINISTER')
    end
    admin_pages_names.compact
  end

  def get_fb_page_token(page_name)
    pages = @longer_user_graph.get_connections('me', 'accounts')
    fb_page = pages.find { |page| page['name'] == page_name }
    fb_page['access_token']
  end

  private

  def post_number=(number)
    Setting['start_number'] = number
  end

  def get_longer_user_graph(auth_token)
    new_access_info = @oauth.exchange_access_token_info(auth_token)
    long_access_token = new_access_info['access_token']
    @longer_user_graph = Koala::Facebook::API.new(long_access_token)
  end

  def get_page_graph
    return nil if Setting['fb_page_token'].blank?
    if @page_graph && (@page_graph.access_token == Setting['fb_page_token'])
      return @page_graph
    end
    @page_graph = Koala::Facebook::API.new(Setting['fb_page_token'])
  end
end
