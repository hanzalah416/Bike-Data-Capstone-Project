WITH MonthlyCounts AS (
    SELECT
        YEAR([started_at]) AS Year,
        MONTH([started_at]) AS Month,
        COUNT(*) AS TotalCount,
        SUM(CASE WHEN [member_casual] = 'casual' THEN 1 ELSE 0 END) AS CasualCount,
        SUM(CASE WHEN [member_casual] = 'member' THEN 1 ELSE 0 END) AS MemberCount,
        SUM(CASE WHEN [rideable_type] = 'classic_bike' THEN 1 ELSE 0 END) AS ClassicBikeCount,
        SUM(CASE WHEN [rideable_type] = 'docked_bike' THEN 1 ELSE 0 END) AS DockedBikeCount,
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
            WHERE YEAR(RL.[started_at]) = YEAR(MC.[started_at])
                AND MONTH(RL.[started_at]) = MONTH(MC.[started_at])
        ) AS average_ride_length,
        (
            SELECT TOP 1
                ride_length
            FROM
                (SELECT ride_length, NTILE(2) OVER(ORDER BY ride_length) AS ntile
                 FROM [master].[dbo].[12monthsdata2023] sub
                 WHERE YEAR(sub.[started_at]) = YEAR(MC.[started_at])
                    AND MONTH(sub.[started_at]) = MONTH(MC.[started_at])) AS sub
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
            WHERE YEAR(RL.[started_at]) = YEAR(MC.[started_at])
                AND MONTH(RL.[started_at]) = MONTH(MC.[started_at])
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
            WHERE YEAR(RT.[started_at]) = YEAR(MC.[started_at])
                AND MONTH(RT.[started_at]) = MONTH(MC.[started_at])
            GROUP BY
                [rideable_type]
            ORDER BY
                COUNT(*) DESC, [rideable_type] DESC
        ) AS mode_rideable_type,
        (
            SELECT TOP 1
                [member_casual]
            FROM
                [master].[dbo].[12monthsdata2023] MCasual
            WHERE YEAR(MCasual.[started_at]) = YEAR(MC.[started_at])
                AND MONTH(MCasual.[started_at]) = MONTH(MC.[started_at])
            GROUP BY
                [member_casual]
            ORDER BY
                COUNT(*) DESC, [member_casual] DESC
        ) AS mode_member_casual,
        (
            SELECT TOP 1
                [day_of_week]
            FROM
                [master].[dbo].[12monthsdata2023] DOW
            WHERE YEAR(DOW.[started_at]) = YEAR(MC.[started_at])
                AND MONTH(DOW.[started_at]) = MONTH(MC.[started_at])
            GROUP BY
                [day_of_week]
            ORDER BY
                COUNT(*) DESC, [day_of_week] DESC
        ) AS mode_day_of_week
    FROM [master].[dbo].[12monthsdata2023] MC
    GROUP BY YEAR([started_at]), MONTH([started_at])
)

SELECT
    Year,
    Month,
    AvgRideLengthInMeters,
    average_ride_length,
    median_ride_length,
    mode_ride_length,
    mode_rideable_type,
    mode_member_casual,
    mode_day_of_week,
    TotalCount,
    CasualCount,
    MemberCount,
    ClassicBikeCount,
    DockedBikeCount,
    MondayCount,
    TuesdayCount,
    WednesdayCount,
    ThursdayCount,
    FridayCount,
    SaturdayCount,
    SundayCount,
    100.0 * CasualCount / TotalCount AS PercentageCasual,
    100.0 * MemberCount / TotalCount AS PercentageMember,
    100.0 * ClassicBikeCount / TotalCount AS PercentageClassicBike,
    100.0 * DockedBikeCount / TotalCount AS PercentageDockedBike,
    100.0 * MondayCount / TotalCount AS PercentageMonday,
    100.0 * TuesdayCount / TotalCount AS PercentageTuesday,
    100.0 * WednesdayCount / TotalCount AS PercentageWednesday,
    100.0 * ThursdayCount / TotalCount AS PercentageThursday,
    100.0 * FridayCount / TotalCount AS PercentageFriday,
    100.0 * SaturdayCount / TotalCount AS PercentageSaturday,
    100.0 * SundayCount / TotalCount AS PercentageSunday
FROM MonthlyCounts
ORDER BY Year, Month;
