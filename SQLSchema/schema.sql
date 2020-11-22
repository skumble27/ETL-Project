 CREATE TABLE council_city(
	City VARCHAR,
	Council VARCHAR
)

SELECT * FROM council_city

CREATE TABLE population(
	Council VARCHAR,
	_2018 DECIMAL,
	_2019 DECIMAL,
	_2018_2019 DECIMAL,
	percentagechange DECIMAL,
	naturalincrease DECIMAL,
	area DECIMAL,
	population_density DECIMAL

	
)

SELECT * FROM population

CREATE TABLE eateries(
	eatery_name VARCHAR,
	eatery_address VARCHAR,
	eatery_rating DECIMAL,
	City VARCHAR

)

SELECT * FROM eateries

CREATE TABLE accommodation(
	accommodation_name VARCHAR,
	accommodation_address VARCHAR,
	accommodation_rating DECIMAL,
	City VARCHAR

)

SELECT * FROM accommodation

CREATE TABLE weather(
	long_term_avg_obs VARCHAR,
	averages DECIMAL,
	City VARCHAR

)

SELECT * FROM weather

CREATE TABLE tourist(
	tourist_site_name VARCHAR,
	tourist_site_address VARCHAR,
	tourist_site_rating DECIMAL,
	City VARCHAR
)

CREATE TABLE hotel_price (
	Hotel_name VARCHAR,
	City VARCHAR,
	Hotel_price DECIMAL,
	Hotel_rating DECIMAL

	
)

SELECT * FROM hotel_price

CREATE TABLE historical_hotel(
	historical_hotel VARCHAR,
	City VARCHAR

	
)

SELECT * FROM historical_hotel