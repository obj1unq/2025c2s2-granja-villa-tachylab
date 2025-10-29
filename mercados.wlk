import wollok.game.*

class Mercado {
    //Atributos
    const mercaderia = #{}
    var monedas = 1000
    const position
    //Posición e imagen
    method position() {
        return position
    }
    method image() {
        return "market.png"
    }
    //Consultas simples
    method monedas() {
        return monedas
    }
    method mercaderia() {
        return mercaderia
    }
    //Condiciones y validaciones
    method tengoMonedasSuficientes(plantasAComprar) {
        return self.precioTotalCosechas(plantasAComprar) <= monedas
    }
    method validarComprarCosechas(plantasAComprar) {
        if (not self.tengoMonedasSuficientes(plantasAComprar)) {
            self.error("No tengo monedas suficientes para comprar tus plantas")
        }
    }
    //Metodos funcionales
    method regar() {}
    method cosechar(granjero) {}
    method precioTotalCosechas(plantasAEvaluar) {
        return plantasAEvaluar.sum({plantas => plantas.precio()})
    }
    method comprarCosechas(plantasAComprar, granjero) {
            self.validarComprarCosechas(plantasAComprar)
            mercaderia.addAll(plantasAComprar)
            monedas -= self.precioTotalCosechas(plantasAComprar)
            granjero.ventaExitosa()
    }
}