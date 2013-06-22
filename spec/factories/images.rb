FactoryGirl.define do
  factory :image do
    property
    PictureUploader.enable_processing = false
    process_attachment_upload true
    attachment { File.open(Rails.root + 'spec/support/files/property.png') }

    factory :invalid_image do
      attachment { File.open(Rails.root + 'spec/support/files/wrong_file_type.txt')}
    end

    factory :image_with_versions do
      PictureUploader.enable_processing = true
    end
  end
end
