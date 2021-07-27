require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject {
    User.new(first_name: "Tom", last_name: "Toms", email: "tom@toms.com", password: 'password', password_confirmation: 'password')
  }

  describe 'Validations' do

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

# Password Validation 

    it "is not valid when password and password_confirmation are not matching" do
      subject.password = "xxxx"
      expect(subject).to_not be_valid
    end

    it "is not valid if the password is 3 characters or less" do
      subject.password = "x"
      subject.password_confirmation ="x"
      expect(subject).to_not be_valid
    end

# email validation 

    it "is not valid if email already exists" do
      User.create(first_name: "Tom",
               last_name: "Toms",
               email: "tom@toms.com",
               password: "password",
               password_confirmation: "password"
              )
      expect(subject).to_not be_valid
    end

    it "is not valid if email is not unique without caplocks" do
      User.create(first_name: "Tom",
               last_name: "Toms",
               email: "TOM@TOMS.COM",
               password: "password",
               password_confirmation: "password"
              )

      expect(subject).to_not be_valid
    end

# Not Valid if Blank 

    it "is not valid if email is blank" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if first_name field is left blank" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if last_name field is left blank" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

  end



  describe '.authenticate_with_credentials' do

    it 'should match email and password' do
      user = User.create(first_name: 'Tom', last_name: 'Toms',
        email: 'tom@toms.com', password: 'password',
        password_confirmation: 'password')

      session = User.authenticate_with_credentials('tom@toms.com', 'password')
      expect(session).to eq user
    end

# EDGE CASES

    it 'should match even when wrong case is entered into email field' do
      user = User.create(first_name: 'Tom', last_name: 'Toms',
        email: 'tom@toms.com', password: 'password',
        password_confirmation: 'password')

      session = User.authenticate_with_credentials('TOM@TOMS.COM ', 'password')
      expect(session).to eq user
    end


    it 'should match even when there is extra space in front of email' do
      user = User.create(first_name: 'Tom', last_name: 'Toms',
        email: 'tom@toms.com', password: 'password',
        password_confirmation: 'password')

      session = User.authenticate_with_credentials('  tom@toms.com', 'password')
      expect(session).to eq user
    end

    it 'should match even when there is extra space at the end of the email' do
      user = User.create(first_name: 'Tom', last_name: 'Toms',
        email: 'tom@toms.com', password: 'password',
        password_confirmation: 'password')

      session = User.authenticate_with_credentials('tom@toms.com  ', 'password')
      expect(session).to eq user
    end

  end
end
