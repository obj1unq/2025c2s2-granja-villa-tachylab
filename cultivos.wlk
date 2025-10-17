import wollok.game.*
import personaje.*
//Cultivos y factories
object cultivos {
	//Atributos
	const enLaGranja = #{}
	//Metodos funcionales
	method crearCultivo(cultivo, granjero) {
		return cultivo.crear(granjero)
	}
	method sembrarCultivo(cultivo, granjero) {
		const nuevoCultivo = self.crearCultivo(cultivo, granjero)
		game.addVisual(nuevoCultivo)
		enLaGranja.add(nuevoCultivo)
	}
	method sacarDeLaGranja(cultivo) {
		enLaGranja.remove(cultivo)
	}
}

object maiz {
	method crear(granjero) {
		return new Maiz(position = granjero.position())
	}
}

object trigo {
	method crear(granjero) {
		return new Trigo(position = granjero.position()) 
	}
}

object tomaco {
	method crear(granjero) {
		return new Tomaco(position = granjero.position())
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
	method puedeCosecharse() {
		return estado.sePuedeCosechar()
	}
	//Metodos funcionales
	method regar() {
		estado = estado.regado()
	}
	method cosechar(granjero) {
		if (self.puedeCosecharse()) {
			cultivos.sacarDeLaGranja(self)
			granjero.añadirCosecha(self)
			game.removeVisual(self)
		}
	}
	method comprarCosechas(plantasCosechadas, granjero) {}
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
	method cosechar(granjero) {
		if (self.puedeCosecharse()) {
			cultivos.sacarDeLaGranja(self)
			granjero.añadirCosecha(self)
			game.removeVisual(self)
		}
	}
	method precio() {
		return (etapa - 1) * 100
	}
	method comprarCosechas(plantasCosechadas, granjero) {}
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
	method arribaEsParcelaVacia() {
		return game.getObjectsIn(position.up(1)).isEmpty()
	}
	method puedeCrecer() {
		return self.arribaEsParcelaVacia()
	}
	method nuevaPosicionCrecer() {
		return if (self.estoyEnBorde()) {
			game.at(position.x(), 0)
		}
		else {
			position.up(1)
		}
	}
	//Metodos funcionales
	method regar() {
		if (self.puedeCrecer()) {
			position = self.nuevaPosicionCrecer()
		}
	}
	method cosechar(granjero) {
		cultivos.sacarDeLaGranja(self)
		granjero.añadirCosecha(self)
		game.removeVisual(self)
	}
	method comprarCosechas(plantasCosechadas, granjero) {}
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