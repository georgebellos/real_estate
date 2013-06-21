require 'spec_helper'

describe Property do
  it 'has a valid factory' do
    expect(create :property).to be_valid
  end

  %w{ floor_size price status bedroom bathroom parking
      street street_number city year category }.each do |attr|
    it "is invalid without #{ attr }" do
      expect(build :property, attr.to_sym => nil).not_to be_valid
    end
  end

  %w{ floor_size bathroom bedroom parking street_number }.each do |attr|
    it "is invalid when #{ attr } is not a number " do
      expect(build :property, attr.to_sym => "string").not_to be_valid
    end
  end

  it 'is invalid with a summary longer than 800 characters' do
    expect(build :property, summary: "a" * 801).to have(1).errors_on(:summary)
  end

  it 'is invalid with a construction year before 1900' do
    expect(build :property, year: 1850).to have(1).errors_on(:year)
  end

  describe "#title" do
    it 'returns the property status and category as a full string' do
      expect((build :property).title).to eql "Rent Apartment"
    end
  end

  describe '#favoritable_by?' do
    it 'returns true for users who can favorite a property' do
      user = create :user
      property = create :property
      expect(property.favoritable_by? user).to be_true
    end

    it 'returns false for the owner of the property' do
      user = create :user
      property = create :property, user: user
      expect(property.favoritable_by? user).to be_false
    end

    it 'returns false when a user has already favorited the property' do
      user = create :user
      property = create :property
      user.favorites << property
      expect(property.favoritable_by? user).to be_false
    end
  end
end
