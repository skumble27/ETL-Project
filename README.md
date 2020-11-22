# ETL-Project

**Gina, Shona and Sumukh**

## <u>Project Proposal</u>

### Background

With restrictions that are commencing to ease in Victoria, there is great anticipation for many people to plan their vacations in regional areas of the state, especially during Christmas and New Years. Taking this into consideration, many families would like to quickly obtain information on their preferred destinations and determine the best accommodation, weather and population density to plan their vacation according to their needs. 

**Database Creation**

The purpose of this project is to obtain data from various different sources related to the following criteria:

1. List of councils in the State of Victoria along with the major city
2. Weather information utilising API calls to obtain historical data
3. Accommodation services using web scraping algorithms to obtain price, ratings and location
4. Tourist attractions 
5. Population density

**Project Rationale**

Upon creation of this Data Warehouse, users will be provided an opportunity to rapidly query their destinations and plan their vacations accordingly. The final database will be consolidated and uploaded onto a relational SQL database using the Postgres. 

## <u>Database Engineering</u>

**Introduction**

This project demonstrates our project team’s skills and knowledge in extraction, transformation and loading (ETL) of datasets into a data store. The requirement was to determine a subject for which several datasets of reasonable size could be sourced and stored together to enable purposeful querying by an end user.

Our team, inspired by the recent lifting of strict pandemic related travel restrictions around Melbourne (the state capital of Victoria) decided to create a database that holds information that could be queried to support a user to plan a holiday or weekend getaway – something many people are likely keen to want to do at this time. 

Given the ongoing state boarder travel restrictions and the pre-standing encouragement for Victorians to holiday where their tourist spend can benefit fire effected communities (many areas in the state’s south east were severely impacted by Australia’s black summer of 2019/2020), we narrowed the scope of the holiday destination database to destination data for cities and towns in our home state (Victoria). 

With some basic internet searches, we were able to determine that there are 79 local government areas (LGAs) in Victoria. We decided to obtain accommodation, eateries, weather averages, population information and tourist attractions for each LGA, using the main city/town for each area as the linking location (primary and foreign keys) for the data sets extracted.

The final data warehouse consolidated datasets extracted and uploaded these to a relational SQL database using the PostgreSQL language within the PgAdmin 4 software. Our Victorian travel database allows users the opportunity to rapidly query main city/town destinations to plan their ‘COVID normal’ holiday breaks in Victoria and enjoy some well-earned freedom to travel that also supports communities across our home state and is in time for the summer holiday season.



## **Data <u>Extraction</u>**

Eight datasets were extracted from 6 different online sources. Together these extracted datasets comprised over 28,000 data points that were to be included in our relational database. Data types included downloaded CSV files, web scraped data and information returned from API calls all were loaded into Jupyter notebook for subsequent transformation.

***Data Extraction Challenges and Considerations***

While some data required was straight forward to source, LGA list with main towns/cities and population data from the ABS. Other types of data proved more challenging to extract. 

To scrape accommodation data, a number of well-known websites were considered however, booking websites, such as Trivago and Stayz etc. use JavaScript to stop competitors, or others (such as us) scraping data from their webpage. This meant we could not use splinter to dive-into more pages and scrape more data past the first page. 

In addition, other popular accommodation search websites like Airbnb, list all the accommodation detail information in a block, which prevents scraping accommodation name, price, location and rating data from the search result page. 

Given these challenges, we decided to cast our search wider and scrape a less-well known accommodation website, Holidu, as well as use a Google API call and seek publicly available online library records of accommodation in Victoria. This lead to the discovery of a csv formatted dataset of historical hotels for cities/towns in Victoria, available through the State Library of Victoria, which satisfied the database intention, not only to include accommodation options, but also to list places of interest to tourists, which many of the listed establishments are likely to also be.

Data was successfully scraped from Holidu that included the name of hotels, prices and ratings. The search used on this site was for ‘Victoria’ and set for the Dec 20 – Jan 21 (summer holiday) period, to enable prices to be included in the extract relevant to the use case for our travel database.

Initially we intended to scrape weather average data from the Australian Bureau of Meteorology (BOM) website, however the structure of the average weather data presented on this site was not contiguous with the 79 LGA’s or their main towns/cities. We decided therefore, to scrape this data from Elders Weather, a well-respected Australian weather site that draws from and reproduces average weather data collected by BOM.

Extractions of tourist attractions, eateries and accommodation options were also made using calls to Google’s API service.  These API calls were set to loop through the core list of cities extracted from the LGA download to ensure that all returned data matched the key relationship of our database (main council area cities in Vic). The search terms included in the API calls were tested multiple times and modified to determine the best group of terms to return the greatest amount of relevant data. While Google offers current status of businesses listed, in terms of pandemic operations, we decided to drop inclusion of this element return from API calls, as it was not consistently available data and this reduced the amount of returned data significantly. This data is also prone to rapid change as restrictions continue to ease or in case of further clusters being identified. This means inclusion of such data would likely become misleading artefact for users of our database. We therefore, decided not to include this data element in our Google API data extracts. 

**Table 1 - Victorian Holiday Data Extraction Summary**

| Data   description          | Format / Type    | Web Source                | Extraction Method         | Number of rows  (cleaned) | Number of columns  (cleaned) | Total data extracted  (cleaned) |
| --------------------------- | ---------------- | ------------------------- | ------------------------- | ------------------------- | ---------------------------- | ------------------------------- |
| LGA and main town/city      | CSV file         | Know your council         | CSV download              | 79                        | 2                            | 158                             |
| Vic Population data (18/19) | CSV file         | ABS                       | CSV download              | 79                        | 8                            | 632                             |
| Weather Averages            | Pandas df to CSV | Elders Weather            | Web scrape  Bs4, splinter | 4109                      | 1                            | 4109                            |
| Accommodation priced        | Pandas df to CSV | Holidu                    | Web Scrape  Bs4, splinter | 637                       | 4                            | 2548                            |
| Eateries rated              | Pandas df to CSV | Google                    | Google API call           | 1433                      | 4                            | 5732                            |
| Tourist Sites rated         | Pandas df to CSV | Google                    | Google API call           | 1537                      | 4                            | 6148                            |
| Accommodation rated         | Pandas df to CSV | Google                    | Google API call           | 1276                      | 4                            | 5104                            |
| Historic Accommodation      | CSV file         | State Library of Victoria | CSV download              | 1934                      | 2                            | 3868                            |



## **Data <u>Transformation</u>**

The extracted datasets were each cleaned in jupyter notebook, using Pandas, to ensure that all data to be loaded into the relational database matched the primary key of our core table; city name from the city and council list (see raw data directory, Vic-LGA-List.csv).

### Data Transformation Challenges and Considerations

The Vic-LGA-List.csv was cleaned by importing it into a pandas data frame (df) and removing un-needed columns. The end df displayed just the council name and main city for each of the 79 LGA’s and was saved to csv for use by all project team members when setting data extraction parameters and also ready for importing into pgadmin. 

These 79 cities were then used as the core list for extracting datasets using Google API calls and web-scraping weather average observation data from the Elders Weather site (see Extract section above).