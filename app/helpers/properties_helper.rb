module PropertiesHelper
  def thumbnail(property)
    image = property.images.first
    image ? image.attachment.url(:medium) : Image.new.attachment.url
  end

  def property_search_results(properties)
    if properties.total_count > 0
      content_tag(:div, "Found #{ properties.total_count } property listings with this search criteria'",
                  class: 'alert alert-info alert-block')
    else
      content_tag(:div, "No property listings were found with this search criteria",
                  class: 'alert alert-block')
    end
  end

  def summary(property)
    if controller.action_name == "buy" || controller.action_name == "rent"
      property.category
    else
      property.title
    end
  end
end

