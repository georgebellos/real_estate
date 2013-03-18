FactoryGirl.define do
  factory :user do
    name "George Bellos"
    sequence(:email) {|n| "foobar#{n}@mail.com" }
    password "foobar81"
    password_confirmation "foobar81"

    factory :invalid_user do
      password nil
    end
    factory :registered_user do
      email "foobar@mail.com"
      password "foobar"
      ignore do
        name false
        password_confirmation false
      end
    end
  end
end
