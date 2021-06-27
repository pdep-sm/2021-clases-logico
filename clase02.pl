/*
Plataformas, Series-Peliculas, Actores
Serie: Nombre, #temporadas
Pelicula: Nombre, anio y duracion (en minutos)
*/
produce(netflix, serie(theWalkingDead, 10)).
produce(netflix, serie(mindhunter, 2)).
produce(netflix, serie(umbrellaAcademy, 2)).
% no hacer -> produce(netflix, umbrellaAcademy, serie, 2). % produce/4
produce(netflix, pelicula(awake, 2021, 96)). % disomnia
% no hacer -> produce(netflix, awake, pelicula, 2021, 90) . % produce/5
produce(disneyPlus, pelicula(cruella, 2021, 134)).
produce(disneyPlus, pelicula(luca, 2021, 95)). %pelicula
produce(disneyPlus, serie(loki, 1)).
produce(disneyPlus, serie(wandaVision, 1)).
produce(disneyPlus, serie(falconAndTheWinterSoldier, 1)).
produce(amazonPrime, serie(theBoys, 2)).
produce(amazonPrime, serie(invincible, 1)).
produce(amazonPrime, serie(theGoodOmens, 1)).
produce(amazonPrime, serie(jackRyan, 2)).
produce(hbo, pelicula(hereditary, 2018, 127)). %pelicula
produce(hbo, serie(gameOfThrones, 8)).
produce(hbo, serie(westworld, 3)).
produce(hbo, serie(chernobyl, 1)).
produce(hbo, serie(trueDetective, 3)).
produce(hbo, serie(hisDarkMaterials, 2)).
% prueba de Hulu .. produce(hulu, animaniacs).

% actores(Contenido, Actores)
actores(temporada(1, trueDetective), [mathewMcConaughey, woodyHarrelson]).
actores(temporada(N, jackRyan), [johnKrasinki, wendellPierce]):-
    produce(_, serie(jackRyan, TotalTemporadas)),
    between(1, TotalTemporadas, N).

actores(pelicula(cruella), [emmaStone]).

titulo(temporada(_, Titulo), Titulo).
titulo(pelicula(Titulo), Titulo).

actuoEn(Persona, Contenido):-
    actores(Contenido, Actores), 
    member(Persona, Actores).

actuoEnTitulo(Persona, Titulo):-
    actuoEn(Perdona, Contenido),
    titulo(Contenido, Titulo).

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

% anioEstreno/2 - relaciona un titulo de pelicula con el año en el cual se estrenó
anioEstreno(TituloPelicula, Anio):-
    produce(_, pelicula(TituloPelicula, Anio, _)).


% produceTitulo/2 - relaciona productora con el titulo de CUALQUIER contenido producido
produceTitulo(Productora, Titulo):-
    produce(Productora, Contenido),
    titulo(Contenido, Titulo).

% titulo/2 - Relaciona un contenido (CADA TIPO DE CONTENIDO) con su Titulo
titulo(serie(Titulo, _), Titulo).
titulo(pelicula(Titulo, _, _), Titulo).
%titulo(documental(Titulo...), Titulo). posible futura construcción

/* Version acoplada al modelo de los contenidos y a las formas de produce/2
produceTitulo(Productora, Titulo):-
    produce(Productora, pelicula(Titulo, _, _)).
produceTitulo(Productora, Titulo):-
    produce(Productora, serie(Titulo, _)).
*/

