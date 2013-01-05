require 'spec_helper'

describe Property do
  it 'has a valid factory' do
    expect(create :property).to be_valid
  end

  %w{floor_size price status bedroom bathroom parking street street_number year category }.each do |attr|
    it "is invalid without #{ attr }" do
      expect(build :property, attr.to_sym => nil).not_to be_valid
    end
  end
  %w{ floor_size bathroom bedroom parking street_number }.each do |attr|
    it "is invalid when #{ attr } is not a number " do
      expect(build :property, attr.to_sym => "string").not_to be_valid
    end
  end

  it 'is invalid with a summary longer than 400 characters' do
    expect(build :property, summary: "a" * 401).not_to be_valid
  end

  it 'is invalid with a construction year before 1900' do
    expect(build :property, year: 1850).not_to be_valid
  end
end
