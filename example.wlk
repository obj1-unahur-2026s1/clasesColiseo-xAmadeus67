class ArmaDeFilo {
  const filo
  const longitud

  method ataque() = filo * longitud

}

class ArmaContundente {
  const peso 

  method ataque() = peso
}

object casco {
  method proteccion(unLuchador) = 10
} 

object escudo {
  method proteccion(unLuchador) = 5 + unLuchador.destreza() * 0.1
}

class Gladiador {
  var vida = 100

  method defensa()
  method fuerza()
  method destreza()
  method vida() = vida


   method recibirAtaque(unGladiador) {
    vida = vida - (unGladiador.poderDeAtaque() - self.defensa())
  }
  method atacar(unGladiador) {
    unGladiador.recibirAtaque(self)
  }
  method pelearCon(unGladiador) {
    self.atacar(unGladiador)
    unGladiador.atacar(unGladiador)
  }
  method curar(unGladiador) {
    
  }

}
class Mirmillon inherits Gladiador {
  var arma 
  var armadura
  var fuerza

  method cambiarArma(unArma){arma = unArma}
  method cambiarArmadura(unaArmadura){armadura = unaArmadura}

  override method fuerza() = fuerza
  override method destreza() = 15
  override method defensa() = armadura.proteccion(self) + self.destreza()

  method poderDeAtaque() = fuerza + arma.ataque()
  override method recibirAtaque(unGladiador) {
    vida = vida - (unGladiador.poderDeAtaque() - self.defensa())
  }
  override method atacar(unGladiador) {
    unGladiador.recibirAtaque(self)
  }
  method formarGrupoCon(unGladiador) { 
    return
    new Grupo(nombre="mirmillo",
    miembros=#{unGladiador,self})
  }
}

class Dimachaerus inherits Gladiador {
  const armas = []
  var destreza

  override method fuerza() = 10
  override method destreza() = destreza

  method cambiarArma(unArma) {armas.add(unArma)}
  method quitarArma(unArma) {armas.remove(unArma)}

  method poderDeAtaque() = armas.sum({a => a.ataque()}) + self.fuerza()
  override method defensa() = destreza/2

  override method atacar(unGladiador) {
    super(unGladiador)
    destreza += 1
  }

  method formarGrupoCon(unGladiador) {
    return
    new Grupo(nombre="D-" + self.poderDeAtaque() + unGladiador.poderDeAtaque(),
    miembros=#{unGladiador,self})
  }
}

class Grupo {
  const property miembros = #{}
  const property nombre 
  var cantPeleas = 0

  method agregar(unGladiador) {miembros.add(unGladiador)}
  method sacar(unGladiador) {miembros.remove(unGladiador)}

  method puedenCombatir() = miembros.filter({m => m.vida() > 0})
  method campeon() = self.puedenCombatir().max({m=> m.poderDeAtaque()})

  method combatirCon(unGrupo) {
    self.campeon().pelearCon(unGrupo.campeon())
    self.campeon().pelearCon(unGrupo.campeon())
    self.campeon().pelearCon(unGrupo.campeon())
    cantPeleas += 3
  } 
}

object coliseo {
  method orgnaizarCombate(unGrupo, otroGrupo) {
    unGrupo.combatirCon(otroGrupo)
  }
  method organizarCombateContraGladiador(unGrupo, unGladiador) {
    unGrupo.forEach({g=>g.pelearCon()})
  }
  method curarGrupo(unGrupo) {
    unGrupo.miembros{}.forEach({g=>g.curar()})
  }
}