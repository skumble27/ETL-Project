# ETL-Project

**Gina, Shona and Sumukh**

## Project Proposal

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

## Data <u>*Extraction*</u>

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



## Data <u>*Transformation*</u>

The extracted datasets were each cleaned in jupyter notebook, using Pandas, to ensure that all data to be loaded into the relational database matched the primary key of our core table; city name from the city and council list (see raw data directory, Vic-LGA-List.csv).

### Data Transformation Challenges and Considerations

The Vic-LGA-List.csv was cleaned by importing it into a pandas data frame (df) and removing un-needed columns. The end df displayed just the council name and main city for each of the 79 LGA’s and was saved to csv for use by all project team members when setting data extraction parameters and also ready for importing into pgadmin. 

These 79 cities were then used as the core list for extracting datasets using Google API calls and web-scraping weather average observation data from the Elders Weather site (see Extract section above).

![Screen Shot 1](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot1.png)

**Figure 1: Cleaning the Data Set containing a list of councils and their major city** 

The population data extracted from the Australian Bureau of Statistics (ABS) did not required cleaning and was saved to the repo in the cleaned data directory ready to be loaded into pgadmin.

The source of the holiday_price dataset, website holidu.com.au, allows accommodation owners to enter their location manually. Thus, we found that some of the owner keyed information scraped showed the location of their accommodation as ‘Victoria.’ While this matched the search criteria used, it was not granular enough to relate to our cities or council name core dataset. We also considered that for our database users this state location description would not be useful information for planning their travel.  The number of hotels with the ‘Victoria’ location in the holiday_price_df was low (n=9) and the decision was taken to drop them from the dataset.

![Screen Shot 2](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot2.png)

**Figure 2: Checking location “Victoria” and dropping these from the dataset **

Another result of manual data entry to holidu was the presence of many special symbols in the data extracted, such as “$”, “/”, “~”, “,” . These symbols not only looked messy, but may cause errors with loading to pgadmin. Cleaning was performed to remove the symbols and also to change the lower case presentation of city names to the upper case presentation. This was to ensure cities matched the format of the core city council dataset. Again this was done to standardise appearance of data but more importantly to ensure that database users can sort and manipulate the accommodation listed in this data set successfully using joins etc. The hotel_price_df once fully cleaned was exported to csv for loading into pgadmin.

![Screen Shot 3](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot3.png)

**Figure 3: Removing special symbols from Hotel Price Dataset**

The historic hotels csv download was imported to a pandas df and duplicates in the dataset dropped; reducing the dataset from 6271 to 1933 rows. The index was also dropped in the export to csv making the hotel name the first column for the load into pgadmin.

![Screen Shot 4](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot4.png)

**Figure 4: Cleaning the Data Set relating to Historical Hotels in Victoria**

The weather data scraped, were values from a table along with the name of each city used in the scrape to obtain the weather value. Each of the returned 4108 (52 sets for each of the 79 cities) values required the description of each value, which was not extracted from the html scrape, to be appended to a list so that all the weather data could be assembled into a pandas df. This was achieved by setting and obs list and looping this list to create the required number of entries. The scraped data was then was transformed into a pandas df, given appropriate labels and exported to csv (index dropped).

![Screen Shot 5](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot5.png)

**Figure 5: Creating a Dataframe relating to the weather patterns in Victoria**

The data retuned from the 3 Google API calls were each transformed into pandas df’s (one for each dataset). The column names were updated as required and duplicates were dropped from each df. This reduced the eateries from 1453 to 1432 rows, the accommodation from 1296 to 1275 rows, and the tourist sites (attractions) from 1550 to 1536 rows. Each of the df’s were exported to csv (indexes dropped).

![Screen Shot 6](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot6.png)

**Figure 6: Removing duplicate data from the data frame containing information on popular eateries in Victoria**

## Data *<u>Loading</u>*

Upon the completion of the extraction and transformation of the raw datasets, which were obtained from different sources as previously described, the cleaned data sets, which were exported as CSV files were used to upload into a relational database using the PostgreSQL language. The software interface utilised in this project was PgAdmin 4, however, various other platforms that are compatible with PostgreSQL can also be utilised. The SQL database was created in the local directory with the name "travel_vic_db". 

In order to suitable design the database, a diagrammatical schema was developed in order to map the manner in which the various tables would relate to each other. 

![Screen Shot 7](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot9.png)

**Figure 7: Schema that was used to design the database**

Based on the above diagram, a schema was scripted using the PostgreSQL language in which to create the required tables for the database. A sample of the schema has been provided below, however, a detailed schema can be obtained from the repository.

<img src="https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot8.png" alt="Screen Shot 8" style="zoom:50%;" />

**Figure 8: Sample PostgreSQL schema for creating the tables in the database**

Once the tables were created using the schema that has been provided in the repository, all the cleaned datasets, which were in a CSV format, were successfully imported into the PgAdmin 4 interface. In order to test the efficacy of the database, a number of initial queries were submitted in which to determine if all the tables could be called using the PostgreSQL syntax. As seen from Figure 8, a table was created relating population within each council in Victoria, for which a screen shot has been provided below.

![Screen Shot 9](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot10.png)

**Figure 9: Calling the entire population table in PosgreSQL**

Establishing the SQL database proved to be a rather straightforward endeavour based on the stringent consolidation of the various datasets that were obtained from different sources. In order to ensure that the CSV files were successfully imported, a number of data refinements needed to be undertaken, for instance, removing non ASCIII characters, removal of the index columns in the pandas dataframe prior to export and ensuring that the column headers matched the table headers that were created in the PostgreSQL script. In summary, the datasets were successfully extracted using webscraping methodologies, API calls and retrieval of csv files, cleaned and successfully loaded into an SQL based relational database. 

## Evaluation of the Database

In order to determine if the databased could be efficiently explored based on various customer needs, a number queries were undertaken based on speculated customer preferences, which have been set out below:

1. Obtaining a list of accommodations in Bright with a rating between 4 and 5

![Screen Shot 10](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot11.png)



2. Obtaining information on eateries and accommodations for each major city in Victoria

![Screen Shot 10](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot12.png)

3. Obtaining a list of eateries in proximity to various historical hotels in Victoria

![Screen Shot 10](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot13.png)

4. Obtaining information on accommodation, accommodation ratings, council, city, population, area and population density.

![Screen Shot 10](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot14.png)

5. Obtaining information on accommodation, ratings, council, city, population, area, population density, tourist attractions and ratings, and average temperatures. (This query required multiple joins across several tables which were successfully executed)

![Screen Shot 10](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/screenshot15.png)

Based on the above sample queries, customers can obtain all the relevant information they may require when planning their vacation during the Christmas period or at any time during the year. 

## Accessing the Database through Python SQL Alchemy Modules

A full jupyter notebook script has been provided in the repository wherein the SQL ALchemy module was utilised in Python to access the PostgreSQL server and retrieve the travel_vic_db. The intention was to demonstrate how the tables can be accessed and read in a dataframe and further analysed using various python modules such as Matplotlib. There maybe an instance where the customers are interested in getting a glimpse of the average accommodation ratings in various cities and therefore, the dataset relating to cities and accommodations were retrieved, converted into a dataframe and plotted into a bargraph using the matplotlib python dependency. The two graphs that provide a snapshot on which cities have the highest accommodation and/or eatery ratings, which in turn, can provide a chance to further facilitate the customers choices in planning their vacation. 

![Screen Shot 11](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/Screenshot18.png)



**Figure 10: Average accommodation rating across Victorian cities**

![Screen Shot 11](https://raw.githubusercontent.com/skumble27/ETL-Project/main/Images/Screenshot19.png)

**Figure 11: Average eatery rating across Victorian cities**

## Conclusion

Web scraping proved to be a technical challenge as it was determined that a number of organisations are utilising Javascript syntaxes in which to launch their websites. This in turn, makes data retrieval a more tedious process that requires daily optimisation of the python codes to retrieve new sets of data in order to update the database. 

## Recommendation

Meticulous planning and scoping of the data relationships are required before extraction protocols are initiated as this will reduce the overall timeframe towards completion and establishment of the database. This proved to be the case when issues with non ASCII characters were present within the datasets as well as removing default indexes that are created in pandas dataframes. Once addressed, loading cleaned datasets into a PostgreSQL server will be reasonably straightforward. 