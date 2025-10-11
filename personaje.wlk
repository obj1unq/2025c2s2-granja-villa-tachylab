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
	method eresUnCultivo() {
		return false
	}
	method hayUnCultivoAca() {
		return not self.esUnaParcelaVacia() and self.elementoUnicoActual().eresUnCultivo()
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
		if (not self.hayUnCultivoAca()) {
			self.error("No se puede regar, no hay un cultivo acá")
		}
	}
	method validarCosechar() {
		if (not self.hayUnCultivoAca()) {
			self.error("No hay un cultivo que cosechar")
		}
	}
	method validarColocarAspersor() {
		if (not self.esUnaParcelaVacia()) {
			self.error("No se puede colocar aspersor, parcela ocupada")
		}
	}
	method validarVender() {
		if (not self.hayUnMercadoAca()) {
			self.error("No se puede vender, no hay mercado")
		}
		else if (not self.elMercadoPuedeComprar()){
			self.error("El mercado no tiene monedas suficientes")
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
		cultivos.sembrarCultivo(cultivo)
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
		self.validarVender()
		oroActual += self.oroTotalPlantasCosechadas()
		self.elementoUnicoActual().comprarCosechas(plantasCosechadas)
		plantasCosechadas.clear()
	}
	method informarOroYPlantas() {
		game.say(self, self.mensajeOroActual() + ", y  " + self.mensajePlantasCosechadas())
	}
	method colocarAspersor() {
		self.validarColocarAspersor()
		aspersores.establecerAspersor()
	}
	}