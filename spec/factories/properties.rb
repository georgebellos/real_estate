FactoryGirl.define do
  factory :property do
    status 'Rent'
    price '200'
    floor_size 100
    bathroom 2
    bedroom 5
    parking 2
    year 1981
    street 'Doiranis'
    street_number 39
    city 'Patra'
    summary 'Lorem ipsum'
    category 'Apartment'
    user

    factory :invalid_property do
      status nil
      price nil
    end

    factory :property_with_images do
      ignore do
        number_of_images 3
      end
      after(:create) do |property, evaluator|
        FactoryGirl.create_list(:image, evaluator.number_of_images, property: property)
      end
    end
  end
end
