module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--1
data Nave = Nave{
    nombre::Nombre,
    durabilidad :: Durabilidad,
    escudo::Escudo,
    ataque:: Ataque,
    poder :: Poder
}deriving Show

type Ataque = Number
type Escudo = Number
type Nombre = String
type Durabilidad= Number
type Poder = Nave -> Nave
type Flota = [Nave]
type Danio = Number
type Mision= Estrategia -> Nave -> Flota -> Flota
type Estrategia = Nave -> Bool


tieFighter = Nave{nombre = "Tie Fighter",durabilidad=200,escudo=100,ataque=50,poder=turbo}
xWing = Nave{nombre = "X Wing",durabilidad=300,escudo=150,ataque=100,poder=reparacionDeEmergencia}
naveDeDarthVader = Nave{nombre = "Nave de Darth Vader",durabilidad=500,escudo=300,ataque=200,poder=superTurbo}
milleniumFalcon = Nave{nombre = "MilleniumFalcon",durabilidad=1000,escudo=500,ataque=50,poder=reparacionEspecial}
--NuevaNave
ultimaTecnologia :: Nave
ultimaTecnologia = Nave {nombre ="Ultima Tecnologia",durabilidad=1000,escudo=50,ataque=500,poder=haceDeTodo}

turbo :: Poder
turbo nave = nave {ataque = aumentarAtaque 25 (ataque nave)}

aumentarAtaque :: Ataque -> Ataque -> Ataque
aumentarAtaque incremento ataqueNave = incremento + ataqueNave 

superTurbo :: Poder
superTurbo  = modificarDurabilidad (-45).turbo.turbo.turbo

modificarDurabilidad :: Durabilidad -> Nave -> Nave
modificarDurabilidad cantidad nave = nave{durabilidad = mayorOIgualACero (durabilidad nave + cantidad) }

reparacionDeEmergencia :: Poder
reparacionDeEmergencia  = (modificarAtaque (-30). modificarDurabilidad (50))

reparacionEspecial :: Poder
reparacionEspecial = reparacionDeEmergencia.modificarDurabilidad (-45)

modificarAtaque :: Ataque-> Nave -> Nave
modificarAtaque cantidad nave = nave {ataque= mayorOIgualACero (ataque nave + cantidad)}

modificarEscudo :: Escudo -> Nave -> Nave
modificarEscudo cantidad nave = nave { escudo= mayorOIgualACero (escudo nave + cantidad)}

mayorOIgualACero :: Number -> Number
mayorOIgualACero valor = max 0 valor

haceDeTodo :: Poder
haceDeTodo = modificarAtaque (30). modificarDurabilidad (50).superTurbo.turbo.reparacionDeEmergencia.reparacionEspecial

--2

durabilidadTotal :: Flota -> Durabilidad
durabilidadTotal = sum.map (durabilidad)

--3
atacar :: Nave -> Nave -> Nave
atacar atacante atacado
    |noEsEfectivo ((poder atacante) atacante)((poder atacado) atacado) = atacado
    |otherwise = realizarAtaque ((poder atacante) atacante)((poder atacado) atacado)

realizarAtaque :: Nave -> Nave -> Nave
realizarAtaque atacante atacado = atacado{durabilidad=(durabilidad.modificarDurabilidad (- (calcularDanio (ataque atacante) (escudo atacado) ) )) atacado}

calcularDanio :: Ataque -> Escudo -> Danio
calcularDanio ataque escudo = ataque - escudo

noEsEfectivo :: Nave -> Nave -> Bool
noEsEfectivo atacante atacado = escudo atacado > ataque atacante

--4
estaFueraDeCombate :: Nave -> Bool
estaFueraDeCombate = (==0).durabilidad

--5
--Decidi no utilizar filter debido a que el enunciado pide el estado de TODA la flota luego de usar una estrategia
--si usaba filter, solo me quedaria solo con las naves AFECTADAS por la estrategia y las demas serian descartadas
mision :: Mision
mision estrategia atacante (x:xs)
    |estrategia x = (atacar atacante x) : (mision estrategia atacante xs)
    |otherwise = x: (mision estrategia atacante xs)


--6 
navesDebiles :: Estrategia
navesDebiles  = (<200).escudo

navesConCiertaPeligrosidad :: Number -> Estrategia
navesConCiertaPeligrosidad valor = (>valor).ataque 

navesQueQuedarianFueraDeCombate :: Nave -> Estrategia
navesQueQuedarianFueraDeCombate atacante nave = (estaFueraDeCombate.atacar (atacante)) nave

soloAtacaXWings :: Estrategia
soloAtacaXWings =(== "X Wing").nombre

--7
flotaInfinita :: Flota
flotaInfinita = repeat naveDeDarthVader

{-
a) No se puede porque se deberia acceder a todos los campos de durabilidad de cada nave para poder realizar la suma final
y como es una lista infinita de naves, habra infinitas durabilidades, por ende no dejara de sumar valores a la
suma final.

b)
devuelve una lista infinita de naves con los valores de las naves afectadas por la estrategia modificados y las mismas
naves cuando la estrategia no se cumple.
-}
