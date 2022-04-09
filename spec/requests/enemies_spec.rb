require 'rails_helper'
#require 'Enemy'

RSpec.describe "Enemies", type: :request do

  describe "PUT /enemies" do

    context 'Quando o inimigo é encontrado/criado na table e da certo' do

      it 'cria um inimigo, consegue alterar o inimigo e devolve 200 no http-status' do
        enemy = Enemy.create(name:'dragon Lord', power_base:5000, power_step:4000, level:90, kind:'dragon')
        #puts enemy.inspect
        patch "/enemies/#{enemy.id}", params: {name:'fera Lord', power_base:60000, power_step:4000, level:90, kind:'dragon'}
        expect(response).to have_http_status(200)
      end

      it 'Cria inimigo, altera inimigo e espera que o ultimo inimigo seja o mesmo que foi criado' do
        enemy = Enemy.create(name:'dragon Lord', power_base:5000, power_step:4000, level:90, kind:'dragon')
        #puts enemy.inspect
        patch "/enemies/#{enemy.id}", params: {name:'fera Lord', power_base:60000, power_step:4000, level:90, kind:'dragon'}       
        expect(enemy.reload).to have_attributes(name:'fera Lord', power_base:60000, power_step:4000, level:90, kind:'dragon')
      end

      it 'Cria o inimigo, altera, e vê se ta devolvendo o json correto menos os dados nao enviados/except' do
        enemy = Enemy.create(name:'dragon Lord', power_base:5000, power_step:4000, level:90, kind:'dragon')
        #puts enemy.inspect
        patch "/enemies/#{enemy.id}", params: {name:'fera Lord', power_base:60000, power_step:4000, level:90, kind:'dragon'}
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
        #essas linhas eram usadas antes de criar rspec/helper/support com o module json
        #json_response = JSON.parse(response.body)
        # expect(enemy.reload).to have_attributes(json_response.except('created_at', 'updated_at'))
      end
    end

    context 'Quando o inimigo não é encontrado na table' do

      it 'Devolve 404 quando não acha inimigo pra ser alterado' do
        put '/enemies/0', params: {name:'fera Lord', power_base:60000, power_step:4000, level:90, kind:'dragon'}
        expect(response).to have_http_status(404)
      end

      ##testa se o controller ta respondendo o rescue certo do controller set_enemy/etc
      it 'returns a not found message ' do
        put '/enemies/0', params: {name:'fera Lord', power_base:60000, power_step:4000, level:90, kind:'dragon'}
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "Delete /enemies" do
    context 'quando inimigo existe' do

      it "return status code 204" do
        enemy = Enemy.create(name:'dragon Lord', power_base:5000, power_step:4000, level:90, kind:'dragon')
        #puts enemy.inspect
        delete "/enemies/#{enemy.id}"
        expect(response).to have_http_status(204)
      end

      #faz o reload pra recarregar, força o erro
      it "destroy de record" do
        enemy = Enemy.create(name:'dragon Lord', power_base:5000, power_step:4000, level:90, kind:'dragon')
        #puts enemy.inspect
        delete "/enemies/#{enemy.id}"
        expect {enemy.reload}.to raise_error ActiveRecord::RecordNotFound
      end

    end

    context 'quado nao tem inimigos' do
      it "return status code 404" do
        delete "/enemies/0"
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message ' do
        delete '/enemies/0'
        expect(response.body).to match(/Couldn't find Enemy/)
      end

    end





  end
end

