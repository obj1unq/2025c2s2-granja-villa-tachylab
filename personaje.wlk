import wollok.game.*
import cultivos.*



object hector {
	//Atributos y Variables
	var property position = game.center()
	const property image = "mplayer.png"
	const plantasCosechadas = #{}
	var oroActual = 0
	//Consultas simples
	method oroTotalPlantasCosechadas() {
		return plantasCosechadas.sum({ planta => planta.precio()})
	}
	//Validaciones y condiciones
	method esUnaParcelaVacia() {
		return game.colliders(self).isEmpty()
	}
	method hayUnCultivoAca() {
		return not self.esUnaParcelaVacia() and game.uniqueCollider(self).eresUnCultivo()
	}
	method validarSembrar() {
		if (not self.esUnaParcelaVacia()) {
			self.error("No se puede plantar acá, esta parcela está ocupada")
		}
	}
	method validarRegar() {
		if (not self.hayUnCultivoAca()) {
			self.error("No se puede regar, no hay un cultivo acá")
		}
	}
	method validarCosechar() {
		if (not self.hayUnCultivoAca()) {
			self.error("No hay un cultivo que cosechar")
		}
	}
	//Mensajes
	method mensajeOroActual() {
		return "Tengo " + oroActual.toString() + " monedas"
	}
	method mensajePlantasCosechadas() {
		return plantasCosechadas.size().toString() + " plantas para vender."
	}
	//Metodos funcionales
	method sembrar(factory) {
		self.validarSembrar()
		cultivos.sembrarCultivo(factory)
	}
	method regar() {
		self.validarRegar()
		game.uniqueCollider(self).regar()
	}
	method cosechar() {
		self.validarCosechar()
		plantasCosechadas.add(game.uniqueCollider(self))
		game.uniqueCollider(self).cosechar()
	}
	method vender() {
		oroActual += self.oroTotalPlantasCosechadas()
		plantasCosechadas.clear()
	}
	method informarOroYPlantas() {
		game.say(self, self.mensajeOroActual() + ", y  " + self.mensajePlantasCosechadas())
	}
	}
