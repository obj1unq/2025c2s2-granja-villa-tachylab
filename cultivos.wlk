import wollok.game.*
import personaje.*
//Cultivos y factories
object cultivos {
	const enLaGranja = #{}
	method crearCultivo(factory) {
		return factory.crear()
	}
	method sembrarCultivo(factory) {
		const nuevoCultivo = self.crearCultivo(factory)
		game.addVisual(nuevoCultivo)
		enLaGranja.add(nuevoCultivo)
	}
	method sacarDeLaGranja(cultivo) {
		enLaGranja.remove(cultivo)
	}
}

object maizFactory {
	method crear() {
		return new Maiz(position = hector.position())
	}
}



object trigoFactory {
	method crear() {
		return new Trigo(position = hector.position()) 
	}
}

object tomacoFactory {
	method crear() {
		return new Tomaco(position = hector.position())
	}
}


//Cultivos en si
class Maiz {
	var estado = baby
	const position
	method position() {
		return position
	}
	method image() {
		return "corn_" + estado.nombre() + ".png"
	}
	method nombre() {
		return "Maiz"
	}
	method estado() {
		return estado
	}
	method eresUnCultivo() {
		return true
	}
	method puedeCosecharse() {
		return estado.sePuedeCosechar()
	}
	method regar() {
		estado = estado.regado()
	}
	method cosechar() {
		if (self.puedeCosecharse()) {
			cultivos.sacarDeLaGranja(self)
			game.removeVisual(self)
		}
	}
}

class Trigo {
	var etapa = 0
	const position
	method position() {
		return position
	}
	method image() {
		return "wheat_" + etapa.toString() + ".png"
	}
	method nombre() {
		return "Trigo"
	}
	method etapa() {
		return etapa
	}
	method eresUnCultivo() {
		return true
	}
	method puedeCosecharse() {
		return etapa >= 2
	}
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
}

class Tomaco {
	var position
	method position() {
		return position
	}
	method image() {
		return "tomaco.png"
	}
	method nombre(){
		return "Tomaco"
	}
	method estoyEnBorde() {
		return position.y() == game.height() - 1
	}
	method eresUnCultivo() {
		return true
	}
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