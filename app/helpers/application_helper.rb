module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "flash--notice"
    when :success then "flash--success"
    when :error then "flash--error"
    when :alert then "flash--alert"
    else "flash--info"
    end
  end
end
