module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def local_time(datetime)
    datetime.in_time_zone('Eastern Time (US & Canada)').strftime("%d %b %Y %H:%M")
  end
end
