import wollok.game.*
import cultivos.*

object hector {
	//Atributos y Variables
	var property position = game.center()
	const property image = "mplayer.png"
	//Validaciones y condiciones
	method esUnaParcelaVacia() {
		return game.colliders(self).isEmpty()
	}
	method validarSembrar() {
		if (not self.esUnaParcelaVacia()) {
			self.error("No se puede plantar acá, esta parcela está ocupada")
		}
	}
	//Metodos funcionales
	method sembrar(factory) {
		self.validarSembrar()
		cultivos.sembrarCultivo(factory)
	}
	}
