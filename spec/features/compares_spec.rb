feature 'Compare Properties' do
  background do
    @property1 = create :property
    @property2 = create :property
    @property3 = create :property
    @property4 = create :property
  end
  scenario 'Add a property listing to compare list' do
    visit property_path(@property1)
    click_link 'Compare it'
    expect(page).to have_content 'Rent Apartment'
    visit property_path(@property2)
    click_link 'Compare it'
    expect(page).to have_content 'Rent Apartment'
    visit property_path(@property3)
    click_link 'Compare it'
    expect(page).to have_content 'Rent Apartment'
  end

  scenario 'Add a property listing to a full compare list' do
    visit property_path(@property1)
    click_link 'Compare it'
    expect(page).to have_content 'Rent Apartment'
    visit property_path(@property2)
    click_link 'Compare it'
    expect(page).to have_content 'Rent Apartment'
    visit property_path(@property3)
    click_link 'Compare it'
    expect(page).to have_content 'Rent Apartment'
    visit property_path(@property4)
    click_link 'Compare it'
    expect(page).to have_content 'You can compare at most 3 listings'
  end

  scenario 'Add a property that is already in the compare list' do
    visit property_path(@property1)
    click_link 'Compare it'
    visit property_path(@property1)
    click_link 'Compare it'
    expect(page).to have_content 'Property listing is already on the compare list'
  end
end

feature 'Clear Compare List' do
  background do
    @property1 = create :property
  end
  scenario 'Remove a property from compare list' do
    visit property_path(@property1)
    click_link 'Compare it'
    click_link 'Remove from list'
    expect(page).not_to have_content 'Rent Apartment'
  end

  scenario 'Reset compare list' do
    visit property_path(@property1)
    click_link 'Compare it'
    click_link 'Reset compare list'
    page.should
    expect(page).not_to have_xpath("//table")
  end
end
