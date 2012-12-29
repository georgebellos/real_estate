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
    summary 'This is a sample listing'
    association :user

    factory :invalid_property do
      status nil
      price nil
    end
  end
end
