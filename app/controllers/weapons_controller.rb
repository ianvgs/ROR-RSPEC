class WeaponsController < ApplicationController 

  def index
    @weapons = Weapon.all
  end  

  def create
    @weapon = Weapon.create(weapon_params)
    redirect_to weapons_path
  end


  def delete
    @weapon.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
    redirect_to weapons_path
  end

  def show
    #assim manda informação pra view
     @weapon = Weapon.find(params[:id])

    #assim devolve informacao na api (json)
    #weapon = Weapon.find(params[:id])
    #render json: {status: 'SUCESS', message: 'Loaded article', data:weapon}, status: :ok
  end

  
  private
  def weapon_params    
    params.require(:weapons).permit(:name, :description, :power_step, :power_base, :level)
  end  


end
