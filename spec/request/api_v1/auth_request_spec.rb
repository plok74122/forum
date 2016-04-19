require 'rails_helper'

RSpec.describe 'API_auth', type: :request do
  before do
    @user = User.create!(:email => Faker::Internet.email,
                         :password => 'qwer4321',
                         :confirmed_at => Faker::Time.between(DateTime.now - 15, DateTime.now)
    )
  end

  describe "POST /api/v1/login" do
    it "should return error message" do
      post "/api/v1/login"

      data = {"message" => "email or password is not correct"}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq(data)
    end

    it "should return token if email and password are correct" do
      post "/api/v1/login", :email => @user.email, :password => 'qwer4321'

      data = {
          "user_id" => @user.id,
          "auth_token" => @user.authentication_token
      }
      expect(response).to have_http_status(200)

      expect(JSON.parse(response.body)).to eq(data)

    end
  end

  describe "POST /api/v1/logout" do
    it "should reset authentication_token" do
      old_token = @user.authentication_token
      post "/api/v1/logout", :auth_token => @user.authentication_token
      @user.reload
      expect(response).to have_http_status(200)
      expect(@user.generate_authentication_token).to_not eq(old_token)
    end
    it "should return 401 if token is wrong" do
      post "/api/v1/logout", :auth_token => "ooxx"

      expect(response).to have_http_status(401)
    end
  end
end
