require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do

    it "returns http success" do
      #get "/users/index" ta errado, era pra ser get "/users"
      get users_path
      expect(response).to have_http_status(:success)
    end

    it "the user's title is present" do
      user1 = User.create(nickname: 'Chronos', kind: :wizard, level: 1)
      user2 = User.create(nickname: 'Jonas', kind: :wizard, level: 1)
      user3 = User.create(nickname: 'Carlos', kind: :wizard, level: 1)
      ###****precisa criar através de model senao nao cria o method title
      ###factory BOT daria pra criar variose fazer loop
      #user1 =  {nickname: 'carlos', kind: :wizard, level: 5}
      #user2 = {nickname: 'jonas', kind: :wizard, level: 50}
      #user3 = {nickname: 'carlos', kind: :wizard, level: 10}
      users = [user1,user2,user3]
      get users_path
      users.each do |user|
      expect(response.body).to include(user.title)
      end

    end
  end







  describe "POST /users" do

  context "when it hass valids params" do
    it "creates with correct attribs" do      
      user_attributes = {nickname: 'Thiago', kind: 'wizard', level: 5}
      post users_path, params: {user: user_attributes}
      expect(User.last).to have_attributes(user_attributes)
    end

  end

  context "when it has no valids params" do
    it "dont create" do      
      user_attributes = {nickname: '', kind: '', level:''}      
      expect{post users_path, params: {user: user_attributes}}.to_not change(User, :count)
    end
  end
  end

 # describe "GET /create" do
  #  it "returns http success" do
    #  get "/users/create"
    #  expect(response).to have_http_status(:success)
   # end
  #end

end
