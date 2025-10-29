import wollok.game.*
import personaje.*


object gestorDeAspersores {
    const aspersoresActivos = #{}

    method activar() {
        aspersoresActivos.forEach({aspersor => aspersor.regarLimitrofes()})
    }
    method crearAspersor() {
        return aspersorFactory.crear()
    }
    method establecerAspersor() {
        const nuevoAspersor = self.crearAspersor()
        game.addVisual(nuevoAspersor)
        aspersoresActivos.add(nuevoAspersor)
    }
}

object aspersorFactory {
    method crear() {
        return new Aspersor(position = personaje.position())
    }
}

class Aspersor {
    //Atributos
    const position
    const posicionesRegables = #{arriba, abajo, izquierda, derecha, diagonalArribaDerecha, diagonalAbajoDerecha, diagonalArribaIzquierda, diagonalAbajoIzquierda}
    //Posicion e Imagen
    method position() {
        return position
    }
    method image() {
        return "aspersor.png"
    }
    //Consultas
    method posicionesChequeables() {
        return posicionesRegables.map({direccion => direccion.posicionResultante(position)})
    }
    //Condiciones
    method esUnaParcelaVacia(posicionVerificar) {
        return game.getObjectsIn(posicionVerificar).isEmpty()
    }
    method elementoUnicoEn(posicionVerificar) {
        return game.getObjectsIn(posicionVerificar).uniqueElement()
    }
    method hayElementoUnicoEn(posicionVerificar) {
        return not self.esUnaParcelaVacia(posicionVerificar) and game.getObjectsIn(posicionVerificar).size() == 1
    }
    method validarRegar(posicion) {
        if (not self.hayElementoUnicoEn(posicion)) {
            self.error("No es posible regar")
        }
    }
    //Metodos funcionales
    method regar(posicion){
            self.validarRegar(posicion)
            self.elementoUnicoEn(posicion).regar()
        
    }
    method regar() {}
    method regarLimitrofes() {
        const posicionesLimitrofes = self.posicionesChequeables()
        posicionesLimitrofes.forEach({posicion => self.regar(posicion)})
    }
    method comprarCosechas(plantasCosechadas, granjero) {}
}

object arriba {
    method posicionResultante(posicion) {
        return posicion.up(1)
    }
}

object abajo {
    method posicionResultante(posicion) {
        return posicion.down(1)
    }
}

object izquierda {
    method posicionResultante(posicion) {
        return posicion.left(1)
    }
}

object derecha {
    method posicionResultante(posicion) {
        return posicion.right(1)
    }
}

object diagonalArribaDerecha {
    method posicionResultante(posicion) {
        return (posicion.up(1)).right(1)
    }
}

object diagonalAbajoDerecha {
    method posicionResultante(posicion) {
        return (posicion.down(1)).right(1)
    }
}

object diagonalArribaIzquierda {
    method posicionResultante(posicion) {
        return (posicion.up(1)).left(1)
    }
}

object diagonalAbajoIzquierda {
    method posicionResultante(posicion) {
        return (posicion.down(1)).left(1)
    }
}