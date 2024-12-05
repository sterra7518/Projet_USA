### Requete 1 ###

SELECT COUNT(DISTINCT cbsaa) AS nb_commune FROM commune
JOIN etat ON commune.id_etat = etat.code
WHERE part_usa = "North-East";
+------------+
| nb_commune |
+------------+
|        363 |
+------------+



### Requete 2 ###

SELECT SUM(population) AS pop_total FROM commune;
+-----------+
| pop_total |
+-----------+
| 285449705 |
+-----------+


### Requete 3 ###


SELECT nom_etat, AVG(pop_noir) FROM commune
JOIN etat ON commune.id_etat = etat.code
GROUP BY nom_etat
ORDER BY AVG(pop_noir) DESC
LIMIT 1;

+-------------+--------------------+
| nom_etat    | AVG(pop_noir)      |
+-------------+--------------------+
| Mississippi | 42.193962732950844 |
+-------------+--------------------+



### Requete 4  ###


SELECT nom_etat, part_usa, AVG(pop_blanche) FROM commune
JOIN etat ON commune.id_etat = etat.code
GROUP BY nom_etat
ORDER BY AVG(pop_blanche) DESC
LIMIT 10;

+---------------+------------+-------------------+
| nom_etat      | part_usa   | AVG(pop_blanche)  |
+---------------+------------+-------------------+
| Vermont       | North-East |  94.7546329498291 |
| Hew Hamsphire | North-East | 93.96544011433919 |
| Maine         | North-East | 93.85070037841797 |
| West Virginia | North-East |   93.828737112192 |
| Montana       | North-West | 91.97216288248698 |
| North Dakota  | North-West | 91.65321445465088 |
| South Dakota  | North-West | 90.33995749733664 |
| Ohio          | North-East | 90.14785893758138 |
| Pensylvania   | North-East | 89.43583471124822 |
| Kentucky      | North-East | 89.24978218078613 |
+---------------+------------+-------------------+



### Requete 5  ###

SELECT ROUND((COUNT(cbsaa)/(SELECT COUNT(cbsaa) FROM commune))*100,2) AS taux_com_non_bord FROM commune
WHERE pop_blanche < 50;

+-------------------+
| taux_com_non_bord |
+-------------------+
|             11.52 |
+-------------------+



### Requete 6 ###

SELECT COUNT(cbsaa) FROM commune
JOIN etat ON commune.id_etat = etat.code
WHERE bord_mer = "Yes" AND part_usa IN ('South-West','North-West');

+--------------+
| COUNT(cbsaa) |
+--------------+
|           26 |
+--------------+


### Requete 7 ###

SELECT candidat, COUNT(*) FROM commune
JOIN politique ON commune.id_politique = politique.id
WHERE bord_mer = "No"
GROUP BY candidat;

+----------+----------+
| candidat | COUNT(*) |
+----------+----------+
| Trump    |      576 |
| Clinton  |      203 |
+----------+----------+



### Requete 8  ###

WITH
moy_com AS
(SELECT nom_etat, nom, AVG(pop_hispa)  FROM commune
INNER JOIN etat ON commune.id_etat = etat.code
WHERE part_usa = 'South-West'
GROUP BY nom_etat, nom)
SELECT nom_etat, nom,round(AVG(pop_hispa), 2) 
FROM 
(SELECT nom_etat, nom, AVG(pop_hispa), rank() OVER (PARTITION BY nom_etat ORDER BY AVG(pop_hispa) DESC) AS rang FROM moy_com) 
AS Requete_Finale
WHERE rang <= 3;



SELECT part_usa,ROUND(AVG(pop_hispa),2) AS moy_hispa FROM commune
JOIN etat ON commune.id_etat = etat.code
GROUP BY part_usa
ORDER BY AVG(pop_hispa) DESC;

+------------+-------------------------+
| part_usa   |         moy_hispa       |
+------------+-------------------------+
| South-West |                   28.98 |
| North-West |                    8.03 |
| OTHER      |                    7.59 |
| South-East |                    6.45 |
| North-East |                    4.67 |
+------------+-------------------------+


### Requete 9  ###

SELECT nom_etat, ROUND(AVG(universite),2) FROM commune
JOIN etat ON commune.id_etat = etat.code
GROUP BY nom_etat
ORDER BY AVG(universite)
LIMIT 10;

+---------------+--------------------------+
| nom_etat      | ROUND(AVG(universite),2) |
+---------------+--------------------------+
| Arkansas      |                    16.87 |
| Tennessee     |                    17.54 |
| West Virginia |                    17.54 |
| Ohio          |                    17.72 |
| Georgia       |                    17.81 |
| Texas         |                     17.9 |
| Indiana       |                    18.08 |
| Kentucky      |                    18.27 |
| Louisiana     |                    18.78 |
| Nevada        |                    18.81 |
+---------------+--------------------------+










### Requetes 10 ###

SELECT candidat , COUNT(*) FROM commune
JOIN politique ON commune.id_politique = politique.id
WHERE moins_20d > 30
GROUP BY candidat;






### Requetes 11 ###

SELECT AVG(pop_blanche), AVG(pop_noir), AVG(pop_hispa), AVG(pop_asia) FROM commune
WHERE no_diplome < 10;



### Requetes 12 ###

SELECT candidat, AVG(moins_20d), AVG(de20_40d), AVG(de40_60d), AVG(de60_80d), AVG(plus_80d) FROM commune
JOIN politique ON commune.id_politique = politique.id
GROUP BY candidat;