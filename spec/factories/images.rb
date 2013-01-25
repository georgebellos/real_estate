FactoryGirl.define do
  factory :image do
    process_attachment_upload  true
    attachment { File.open(Rails.root + 'spec/support/files/property.png') }
    property

    factory :invalid_image do
      attachment { File.open(Rails.root + 'spec/support/files/wrong_file_type.txt')}
    end
  end
end
