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
	method regar() {
		estado = estado.regado()
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
	method regar() {
		if (etapa != 3) {
			etapa += 1
		}
		else {
			etapa = 0
		}
	}
}

class Tomaco {
	const position
	method position() {
		return position
	}
	method image() {
		return "tomaco.png"
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
}

object adult {
	method nombre() {
		return "baby"
	}
	method regado() {
		return self
	}
}