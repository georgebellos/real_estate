module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def description(page_description)
    content_for(:description) { page_description }
  end

  def yield_or_default(section, default='')
    content_for?(section) ? content_for(section) + " | " + default : default
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when :success
      "alert-success"
    when :error
      "alert-error"
    when :alert
      "alert-block"
    when :notice
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def social_action
    controller_name != "registrations" ?  "Log in" : "Sign up"
  end
end
