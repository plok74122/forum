require 'rails_helper'

RSpec.describe 'auth_fb_reuqest', type: :request do
  before do
    @user = User.create!(:email => Faker::Internet.email,
                         :password => 'qwer4321',
                         :confirmed_at => Faker::Time.between(DateTime.now - 15, DateTime.now)
    )
  end
  describe "facebook" do
    it "should login by facebook access_token (not existing)" do
      fb_data = {
          "id" => "5678",
          "email" => "foobar@example.org",
          "name" => "plok74122"
      }
      # moke
      expect(User).to receive(:get_fb_data).with("fb-token-xxxx").and_return(fb_data)

      post "/api/v1/login" , :access_token => "fb-token-xxxx"

      expect(response).to have_http_status(200)

      user = User.last
      data = {
          "auth_token" => user.authentication_token,
          "user_id" => user.id
      }

      expect(JSON.parse(response.body)).to eq(data)
    end

    it "should login by facebook access_token (existing)" do
      fb_data = {
          "id" => "1234",
          "email" => @user.email,
          "name" => "plok74122"
      }
      expect(User).to receive(:get_fb_data).with("fb-token-oooo").and_return(fb_data)

      post "/api/v1/login" , :access_token => "fb-token-oooo"

      expect(response).to have_http_status(200)

      data = {
          "auth_token" => @user.authentication_token,
          "user_id" => @user.id
      }

      expect(JSON.parse(response.body)).to eq(data)
    end

    it "should login failed" do
      expect(User).to receive(:get_fb_data).with("fb-token-uuuu").and_return(nil)
      post "/api/v1/login" , :access_token => "fb-token-uuuu"
      expect(response).to have_http_status(401)
    end
  end
end
