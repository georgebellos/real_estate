module PropertiesHelper
  def thumbnail(property)
    image = property.images.first
    image ? image.attachment.url(:normal) : Image.new.attachment.url
  end

  def property_search_results(properties)
    if properties.size > 0
      content_tag(:div, "Found #{ properties.size } property listings with this search criteria'",
                  class: '"alert alert-info alert-block' )
    else
      content_tag(:div, "No property listings were found with this search criteria",
                  class: 'alert alert-block')
    end
  end
end

