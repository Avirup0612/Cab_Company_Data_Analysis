
# Provide Insights to the Chief of Operations of Goodcabs

## Brief introduction and situation

**Goodcabs**, a cab service company established two years ago, has gained a strong foothold in the Indian market by focusing on tier-2 cities. Unlike other cab service providers, Goodcabs is committed to supporting local drivers, helping them make a sustainable living in their hometowns while ensuring excellent service to passengers. With operations in ten tier-2 cities across India, Goodcabs has set ambitious performance targets for 2024 to drive growth and improve passenger satisfaction.

As part of this initiative, the Goodcabs management team aims to assess the company’s performance across key metrics, including trip volume, passenger satisfaction, repeat passenger rate, trip distribution, and the balance between new and repeat passengers.



## Description of Datasets given by the company

*\*The company has given both SQL databases and CSV files as data.
This description will give us the idea about the initial structure of the data*

#### **trips_db :** This database contains both detailed and aggregated data on trips, passenger types, and repeat trip behavior for Goodcabs' operations across tier-2 cities. It organizes trip data by city, month, and day type (weekday or weekend), enabling comprehensive analysis of travel patterns, passenger demographics, and repeat usage trends.

**1. dim_city**

Purpose: This table provides city-specific details, enabling location-based analysis of trips and passenger behavior across Goodcabs’ operational areas.
- city_id: A unique identifier for each city, using a standardized code (e.g., RJ01 for Jaipur).
- city_name: The name of the city where Goodcabs operates (e.g., Jaipur, Lucknow), used for location-based grouping and insights

**2. dim_date**

Purpose: This table provides date-specific details that enable time-based grouping and analysis, helping to identify patterns across days, months, and weekends versus weekdays.

- date: The specific date for each entry (formatted as YYYY-MM-DD), used for daily-level analysis and to join with trip data.
- start_of_month: The first day of the month to which the date belongs, useful for grouping data by month in analyses.
- month_name: The name of the month (e.g., January, February) corresponding to the date, helpful for month-based aggregations.
- day_type: Indicator of whether the date is a weekday or weekend, enabling analysis of demand and trip patterns across different day types.

**3. fact_passenger_summary (Aggregated Data)**

Purpose: This table provides an aggregated summary of passenger counts for each city by month. It includes data on total passengers, new passengers, and repeat passengers, giving a high-level overview of passenger distribution patterns across different locations and times.

- month: The start date of the month (formatted as YYYY-MM-DD). All metrics in this table are aggregated for the entire month, aligning with other time-based analyses.
- city_id: Unique identifier for the city.
- total_passengers: The aggregated count of all passengers (both new and repeat) for the specified city and month.
- new_passengers: The count of passengers taking their first ride in the specified city and month.
- repeat_passengers: The count of passengers who have taken at least one ride in previous months and returned to ride again in the specified city and month.

**4. dim_repeat_trip_distribution (Aggregated Data)**

Purpose: This table provides a breakdown of repeat trip behavior, aggregated by month and city. It details how many times repeat passengers rode within the given month, categorized by trip frequency. To keep things simple and ensure uniformity across cities, we have included trip frequencies up to a maximum of 10 trips per month. This allows for an analysis of repeat trip patterns at a granular level.

- month: The start date of the month (formatted as YYYY-MM-DD). All metrics in this table represent aggregated values for the entire month, allowing alignment with other date-based analyses.
- city_id: Unique identifier for the city.
- trip_count: The number of trips taken by repeat passengers within the specified city and month (e.g., "3-Trips" for passengers who took 3 trips).
- repeat_passenger_count: The count of repeat passengers associated with each specified trip_count for the city and month.

**5. fact_trips**

Purpose: This table provides detailed information on each trip, including trip-specific metrics like distance, fare, and ratings, which can be used for granular trip-level analysis.

- trip_id: Unique identifier for each trip.
- date: The exact date of the trip (formatted as YYYY-MM-DD).
- city_id: Unique identifier for the city where the trip took place.
- passenger_type: Indicates if the passenger is new (first-time rider) or repeat (returning rider).
- distance_travelled (km): Total distance covered in the trip, measured in kilometers.
- fare_amount: Total fare amount paid by the passenger for the trip, in local currency.
- passenger_rating: Rating provided by the passenger for the trip, on a scale from 1 to 10.
- driver_rating: Rating provided by the driver for the passenger, on a scale from 1 to 10.


#### **targets_db :** This database holds Goodcabs' monthly targets for each city, including goals for trip counts, new passenger acquisition, and average passenger ratings. It enables performance evaluations against key benchmarks set by the company.


**1. city_target_passenger_rating**

- city_id: Unique identifier for each city.
- target_avg_passenger_rating: The target average passenger rating that Goodcabs aims to achieve for each city, used to monitor customer satisfaction.

**2. monthly_target_new_passengers**

- month: The start date of the target month (formatted as YYYY-MM-DD) to align with other time-based data.
- city_id: Unique identifier for each city.
- target_new_passengers: The target number of new passengers Goodcabs aims to acquire in each city for the specified month, supporting growth tracking.

**3. monthly_target_trips**

- month: The start date of the target month (formatted as YYYY-MM-DD) for easy alignment with monthly performance data.
- city_id: Unique identifier for each city.
- total_target_trips: The target number of total trips Goodcabs aims to achieve for each city and month, enabling assessment of trip volume performance.

## Our Objective

- Process the given data and analyze it thoroughly.
- Give quick answers to the ad hoc requests.
- Generate insights from after analysing for reporting.
- Provide a few recommendations as a solution.

## Methodology used / Workflow

- Sql queries are written to get answers of ad hoc requests from the given sql databases by the company. We have leveraged "Joins", "CTE", "Group By", etc. to write the queries.
- The generated results are exported as CSV files.
- The exported CSV files are imported into Excel to display in a proper tabular format for quick reporting. We have leveraged "Pivot Charts", "Pivot Tables", "Conditional Formatting", etc., to create this.
- The comprehensive visualization and analysis has been done using Power BI. We have leveraged "Power Query" to process and clean the data, modeled the data for analysis, and used "Measures", "Calculated Columns", "Bookmarks", "Slicers", "Parameters", etc. to generate the report.
- After the analysis, we have documented our analysis, insights, and recommendations as a PDF to deliver as the final result.

## Files

**Ad_hoc_queries.sql :** This contains the sql queries written to answer the ad hoc requests.

**Goodcabs_Ad_hoc_report.xlsx :** This is the Excel file where we have all the answers of ad hoc requests as tables and charts.
(*The sheets are named properly based on the questions for easy understanding.*)

**Goodcabs_Data_Analysis.pbix :** This is the main power bi report where the comprehensive visualization is there.
(*Contains 3 pages, Dashboard - for overall idea, Passengers - for passenger-related visuals, and Trips and Revenue - for visuals related to trips and revenue*)

**Cab_Company_Data_Analysis.pdf :** This is the documentation of analysis, insights, and recommendations.

## Creator

This project is created by **Avirup Mitra**

**LinkedIn :** www.linkedin.com/in/avirupmitra06

Please feel free to DM for any suggestions and improvements, or any other queries. Thank you for your time.

**This is an overview of the project. Please refer to the main project files for detailed results**
