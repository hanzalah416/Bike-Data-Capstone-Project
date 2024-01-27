-- Declare a variable to hold the member_casual value
DECLARE @MemberCasual NVARCHAR(50);
SET @MemberCasual = 'casual';

-- Common Table Expression (CTE) for calculating monthly counts
WITH MonthlyCounts AS (
    SELECT
        COUNT(*) AS TotalCount,
        SUM(CASE WHEN [member_casual] = @MemberCasual THEN 1 ELSE 0 END) AS MemberCount,
        SUM(CASE WHEN [rideable_type] = 'classic_bike' THEN 1 ELSE 0 END) AS ClassicBikeCount,
        SUM(CASE WHEN [rideable_type] = 'electric_bike' THEN 1 ELSE 0 END) AS ElectricBikeCount,
        SUM(CASE WHEN [day_of_week] = 1 THEN 1 ELSE 0 END) AS MondayCount,
        SUM(CASE WHEN [day_of_week] = 2 THEN 1 ELSE 0 END) AS TuesdayCount,
        SUM(CASE WHEN [day_of_week] = 3 THEN 1 ELSE 0 END) AS WednesdayCount,
        SUM(CASE WHEN [day_of_week] = 4 THEN 1 ELSE 0 END) AS ThursdayCount,
        SUM(CASE WHEN [day_of_week] = 5 THEN 1 ELSE 0 END) AS FridayCount,
        SUM(CASE WHEN [day_of_week] = 6 THEN 1 ELSE 0 END) AS SaturdayCount,
        SUM(CASE WHEN [day_of_week] = 7 THEN 1 ELSE 0 END) AS SundayCount,
        AVG(
            6371 * 2 * ASIN(
                SQRT(
                    POWER(SIN(RADIANS(([end_lat] - [start_lat]) / 2)), 2) +
                    COS(RADIANS([start_lat])) * COS(RADIANS([end_lat])) *
                    POWER(SIN(RADIANS(([end_lng] - [start_lng]) / 2)), 2)
                )
            )
        ) * 1000 AS AvgRideLengthInMeters,
        (
            SELECT AVG(ride_length)
            FROM [master].[dbo].[12monthsdata2023] RL
            WHERE [member_casual] = @MemberCasual -- Only 'member' rides
        ) AS average_ride_length,
        (
            SELECT TOP 1
                ride_length
            FROM
                (SELECT ride_length, NTILE(2) OVER(ORDER BY ride_length) AS ntile
                 FROM [master].[dbo].[12monthsdata2023] sub
                 WHERE [member_casual] = @MemberCasual -- Only 'member' rides
                ) AS sub
            WHERE
                ntile = 1
            ORDER BY
                ride_length DESC
        ) AS median_ride_length,
        (
            SELECT TOP 1
                ride_length
            FROM
                [master].[dbo].[12monthsdata2023] RL
            WHERE [member_casual] = @MemberCasual -- Only 'member' rides
            GROUP BY
                ride_length
            ORDER BY
                COUNT(*) DESC, ride_length DESC
        ) AS mode_ride_length,
        (
            SELECT TOP 1
                [rideable_type]
            FROM
                [master].[dbo].[12monthsdata2023] RT
            WHERE [member_casual] = @MemberCasual -- Only 'member' rides
            GROUP BY
                [rideable_type]
            ORDER BY
                COUNT(*) DESC, [rideable_type] DESC
        ) AS mode_rideable_type,
        (
            SELECT TOP 1
                [day_of_week]
            FROM
                [master].[dbo].[12monthsdata2023] DOW
            WHERE [member_casual] = @MemberCasual -- Only 'member' rides
            GROUP BY
                [day_of_week]
            ORDER BY
                COUNT(*) DESC, [day_of_week] DESC
        ) AS mode_day_of_week
    FROM [master].[dbo].[12monthsdata2023] MC
    WHERE [member_casual] = @MemberCasual -- Only 'member' rides
)

-- Query for all data without splitting into months
SELECT
    'All' AS Month, -- 'All' to indicate it's for all data
    AvgRideLengthInMeters,
    average_ride_length,
    median_ride_length,
    mode_ride_length,
    mode_rideable_type,
    mode_day_of_week,
    TotalCount,
    MemberCount,
    ClassicBikeCount,
    ElectricBikeCount,
    MondayCount,
    TuesdayCount,
    WednesdayCount,
    ThursdayCount,
    FridayCount,
    SaturdayCount,
    SundayCount,
    100.0 * MemberCount / TotalCount AS PercentageMember,
    100.0 * ClassicBikeCount / TotalCount AS PercentageClassicBike,
    100.0 * ElectricBikeCount / TotalCount AS PercentageElectricBike,
    100.0 * MondayCount / TotalCount AS PercentageMonday,
    100.0 * TuesdayCount / TotalCount AS PercentageTuesday,
    100.0 * WednesdayCount / TotalCount AS PercentageWednesday,
    100.0 * ThursdayCount / TotalCount AS PercentageThursday,
    100.0 * FridayCount / TotalCount AS PercentageFriday,
    100.0 * SaturdayCount / TotalCount AS PercentageSaturday,
    100.0 * SundayCount / TotalCount AS PercentageSunday
FROM MonthlyCounts;
