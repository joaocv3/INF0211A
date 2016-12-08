-- Trabalho INF0211A --

-- 1.	Exibir os nomes das equipes e local de suas sedes, com os nomes de seus pilotos.

SELECT DISTINCT e.nome, e.sede, p1.nome
FROM equipe e, pontuacao p, piloto p1
WHERE e.cod = p.cod_equipe
AND p1.cod = p.cod_piloto
ORDER BY e.nome

-- 3.	Exibir a relação de provas do campeonato com as datas de realização, cidade e país,  em ordem crescente de data.

SELECT p.data, c.nome 
FROM prova p, circuito c 
WHERE c.cod = p.cod_circuito
ORDER BY p.data ASC

-- 4.	Exibir o nome e a equipe do piloto com melhor classificação e seu número de pontos,
-- e do piloto com pior classificação e seu número de pontos (em um ano específico, e por ano).

-- menor em um ano especifico
SELECT p1.nome, p.pontos, e.nome, p.cod_campeonato
FROM pontuacao p, piloto p1, equipe e
WHERE p.cod_campeonato = 2006
AND p1.cod = p.cod_piloto
ORDER BY p.pontos
limit 1

-- maior em um ano especifico
SELECT p1.nome, p.pontos, e.nome, p.cod_campeonato
FROM pontuacao p, piloto p1, equipe e
WHERE p.cod_campeonato = 2006
AND p1.cod = p.cod_piloto
ORDER BY p.pontos DESC
limit 1

-- menor por ano
SELECT p1.nome, p.pontos, e.nome, p.cod_campeonato
FROM pontuacao p, piloto p1, equipe e, campeonato c
WHERE p.cod_campeonato = c.ano
AND p1.cod =(SELECT p.cod_piloto
		FROM pontuacao p
		WHERE p.pontos > 0
		AND c.ano = p.cod_campeonato
		ORDER BY p.pontos
		LIMIT 1)
AND p.cod_piloto = p1.cod
AND p.cod_equipe = e.cod
ORDER BY p.cod_campeonato

-- maior por ano
SELECT p1.nome, p.pontos, e.nome, p.cod_campeonato
FROM pontuacao p, piloto p1, equipe e, campeonato c
WHERE p.cod_campeonato = c.ano
AND p1.cod = (SELECT p.cod_piloto
		FROM pontuacao p
		WHERE c.ano = p.cod_campeonato
		ORDER BY p.pontos DESC
		LIMIT 1)
AND p.cod_piloto = p1.cod
AND p.cod_equipe = e.cod
ORDER BY p.cod_campeonato


-- 5. Exibir os nomes dos pilotos vencedores de cada prova (circuito), suas equipes
-- e seus pontos, em ordem crescente de pontos (em um ano específico).

SELECT p.nome, ci.nome, ci.cod
FROM piloto p, circuito ci, grid g
WHERE g.chegada = 1
AND g.cod_campeonato = 2006
AND g.cod_piloto = p.cod
AND g.cod_circuito =  ci.cod
ORDER BY g.cod_circuito

-- 6 Exibir os nomes das equipes e suas quantidade de pontos por ano (ou em um ano específico)

SELECT e.nome, SUM(pontos), e.cod
FROM equipe e, pontuacao p 
WHERE p.cod_campeonato = 2006
AND p.cod_equipe = e.cod
GROUP BY e.nome, e.cod

-- 7. Exibir o grid de largada de cada prova (circuito), com o nome da prova (circuito).

SELECT c.nome, g.largada, p.nome
FROM grid g, circuito c, piloto p 
WHERE g.cod_circuito = c.cod
AND p.cod = g.cod_piloto
ORDER BY g.cod_campeonato, c.cod, g.largada

-- 8 Exibir o grid de chegada (resultado) de cada prova (circuito), com o nome da prova (circuito).


SELECT c.nome, g.chegada, p.nome
FROM grid g, circuito c, piloto p 
WHERE g.cod_circuito = c.cod
AND p.cod = g.cod_piloto
ORDER BY g.cod_campeonato, c.cod, g.chegada

-- 9 Exibir lista de de maiores vencedores de circuitos em todos os anos

SELECT p.nome, count(*) AS counter
  FROM grid g, piloto p
 WHERE g.chegada = 1
   AND g.cod_piloto = p.cod
 GROUP BY p.nome
 ORDER BY counter DESC 