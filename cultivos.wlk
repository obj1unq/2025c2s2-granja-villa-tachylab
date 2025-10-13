import wollok.game.*
import personaje.*
//Cultivos y factories
object cultivos {
	//Atributos
	const enLaGranja = #{}
	//Metodos funcionales
	method crearCultivo(cultivo, cultivador) {
		return cultivo.crear(cultivador)
	}
	method sembrarCultivo(cultivo, cultivador) {
		const nuevoCultivo = self.crearCultivo(cultivo, cultivador)
		game.addVisual(nuevoCultivo)
		enLaGranja.add(nuevoCultivo)
	}
	method sacarDeLaGranja(cultivo) {
		enLaGranja.remove(cultivo)
	}
}

object maiz {
	method crear(cultivador) {
		return new Maiz(position = cultivador.position())
	}
}

object trigo {
	method crear(cultivador) {
		return new Trigo(position = cultivador.position()) 
	}
}

object tomaco {
	method crear(cultivador) {
		return new Tomaco(position = cultivador.position())
	}
}


//Cultivos en si
class Maiz {
	//Atributos
	var estado = baby
	const position
	const precio = 150
	//Posición e imagen
	method position() {
		return position
	}
	method image() {
		return "corn_" + estado.nombre() + ".png"
	}
	//Metodos Lookup y de consulta simple
	method nombre() {
		return "Maiz"
	}
	method estado() {
		return estado
	}
	method precio() {
		return precio
	}
	//Condiciones
	method eresUnCultivo() {
		return true
	}
    method eresUnMercado() {
        return false
    }
	method puedeCosecharse() {
		return estado.sePuedeCosechar()
	}
	//Metodos funcionales
	method regar() {
		estado = estado.regado()
	}
	method cosechar() {
		if (self.puedeCosecharse()) {
			cultivos.sacarDeLaGranja(self)
			game.removeVisual(self)
		}
	}
	method plantaDeEstarCosechada() {
		if (self.puedeCosecharse()) {
			return #{self}
		}
		else {
			return #{}
		}
	}
}

class Trigo {
	//Atributos
	var etapa = 0
	const position
	//Posición e imagen
	method position() {
		return position
	}
	method image() {
		return "wheat_" + etapa.toString() + ".png"
	}
	//Metodos Lookup y de consulta simple
	method nombre() {
		return "Trigo"
	}
	method etapa() {
		return etapa
	}
	//Condiciones
	method eresUnCultivo() {
		return true
	}
    method eresUnMercado() {
        return false
    }
	method puedeCosecharse() {
		return etapa >= 2
	}
	//Metodos funcionales
	method regar() {
		if (etapa != 3) {
			etapa += 1
		}
		else {
			etapa = 0
		}
	}
	method cosechar() {
		if (self.puedeCosecharse()) {
			cultivos.sacarDeLaGranja(self)
			game.removeVisual(self)
		}
	}
	method plantaDeEstarCosechada() {
		if (self.puedeCosecharse()) {
			return #{self}
		}
		else {
			return #{}
		}
	}
	method precio() {
		return (etapa - 1) * 100
	}
}

class Tomaco {
	//Atributos
	var position
	const precio = 80
	//Posicion e imagen
	method position() {
		return position
	}
	method image() {
		return "tomaco.png"
	}
	//Metodos Lookup
	method nombre(){
		return "Tomaco"
	}
	method precio() {
		return precio
	}
	//Validaciones y condiciones
	method estoyEnBorde() {
		return position.y() == game.height() - 1
	}
	method eresUnCultivo() {
		return true
	}
    method eresUnMercado() {
        return false
    }
	//Metodos funcionales
	method regar() {
		if (not self.estoyEnBorde()) {
			position = position.up(1)
		}
		else {
			position = position.down(game.height() - 1)
		}
	}
	method cosechar() {
			cultivos.sacarDeLaGranja(self)
			game.removeVisual(self)
	}
	method plantaDeEstarCosechada() {
		return self
	}
}
//Estados extra de los cultivos
object baby {
	method nombre() {
		return "baby"
	}
	method regado() {
		return adult
	}
	method sePuedeCosechar() {
		return false
	}
}

object adult {
	method nombre() {
		return "adult"
	}
	method regado() {
		return self
	}
	method sePuedeCosechar() {
		return true
	}
}