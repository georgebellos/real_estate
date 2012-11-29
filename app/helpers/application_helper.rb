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
end
