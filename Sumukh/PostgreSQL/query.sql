SELECT councils.city, population.council, population.areasqkm, population.populationdensity
FROM Councils
INNER JOIN population on 
population.council = councils.council
