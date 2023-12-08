% Cancion, Compositores,  Reproducciones
cancion(bailanSinCesar, [pabloIlabaca, rodrigoSalinas], 10600177).
cancion(yoOpino, [alvaroDiaz, carlosEspinoza, rodrigoSalinas], 5209110).
cancion(equilibrioEspiritual, [danielCastro, alvaroDiaz, pabloIlabaca, pedroPeirano, rodrigoSalinas], 12052254).
cancion(tangananicaTanganana, [danielCastro, pabloIlabaca, pedroPeirano], 5516191).
cancion(dienteBlanco, [danielCastro, pabloIlabaca, pedroPeirano], 5872927).
cancion(lala, [pabloIlabaca, pedroPeirano], 5100530).
cancion(meCortaronMalElPelo, [danielCastro, alvaroDiaz, pabloIlabaca, rodrigoSalinas], 3428854).

% Mes, Puesto, Cancion
rankingTop3(febrero, 1, lala).
rankingTop3(febrero, 2, tangananicaTanganana).
rankingTop3(febrero, 3, meCortaronMalElPelo).
rankingTop3(marzo, 1, meCortaronMalElPelo).
rankingTop3(marzo, 2, tangananicaTanganana).
rankingTop3(marzo, 3, lala).
rankingTop3(abril, 1, tangananicaTanganana).
rankingTop3(abril, 2, dienteBlanco).
rankingTop3(abril, 3, equilibrioEspiritual).
rankingTop3(mayo, 1, meCortaronMalElPelo).
rankingTop3(mayo, 2, dienteBlanco).
rankingTop3(mayo, 3, equilibrioEspiritual).
rankingTop3(junio, 1, dienteBlanco).
rankingTop3(junio, 2, tangananicaTanganana).
rankingTop3(junio, 3, lala).

%%%%%%% INSERTE SOLUCIÓN AQUI %%%%%%%
% ¡Éxitos! :)
%1
esUnHit(Cancion):-
    cancion(Cancion,_,_),
    forall(rankingTop3(Mes,_,_),rankingTop3(Mes,_,Cancion)).

%2
noEsReconocidaPorCriticos(Cancion):-
    cancion(Cancion,_,_),
    not(estuvoEnRanking(Cancion)),
    tieneMuchasReproducciones(Cancion).

tieneMuchasReproducciones(Cancion):-
    cancion(Cancion,_,Reproducciones),
    Reproducciones > 7000000.

estuvoEnRanking(Cancion):-
    cancion(Cancion,_,_),
    rankingTop3(_,_,Cancion).

%3
sonColaboradores(UnAutor,OtroAutor):-
    cancion(_,Colaboradores,_),
    member(UnAutor,Colaboradores),
    member(OtroAutor,Colaboradores),
    UnAutor \= OtroAutor.

%4
trabajador(tulio,conductor(5)).
trabajador(bodoque,periodista(5,licenciatura)).
trabajador(bodoque,reportero(5,300)).
trabajador(marioHugo,periodista(10,posgrado)).
trabajador(juanin,conductor(0)).
trabajador(german,camarografo(2,5)). 
%6
%Nombre,camarografo(Cantidad de camaras que maneja,anios de Experiencia).

%5
sueldoTotal(Trabajador,Sueldo):-
    trabajador(Trabajador,_),
    findall(Sueldos,hallarSueldos(Trabajador,Sueldos),ListaSueldos),
    sum_list(ListaSueldos,Sueldo).

hallarSueldos(Trabajador,Sueldo):-
    trabajador(Trabajador,Rol),
    calcularSueldo(Rol,Sueldo).

calcularSueldo(conductor(Experiencia),Sueldo):-
    Sueldo is 10000 * Experiencia.

calcularSueldo(reportero(Experiencia,Notas),Sueldo):-
    Sueldo is 10000 * Experiencia + 100 * Notas.

calcularSueldo(periodista(_,licenciatura),Sueldo):-
    Sueldo is 5000 * 0.2 + 5000.

calcularSueldo(periodista(_,posgrado),Sueldo):-
        Sueldo is 5000 * 0.35 + 5000.
%6
calcularSueldo(camarografo(Camaras,Experiencia),Sueldo):-
    Sueldo is 1000 * Camaras * Experiencia.  

% al pedir que agregue un nuevo trabajador, es necesario incorporarlo a la base de conocimiento por el principio
% de universo cerrado, luego, para poder calcular su sueldo, fue necesario crear una forma de calcularSueldo(funcion polimorfica)
% para queen esta resolucion, a traves de pattern matching pueda devolver el sueldoTotal matcheando por su rol.








