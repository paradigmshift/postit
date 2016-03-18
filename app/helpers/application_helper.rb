module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_dt(dt)
    if logged_in?
      dt.in_time_zone(current_user.time_zone).strftime("%d/%m/%Y %l:%M:%P ")
    else

      dt.strftime("%d/%m/%Y %l:%M:%P UTC")
    end
  end

  OFFSET = 10

end
