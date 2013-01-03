FactoryGirl.define do
  factory :image do
    attachment { File.open(Rails.root + 'spec/support/files/property.png') }
    property
  end
end
