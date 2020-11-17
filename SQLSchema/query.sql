-- Obtain the council and city based on accomodations and rating
SELECT accommodation.city, accommodation.accommodation_name,accommodation.accommodation_rating, council_city.council
FROM accommodation
INNER JOIN council_city ON 
accommodation.city = council_city.city

-- 
SELECT eateries.eatery_name, eateries.eatery_rating, eateries.city
FROM eateries WHERE eateries.eatery_rating BETWEEN 4 AND 5