import panes.*

class Comida{
	var valoracion = 0
	var peso

method aptoCeliaco() = false
	
	method precio(){
		if(self.aptoCeliaco()){
		return valoracion * 300 + 1200
		}
		else{
			return valoracion * 300
		}
		}
		
	
	method especial() = false
	method valoracion() = valoracion
	method peso()= peso
	
}

class Provoleta inherits Comida{
	var empanado
	
	method empanado() = empanado
	override method valoracion(){if(self.especial()){
		return 120
	}
	else{
		return 80
	}
		
	}

	
	override method aptoCeliaco() = not self.empanado()
	
	override method especial() = peso > 250 and self.empanado()
	
	
}

class HamburguesaDeCarne inherits Comida{
	var tipoPan

	override method peso() = tipoPan.peso() + peso
	override method aptoCeliaco() = tipoPan.aptoCeliaco()
	
	override method valoracion() = self.peso() > 250
}

class HamburguesasDobles inherits HamburguesaDeCarne{
	
	override method peso() = tipoPan.peso()+ 2* peso
	override method especial() = self.peso() > 500
	override method valoracion() = self.peso()/10
}

class CorteDeCarne inherits Comida{
	var estilo /* Puede ser jugoso, a punto o cocido.*/
	
	override method peso() = peso>250 and estilo == "a punto"
	override method aptoCeliaco() = true
	override method valoracion() = 100

	
}

class Parrillada inherits Comida{
	var comidas
	
	override method peso() = comidas.sum({unaComida => unaComida.peso()})
	
	override method especial() = self.peso() > 250 and comidas.size() >=3
	
	override method aptoCeliaco() = comidas.all({comida => comida.aptoCeliaco()})
	
	override method valoracion() = comidas.sum({unaComida =>unaComida.valoracion()})
	
}

