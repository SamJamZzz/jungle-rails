require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validation: ' do
    it 'password and password confirmation fields should be equivalent' do
      @user = User.create(name: 'Test', email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      expect(@user.password).to eq @user.password_confirmation
    end

    it 'password and password confirmation fields are not equivalent' do
      @user = User.create(name: 'Test', email: 'test@gmail.com', password: 'test123', password_confirmation: 'test')
      expect(@user.password).not_to eq @user.password_confirmation
    end

    it '2 users having the same email are not allowed' do
      @user1 = User.create(name: 'Test', email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      @user2 = User.create(name: 'Test', email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      expect(@user1).to be_present
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it '2 users having unique emails' do
      @user1 = User.create(name: 'Test', email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      @user2 = User.create(name: 'Test', email: 'test123@gmail.com', password: 'test', password_confirmation: 'test')
      expect(@user1).to be_present
      expect(@user2.errors.full_messages).not_to include("Email has already been taken")
    end

    it 'name and email are present' do
      @user = User.create(name: 'Test', email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      expect(@user.name).to be_present
      expect(@user.email).to be_present
      expect(@user.valid?).to be true
    end

    it 'name is not present' do
      @user = User.create(name: nil, email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      expect(@user.name).to be nil
      expect(@user.email).to be_present
      expect(@user.valid?).not_to be true
    end

    it 'password is greater than minimum length' do
      @user = User.create(name: 'Test', email: 'test@gmail.com', password: 'tes', password_confirmation: 'tes')
      expect(@user.errors.full_messages).not_to include("Password is too short (minimum is 2 characters)")
    end

    it 'password is equal to minimum length' do
      @user = User.create(name: 'Test', email: 'test@gmail.com', password: 'te', password_confirmation: 'te')
      expect(@user.errors.full_messages).not_to include("Password is too short (minimum is 2 characters)")
    end

    it 'password is less than minimum length' do
      @user = User.create(name: 'Test', email: 'test@gmail.com', password: 't', password_confirmation: 't')
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 2 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'user successfully logs in with correct email and password' do
      @user = User.create(name: 'Test', email: 'test@gmail.com', password: 'test', password_confirmation: 'test')
      @result = User.authenticate_with_credentials('test@gmail.com', 'test')
      expect(@result).to eq @user
    end

    it 'user unsuccessfully logs in with incorrect email' do
      @user = User.create(name: 'Test', email: 'test123@gmail.com', password: 'test', password_confirmation: 'test')
      @result = User.authenticate_with_credentials('test@gmail.com', 'test')
      expect(@result).to eq nil
    end

    it 'user unsuccessfully logs in with incorrect password' do
      @user = User.create(name: 'Test', email: 'test@gmail.com', password: 'test123', password_confirmation: 'test')
      @result = User.authenticate_with_credentials('test@gmail.com', 'test')
      expect(@result).to eq nil
    end
  end
end