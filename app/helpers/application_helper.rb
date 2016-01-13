module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_dt(dt)
    dt.strftime("%d/%m/%Y %l:%M:%P %Z")
  end

  def display_zone(dt)
    dt.localtime.strftime("%Z")
  end
end
