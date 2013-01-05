module PropertySteps
  def fill_in_property_form(image = false)
    visit new_property_path
    select 'Rent', from: 'Status'
    select 'Apartment', from: 'Category'
    fill_in 'Floor size', with: '100'
    fill_in 'Bedroom', with: '4'
    fill_in 'Bathroom', with: '2'
    fill_in 'Parking', with: '1'
    fill_in 'Price', with: '300'
    fill_in 'Street', with: 'kefallinias'
    fill_in 'Number', with: '45'
    fill_in 'Year', with: '1981'
    fill_in 'Summary', with: 'Lorem ipsum dolor sit amet incididunt'
    attach_file 'Picture', Rails.root + 'spec/support/files/property.png' if image
  end
end
