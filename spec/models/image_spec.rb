require 'spec_helper'

describe Image do
  include CarrierWave::Test::Matchers

  before do
    PictureUploader.enable_processing = false
    #PictureUploader.enable_processing = true
  end

  after do
    PictureUploader.enable_processing = true
  end

  it 'has a valid factory' do
    expect(create :image).to be_valid
  end

  it 'is invalid without an attachment' do
    expect(build :image, attachment: nil).to have(1).errors_on(:attachment)
  end

  %w{ jpeg jpg gif png }.each do |type|
    it "is valid with type: #{type}" do
      expect(build :image, attachment: File.open(
    Rails.root + "spec/support/files/property.#{type}")).to be_valid
    end
  end

  it "is invalid with type other than 'png, jpeg, jpg, gif'" do
    expect(build :image, attachment: File.open(
      Rails.root + 'spec/support/files/wrong_file_type.txt')).not_to be_valid
  end

  it 'is invalid with size over 2 mb' do
    expect(build :image, attachment: File.open(
      Rails.root + 'spec/support/files/over_2mb_image.png')).not_to be_valid
  end

  context 'versions' do
    before do
      PictureUploader.enable_processing = true
    end

    after do
      PictureUploader.enable_processing = false
    end

    describe 'small' do
      it 'scales down an image to be exactly 50 by 50 pixels' do
        expect((create :image_with_versions).attachment.small).to have_dimensions(50, 50)
      end
    end

    describe 'normal' do
      it 'scales down an image bigger than 720 by 450 pixel to be exactly 720 by 450 pixels' do
        expect((create :image_with_versions).attachment.normal).to have_dimensions(720, 450)
      end
    end

    describe 'medium' do
      it 'scales down an image to be exactly 218 by 145 pixels' do
        expect((create :image_with_versions).attachment.medium).to have_dimensions(218, 145)
      end
    end

    describe 'list_thumb' do
      it 'scales down an image to be exactly 280 by 186 pixels' do
        expect((create :image_with_versions).attachment.large).to have_dimensions(280, 186)
      end
    end

    describe 'featured' do
      it 'scales down an image to be exactly 768 by 466 pixels' do
        expect((create :image_with_versions).attachment.featured).to have_dimensions(768, 466)
      end
    end
  end
end
