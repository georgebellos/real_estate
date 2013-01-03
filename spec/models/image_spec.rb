require 'spec_helper'

describe Image do
  include CarrierWave::Test::Matchers

  it 'has a valid factory' do
    expect(build :image).to be_valid
  end
end
