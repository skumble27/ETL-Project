CREATE TABLE Councils(
	Council VARCHAR,
	City VARCHAR
	

)

CREATE TABLE Hotels(
	City VARCHAR,
	Hotel VARCHAR

	
)

CREATE TABLE Population(
	LGAcode VARCHAR,	
	Council VARCHAR,
	_2018 DECIMAL,
	_2019 DECIMAL,	
	_2018_2019	DECIMAL,
	percentagechange DECIMAL,
	Naturalincrease DECIMAL,
	Netinternalmigration DECIMAL,
	Netoverseasmigration DECIMAL,
	Areasqkm DECIMAL,
	Populationdensity DECIMAL

)