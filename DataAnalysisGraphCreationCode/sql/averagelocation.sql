SELECT 
    AVG(start_lat) AS avg_start_latitude,
    AVG(start_lng) AS avg_start_longitude,
    AVG(end_lat) AS avg_end_latitude,
    AVG(end_lng) AS avg_end_longitude
FROM 
[master].[dbo].[12monthsdata2023]