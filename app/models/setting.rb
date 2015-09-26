# RailsSettings Model
class Setting < RailsSettings::CachedSettings
  class << self
    def categories
      self.category_list.join(',')
    end

    def categories=(names)
      self.category_list = names.split(',').map(&:strip)
    end

    def update_attributes(params)
      params.each_pair { |k, v| send("#{k}=", v) }
    end

    def update_fb_token
      Setting['fb_page_token'] = PublishToFbService.instance.get_fb_page_token(Setting['fb_page'])
    end

    def is_auto_post?
      self.auto_post == 'false' ? false : !!self.auto_post
    end
  end
end
