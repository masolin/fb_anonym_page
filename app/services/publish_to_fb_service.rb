require 'singleton'

class PublishToFbService
  include Singleton

  def initialize
    @page_graph = Koala::Facebook::API.new(ENV['page_token'])
    @page_name = Setting['page_name'].gsub(/\s+/, "")
  end

  def publish(post)
    current_number = post_number
    page_name_tag = '#' + @page_name + current_number.to_s
    post_category = post.category_list.map { |t| '#' + t }.join(' ')
    content = page_name_tag + ' ' + post_category + "\n" + post.content
    @page_graph.put_wall_post(content)
    self.post_number += 1
    current_number
  end

  def post_number
    Setting['start_number'].to_i
  end

  private

  def post_number=(number)
    Setting['start_number'] = number
  end
end
