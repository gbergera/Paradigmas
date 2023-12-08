object parrilla {
	var platos = []
	
	method platos() = platos
	
	method agregarPlato(comida) = platos.add(comida)
	
	method servir(comida,comensal){
		platos.remove(comida)
		comensal.recibirDinero(500)
	}
	
}
