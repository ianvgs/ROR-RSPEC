require 'rails_helper'

RSpec.describe User, type: :model do
  it "Testa se a classe user está devolvendo o titulo corretamente quando passado os params" do
    #nickname= FFaker::Name.first_name
    #kind = %i[wizard kngith].sample
    #level = FFaker::Random.rand(1..99)    
    #user = User.create(nickanem: nickname, kind: kind, level:level)
    #expect(user.title).to eq("#{kind} #{nickname} ##{level}")
    user = User.create(nickname: 'Chronos', kind: :wizard, level: 1)
    expect(user.title).to eq('wizard Chronos #1')
  end  

  it "Testa pra que não seja valido se passar param errado tipo o lvl maior que 99" do
   expect(User.create(nickname: 'Chronos', kind: :wizard, level: 100)).to_not be_valid
    #nickname = FFaker::Name.first_name
    #kind = %i[knight wizard].sample
    #level = FFaker::Random.rand(100..9999)
    #user = User.new(nickname: nickname, kind: kind, level: level)
    #expect(user).to_not be_valid
  end
end
