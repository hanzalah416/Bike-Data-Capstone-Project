# Bike-Data-Capstone-Project
README.md

Project Summary:
----------------
This project was completed as the final capstone project of google's data analytics certification.
This project involves a detailed analysis of bike-share data, focusing on exploring usage patterns of Cyclistic's services. The analysis encompasses data cleaning, processing, and visualization to extract actionable insights, with a particular emphasis on differentiating between member and casual user behaviors.

Folder Structure:
-----------------
-FinalReport.pdf - Final Google Data Analytics Capstone Project Report https://drive.google.com/file/d/1efTjh_o073kixkClSRVRAUnRBY2Myr7T/view?usp=sharing 

- Data/
  - Data.zip/    - Contains cleaned and organized data files, both in CSV and Excel formats.
    - 12monthsdata2023.csv
    - 12monthsdata2023.xlsx
    - membercasualridelengthkm.csv
    - membercasualridelengthkm.xlsx
  - Raw Source Data/           - Original, raw data files.

- Data Analysis: Graph Creation Code/
  - python/                    - Python scripts for data analysis and visualization.
    - datamonthspiderplot.py   - Generates spider plots for monthly data.
    - dataweekspiderplot.py    - Generates spider plots for weekly data.
    - doublebargraphelectric.py- Creates double bar graphs for electric bike usage.
    - heatmap.py               - Script for generating heatmaps.
    - ridelengthdoublebar.py   - Creates double bar graphs for ride lengths.

  - sql/                       - SQL scripts for data extraction and manipulation.
    - averagelocation.sql      - SQL query to calculate average location.
    - averagesridetime.sql     - SQL query to calculate average ride times.
    - infomonths.sql           - SQL query for monthly data information.
    - infoyear.sql             - SQL query for yearly data information.

- Graphs/                      - Contains generated graphs and visualizations.
-  https://hanzalah416.github.io/Bike-Data-Capstone-Project/Graphs/casual_heatmap.html
-  https://hanzalah416.github.io/Bike-Data-Capstone-Project/Graphs/member_heatmap.html

Tools Used:
-----------
- Python: Used for scripting advanced data analyses and visualizations, employing libraries like pandas, matplotlib, seaborn, and plotly.

- SQL: Employed for database management, data extraction, and manipulation. (Azure Data Studio for M1 Mac)

- Excel: Used for initial data cleaning, organization, and basic visualization.

- Docker: Utilized for setting up isolated SQL environments to run queries on tables created from imported csv files in Data/

Project Overview:
-----------------
The project starts with data collection from raw sources, followed by cleaning and organizing the data using Excel. The cleaned data is processed using Python for advanced analysis and visualization. SQL scripts are used for specific data queries and extraction. The project aims to provide a deep understanding of user behavior and preferences in the bike-sharing service, aiding in strategic decision-making.
