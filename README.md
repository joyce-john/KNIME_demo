# KNIME Cleaning and Analysis Demo
#### by Yuri Almeida, Steve Jantso, John Joyce


## About this repo

Project artifacts in this repo:

+ **report** - *DE_Guidelines.docx* provides a thorough technical overview
+ **Powerpoint presentation** - *Presentation.pptx* briefly explains the project
+ **KNIME workflow file** - *crashes_workflow.knwf* should run with minimal configuration
+ **source files** - none, all data is fetched through APIs in KNIME
+ **script for data persistence** - *SQL_script_for_local_DB* folder contains the SQL script to set up the MySQL DB

## About reproducibility

In order to reproduce our results, you will need to do two things before running the KNIME workflow:

+ set up the MySQL database by running the included script
+ configure the **MySQL Connector** node in the KNIME workflow with your own database address and credentials

## Project Overview

We wanted to take a look at motor vehicle crashes in New York City and also consider the weather conditions during these crashes. We also wanted to create a tool that would allow anyone to do further analysis on the data. That's why we created a KNIME workflow which anyone can run (and tinker with the analysis on the last nodes, if they wish) and a database with our cleaned data.

For our project, we decided to look at crashes in May 2019. We got our crash data from [NYC OpenData](https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95) and our weather data from [NOAA](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#datasets). The metadata below shows our data gathering and analysis plan:

![metadata](/workflow_images/workflow_metadata.png)

The process:

1. Get the datasets in JSON format via API
2. Clean the tables
3. Join the two tables into one table to create an analytical layer
4. Save the joined table to a database and perform analysis

You can see a detailed overview of the KNIME workflow below:

![KNIME_workflow](/workflow_images/workflow_overview.jpg)

## Technical Challenges and Decisions

The main challenges centered around data collection and cleaning.

For gathering the weather data, we needed to specify one NOAA weather station to use a source of precipitation measurements. We searched for weather stations with [this tool](https://www.ncdc.noaa.gov/cdo-web/datatools/findstation) and selected the weather station at LaGuardia Airport. This station has measurements for every day in the time period we were interested in. It is proximal to the area we are studying.

![weather_station](/workflow_images/weather_station.jpg)

For gathering data on car crashes, we needed to decide on the time interval of our data. (Should we analyze a month of data, a week, a year, etc...) We decided to analyze data on a monthly basis. This generates a manageable number of records each time the workflow is run (around 20k, depending on the month) and allows the user to examine any seasonal changes in crashes and rainfall by comparing one month's report against the others.

Data cleaning involved transforming two JSON objects into one neat table. The JSON objects started in KNIME as tables of one meaningful column with one row that contained all the data. They needed to be unpacked into a neat table which could be used for analysis.

![input_vs_output](/workflow_images/input_vs_output.jpg)

## Solutions Provided

#### Persistance in a Database

Our cleaned data is stored on a MySQL server. The data can be accessed without the need to run the KNIME workflow again. Users can run the KNIME workflow on different months to collect more observations, and it can all be stored in the same DB for later access.

The data has a simple structure, because there is only one table:

![db_schema](/Term_DE2/SQL_script_for_local_DB/db_schema.jpg)

#### Basic Analytics

Using the **Auto-Binner** and **Histogram** nodes, we can generate some basic overviews of the injuries and deaths in the given month. We bin the injuries and deaths by the amount of precipitation on the day of the crash.

We show one histogram which is color-coded by the type of injury or death (pedestrian, cyclist, etc), and we show one simple histogram which just shows all injuries as one category. Users may choose to use the simple or complex histogram, depending on their preference.

![complex_histogram](/workflow_images/distribution_complex_version.jpg) ![simple_histogram](/workflow_images/distribution_simple_version.jpg)

#### Visualizations

We can filter the observations by meaningful criteria and show those observations on a map. This could help researchers identify dangerous roads that require attention from city officials. We show two maps in our workflow:

**Crashes which resulted in 1 or more deaths**
![lethal_crashes](/workflow_images/lethal_crashes.jpg)

**Crashes where a cyclist was injured**
![cyclist_injuries](/workflow_images/cyclist_injuries.jpg)

## Who did what?

#### Pre-KNIME
+ **API requests in Postman** - Steve, Yuri, John

#### KNIME workflow
+ **Get + Transform Crash Data** - Yuri
+ **Get + Transform Weather Data** - Steve, John
+ **Join + Fix Data Types** - Steve, Yuri
+ **Write to Local DB** - Yuri, John
+ **Analyze Injury/Death Distributions** - Steve, John
+ **Show Lethal Crashes / Show Cyclist Injuries** - John

#### Project artifacts
+ **Writing Documentation** - Steve, Yuri, John
+ **Formatting Report** - Yuri
+ **Creating Powerpoint** - Steve






