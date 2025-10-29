import wollok.game.*
import cultivos.*
import aspersorYPosiciones.*


object personaje {
	//Atributos
	var property position = game.center()
	const property image = "mplayer.png"
	const plantasCosechadas = #{}
	var oroActual = 0
	//Consultas simples
	method oroTotalPlantasCosechadas() {
		return plantasCosechadas.sum({ planta => planta.precio()})
	}
	method elementoUnicoActual() {
		return game.uniqueCollider(self)
	}
	method oroActual() {
		return oroActual
	}
	method plantasCosechadas() {
		return plantasCosechadas
	}
	//Validaciones y condiciones
	method esUnaParcelaVacia() {
		return game.colliders(self).isEmpty()
	}
	method hayUnMercadoAca() {
		return not self.esUnaParcelaVacia() and self.elementoUnicoActual().eresUnMercado()
	}
	method elMercadoPuedeComprar() {
		return self.elementoUnicoActual().monedas() >= self.oroTotalPlantasCosechadas()
	}
	method validarSembrar() {
		if (not self.esUnaParcelaVacia()) {
			self.error("No se puede plantar acá, esta parcela está ocupada")
		}
	}
	method validarRegar() {
		if (self.esUnaParcelaVacia()) {
			self.error("No se puede regar, esta parcela esta vacia")
		}
	}
	method validarCosechar() {
		if (self.esUnaParcelaVacia()) {
			self.error("No hay un cultivo que cosechar")
		}
	}
	method validarColocarAspersor() {
		if (not self.esUnaParcelaVacia()) {
			self.error("No se puede colocar aspersor, parcela ocupada")
		}
	}
	method validarVender() {
		if (self.esUnaParcelaVacia()) {
			self.error("No se puede vender, parcela vacia")
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
	method sembrar(cultivo) {
		self.validarSembrar()
		gestorDeCultivos.sembrarCultivo(cultivo, self)
	}
	method regar() {
		self.validarRegar()
		self.elementoUnicoActual().regar()
	}
	method cosechar() {
		self.validarCosechar()
		self.elementoUnicoActual().cosechar(self)
	}
	method añadirCosecha(cultivo) {
		plantasCosechadas.add(cultivo)
	}
	method vender() {
		self.validarVender()
		self.elementoUnicoActual().comprarCosechas(plantasCosechadas, self)
	}
	method ventaExitosa() {
		oroActual += self.oroTotalPlantasCosechadas()
		plantasCosechadas.clear()
	}
	method informarOroYPlantas() {
		game.say(self, self.mensajeOroActual() + ", y  " + self.mensajePlantasCosechadas())
	}
	method colocarAspersor() {
		self.validarColocarAspersor()
		gestorDeAspersores.establecerAspersor()
	}
	}