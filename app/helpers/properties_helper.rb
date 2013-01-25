module PropertiesHelper
  def thumbnail(property)
    image = property.images.first
    image ? image.attachment.url(:normal) : Image.new.attachment.url
  end
end

