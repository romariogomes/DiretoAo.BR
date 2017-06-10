namespace :project do

  desc "Populate State table"
  task seed_state: :environment do

	  ESTADOS_BRASILEIROS = {
	  :AC=>"Acre", 
	  :AL=>"Alagoas", 
	  :AP=>"Amapá", 
	  :AM=>"Amazonas", 
	  :BA=>"Bahia", :CE=>"Ceará", 
	  :DF=>"Distrito Federal", 
	  :ES=>"Espírito Santo", 
	  :GO=>"Goiás", 
	  :MA=>"Maranhão", 
	  :MT=>"Mato Grosso", 
	  :MS=>"Mato Grosso do Sul", 
	  :MG=>"Minas Gerais", 
	  :PA=>"Pará", 
	  :PB=>"Paraíba", 
	  :PR=>"Paraná", 
	  :PE=>"Pernambuco", 
	  :PI=>"Piauí", 
	  :RJ=>"Rio de Janeiro", 
	  :RN=>"Rio Grande do Norte", 
	  :RS=>"Rio Grande do Sul", 
	  :RO=>"Rondônia", 
	  :RR=>"Roraima", 
	  :SC=>"Santa Catarina", 
	  :SP=>"São Paulo", 
	  :SE=>"Sergipe", 
	  :TO=>"Tocantins"
	  }

  	ESTADOS_BRASILEIROS.each do |key, array|
	  
	  state = State.new

	  sigle = ESTADOS_BRASILEIROS.key(array).to_s
	  value = ESTADOS_BRASILEIROS.values_at(key)
	  
	  state.state_name = sigle
	  state.save	  
	end
  end

  desc "Populate Charge table"

  task seed_charge: :environment do
  	
  	chargeArray = ["DEPUTADO ESTADUAL", "DEPUTADO FEDERAL", "GOVERNADOR", "PREFEITO", "PRESIDENTE", "SENADOR", "VEREADOR"]
  	
  	chargeArray.each do |c|

  		charge = Charge.new
  		charge.charge_name = c
  		charge.save
  	end
  end

end
