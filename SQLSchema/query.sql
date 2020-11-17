-- Obtain the council and city based on accomodations and rating
SELECT accommodation.city, accommodation.accommodation_name,accommodation.accommodation_rating, council_city.council
FROM accommodation
INNER JOIN council_city ON 
accommodation.city = council_city.city

-- 2. Inner join two tables, eateries with population
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

-- 4. Multiple Joins - Eatery, city, accommodation, hotel, population

