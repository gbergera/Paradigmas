import comidas.*
import parrilla.*

class Comensal{
	var dinero
	var tipo
	
	method cambiarTipo(nuevoTipo){
		tipo = nuevoTipo
	}
	method dinero() = dinero
	
	method recibirDinero(dineroExtra) = dinero + dineroExtra
	method comprar(plato){
		if(plato.precio()< dinero){
		dinero -= plato.precio()
		parrilla.servir(plato,self)
		}
	else{
		throw new Exception(message = "No tengo dinero para pagar el plato")
	}
	} 
	
	method aparecieronProblemasGastricos(){
		tipo = celiaco
	}
	
	method nohayplata(){
		tipo = todoTerreno
	}
	
	method acuerdoconJeque(){
		tipo = dePaladarFino
	}
	method lesAgrada(comida) = tipo.lesAgrada(comida)
	
	
	method platosCandidatos(){
		return parrilla.platos().filter({comida => comida.precio() <= dinero})
	}
	method leDaLaPlata(){
		return self.platosCandidatos().size() !== 0
	}
	method darseUnGusto() {
		if (self.leDaLaPlata()){
		self.platosCandidatos().max({comida =>comida.valoracion()})
	}
		else{
		throw new Exception(message = "La cantidad debe ser positiva")
		}
	}
	
}

object celiaco{
	 method lesAgrada(comida) = comida.aptoCeliaco()
}

object dePaladarFino  {
	 method lesAgrada(comida) = comida.valoracion() > 100
}

object todoTerreno  {
	 method lesAgrada(comida) = true
}

