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
    //Condiciones
    method tengoMonedasSuficientes(plantasAComprar) {
        return self.precioTotalCosechas(plantasAComprar) <= monedas
    }
    //Metodos funcionales
    method regar() {}
    method cosechar(granjero) {}
    method precioTotalCosechas(plantasAEvaluar) {
        return plantasAEvaluar.sum({plantas => plantas.precio()})
    }
    method comprarCosechas(plantasAComprar, granjero) {
        if (self.tengoMonedasSuficientes(plantasAComprar)) {
            mercaderia.addAll(plantasAComprar)
            monedas -= self.precioTotalCosechas(plantasAComprar)
            granjero.ventaExitosa()
        }
    }
}