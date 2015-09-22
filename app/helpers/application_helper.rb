module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def local_time(datetime)
    dt = logged_in? ? datetime.in_time_zone(current_user.time_zone) : datetime
    dt.strftime("%d %b %Y %H:%M %Z")
  end
end
