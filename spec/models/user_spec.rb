require 'spec_helper'

describe User do

  context "registration" do

    it "is succesfull with valid attributes" do
      expect(create :user).to be_valid
    end

    it 'is invalid without an email address' do
      expect(build(:user, email: nil)).not_to be_valid
    end

    it 'is invalid with a bad formated email address' do
      expect(build(:user, email: 'foobar.mail.com')).not_to be_valid
    end

    it 'is invalid when another user has register with the same email address' do
      create(:user, email: 'test@email.com')
      expect(build(:user, email: 'test@email.com')).not_to be_valid
    end

    it 'is invalid without a password' do
      expect(build(:user, password: nil)).not_to be_valid
    end

    it 'is invalid without a password confirmation' do
      expect(build(:user, password_confirmation: nil)).not_to be_valid
    end

    it 'is invalid when password does not match password confirmation' do
      expect(build(:user, password_confirmation: "not_foobar")).not_to be_valid
    end

    it 'is invalid with a password less than 6 characters' do
      expect(build(:user, password: "g" * 5, password_confirmation: "g" * 5 )
            ).not_to be_valid
    end

    it 'is invalid with password longer than 32 characters' do
      expect(build(:user, password: "g" * 33, password_confirmation: "g" * 31)
            ).not_to be_valid
    end
  end
end
