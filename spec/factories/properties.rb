FactoryGirl.define do
  factory :property do
    status 'Rent'
    price '200'
    area 100
    year 1981
    street 'Doiranis'
    street_number 39
    summary 'This is a sample listing'
    association :user

    factory :invalid_property do
      status nil
      price nil
      area nil
    end
  end
end
