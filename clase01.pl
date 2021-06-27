/*
Plataformas, Series-Peliculas, Actores
*/
produce(netflix, theWalkingDead).
produce(netflix, mindhunter).
produce(netflix, umbrellaAcademy).
produce(disneyPlus, loki).
produce(disneyPlus, wandaVision).
produce(disneyPlus, falconAndTheWinterSoldier).
produce(amazonPrime, theBoys).
produce(amazonPrime, invincible).
produce(amazonPrime, theGoodOmens).
produce(hbo, gameOfThrones).
produce(hbo, westworld).
produce(hbo, chernobyl).
produce(hbo, trueDetective).
produce(hbo, hisDarkMaterials).
% prueba de Hulu .. produce(hulu, animaniacs).

% estaEn/2 relaciona, Titulo, Plataforma... Si el Titulo esta disponible 
% para ver en la Plataforma
estaEn(flash, netflix).
estaEn(dragonBall, crunchyRoll).
estaEn(gameOfThrones, flow).
estaEn(Titulo, cuevana3):- produce(_, Titulo).
% Esta el titulo en la plataforma, si la misma lo produce
estaEn(Titulo, Plataforma):- produce(Plataforma, Titulo).
% Para Convenios
estaEn(Titulo, Adquiriente):-
    hayConvenio(Productora, Adquiriente),
    produce(Productora, Titulo).

% Convenio entre hbo y amazonPrime convenio(Produce, TomaContenido)
convenio(hbo, amazonPrime).
convenio(amazonPrime, netflix).
convenio(netflix, disneyPlus).
convenio(hulu, netflix). % Esto da false para estaEn/2 porque hulu no tiene nada producido

hayConvenio(Duenia, Asociada):-
    convenio(Duenia, Asociada).
hayConvenio(Duenia, Asociada):-
    convenio(Duenia, Intermediaria),
    hayConvenio(Intermediaria, Asociada).

