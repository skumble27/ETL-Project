-- 1. Obtaining a list of accommodations in Bright with a rating between 4 and 5
SELECT accommodation.city, accommodation.accommodation_name,accommodation.accommodation_rating, council_city.council
FROM accommodation
INNER JOIN council_city ON 
accommodation.city = council_city.city
WHERE accommodation.city = UPPER('bright') AND accommodation.accommodation_rating between 4 and 5;

-- 2. Obtaining information on eateries and accommodation for each major city in Victoria
SELECT eateries.eatery_name, eateries.city, accommodation.accommodation_name,
accommodation.accommodation_rating
FROM eateries
INNER JOIN accommodation ON
eateries.city = accommodation.city 

-- 3. Inner join of eateries with historical hotels
SELECT eateries.eatery_name, eateries.city, eateries.eatery_rating, historical_hotel.historical_hotel
FROM eateries
INNER JOIN historical_hotel ON
historical_hotel.city = eateries.city 

-- 4. Multiple Joins based on accommodation, rating, council, city, population, area and population density
SELECT accommodation.accommodation_name, accommodation.accommodation_rating,
council_city.council, council_city.city, population._2019, population.area, population.population_density
FROM accommodation
INNER JOIN council_city ON 
council_city.city = accommodation.city
INNER JOIN population ON
council_city.council = population.council

-- 5. Further Multiple Joins
SELECT accommodation.accommodation_name, accommodation.accommodation_rating,
council_city.council, council_city.city, population._2019 as city_population, population.area as area_sq_km, population.population_density,
tourist.tourist_site_name, tourist.tourist_site_rating, weather.averages AS weather_average
FROM accommodation
INNER JOIN council_city ON 
council_city.city = accommodation.city
INNER JOIN population ON
council_city.council = population.council
INNER JOIN tourist ON
tourist.city = council_city.city
INNER JOIN weather ON
weather.city = tourist.city

