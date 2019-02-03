# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(username: "Username", password: "password") }
  describe "validations" do
    
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:session_token)}

  end

  describe "passwords" do
    
    describe '#password=' do 

      it 'sets @password to password' do
        user.password=("new_password")
        expect(user.password).to eq("new_password")
      end

      it 'it sets a users password_digest' do
        user.password=("new_password")
        expect(user.password_digest).not_to be_nil
     end

     describe '#is_password?' do 
        it 'confirms the right password' do
          user.password=("new_password")
          expect(user.is_password?("new_password")).to be_truthy
        end
        it 'returns false if password is incorrect' do
          user.password=("new_password")
          expect(user.is_password?("bad_password")).to be_falsey
        end 
     end
    end
  end

  describe "sessions" do
    describe "#ensure_session_token" do
      it 'assigns a session token if no session token exists' do
        expect(user.session_token).not_to be nil 
      end
    end

    describe "#reset_session_token!" do
      it 'resets the session token' do
        # user.ensure_session_token
        # user.password = "password"
        old_session_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).not_to eq(old_session_token)
      end 
    end
  end
end
