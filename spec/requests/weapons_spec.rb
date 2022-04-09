require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /index" do
    it "returns http success" do
      #get "/users/index" ta errado, era pra ser get "/users"
      get weapons_path
      expect(response).to have_http_status(:success)
    end

    it "the weapons's title is present" do
      wp1 = Weapon.create( name: "Tesouro", description: "Tresure em ingles", power_base: 150, power_step:3000, level: 600)
      wp2 = Weapon.create( name: "Thais", description: "Cidade do tibia", power_base: 150, power_step:3000, level: 600)
      wp3 = Weapon.create( name: "Linkin Park", description: "Banda de rock", power_base: 150, power_step:3000, level: 600)
      ###****precisa criar através de model senao nao cria o method title
      ###factory BOT daria pra criar variose fazer loop
      #user1 =  {nickname: 'carlos', kind: :wizard, level: 5}
      #user2 = {nickname: 'jonas', kind: :wizard, level: 50}
      #user3 = {nickname: 'carlos', kind: :wizard, level: 10}
      wps = [wp1,wp2,wp3]
      get weapons_path
      wps.each do |weapon|
        expect(response.body).to include(weapon.title)
      end
    end
  end


  describe "POST /weapons" do
    context "when it hass valids params" do
      it "creates with correct attribs" do
        weapon_attributes = {name: "Thais", description: "Cidade do tibia", power_base: 150, power_step:3000, level: 600}
        post weapons_path, params: {weapons: weapon_attributes}
        expect(Weapon.last).to have_attributes(weapon_attributes)
      end
    end
    context "when it has no valids params" do
      it "dont create" do
        weapon_attributes = {name: "", carne_assada: "", power_base:'', power_step:'', level: ''}
        expect{post weapons_path, params: {weapon: weapon_attributes}}.to_not change(Weapon, :count)
      end
    end
  end

  describe "Delete /weapons/{id}" do
    context "when it has valids params" do
      it "dont create" do
        weapon_attributes = {name: "", carne_assada: "", power_base:'', power_step:'', level: ''}
        expect{post weapons_path, params: {weapon: weapon_attributes}}.to_not change(Weapon, :count)
      end
    end
  end





end
