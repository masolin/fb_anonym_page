# RailsSettings Model
class Setting < RailsSettings::CachedSettings
  def self.categories
    self.category_list.join(',')
  end

  def self.categories=(names)
    self.category_list = names.split(',').map(&:strip)
  end

  def self.update_attributes(params)
    params.each_pair { |k, v| send("#{k}=", v) }
  end
end
