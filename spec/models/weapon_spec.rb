require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it "Testa a funcao title da model, ve se ta funcionando direito a criacao do nome" do
    weapon = Weapon.create(name: 'Excalibur', description:'Some old sword', power_step: 100, power_base: 3000, level:1 )
    expect(weapon.title).to eq('Excalibur #100')
  end  

  it "Testa a funcao current_power da model, Returns the correct current_power" do
    weapon = Weapon.create(name: 'Excalibur', description:'Some old sword', power_step: 100, power_base: 3000, level:1 )
    expect(weapon.current_power).to eq(3000)
  end  

  it 'Confirma que não cria passando param errado' do
  expect(Weapon.create(name:'errado', outrosparams:"errados")).to_not be_valid
  end
 
end
