select top 20 * from spotify;

--Q1.How much total time have I spent listening to Spotify?
SELECT 
    SUM(ms_played) / (1000*60*60) AS total_listening_hours
FROM spotify;


--Q2. How has my total Spotify listening time changed year over year?
SELECT 
    YEAR(event_time) AS year,
    ROUND(SUM(listening_minutes) / 60, 2) AS listening_hours
FROM spotify
GROUP BY YEAR(event_time)
ORDER BY year;

--Q3.What is my average daily listening time?
SELECT 
    round(AVG(daily_minutes),2) AS avg_daily_minutes
FROM (
    SELECT 
        CAST(event_time AS DATE) AS listen_date,
        SUM(listening_minutes) AS daily_minutes
    FROM spotify
    GROUP BY CAST(event_time AS DATE)
) t;

--Q4.Who are my top 10 artists by total listening time?
SELECT TOP 10
    artist,
    round(SUM(listening_minutes) / 60.0,2) AS listening_hours
FROM spotify
GROUP BY artist
ORDER BY listening_hours DESC;

--Q5.What percentage of my listening is dominated by my top 5 artists?
WITH artist_hours AS (
    SELECT 
        artist,
        SUM(listening_minutes) AS minutes
    FROM spotify
    GROUP BY artist
),
totals AS (
    SELECT SUM(minutes) AS total_minutes FROM artist_hours
)
SELECT 
    round(SUM(CASE WHEN rank_num <= 5 THEN minutes ELSE 0 END) * 100.0/ 
    (SELECT total_minutes FROM totals),2) AS top_5_artist_percentage
FROM (
    SELECT *,
           RANK() OVER (ORDER BY minutes DESC) AS rank_num
    FROM artist_hours
)r;

--Q6.How diverse is my music taste over time (unique artists per year)?
SELECT 
    year,
    COUNT(DISTINCT artist) AS unique_artists
FROM spotify
GROUP BY year
ORDER BY year;

--Q7.Which device category do I use the most?
SELECT 
    device_type,
    round(SUM(listening_minutes) / 60.0,2) AS listening_hours
FROM spotify
GROUP BY device_type
ORDER BY listening_hours DESC;

--Q8.How has my device usage changed over the years?
SELECT 
    year,
    device_type,
    round(SUM(listening_minutes) / 60.0,2) AS listening_hours
FROM spotify
GROUP BY year, device_type
ORDER BY year, listening_hours DESC;

--Q9.Do I use different devices at different times of the day?
SELECT 
    hour,
    device_type,
    round(SUM(listening_minutes),2) AS total_minutes
FROM spotify
GROUP BY hour, device_type
ORDER BY hour;

--Q10.What time of day do I listen the most?
SELECT 
    hour,
    round(SUM(listening_minutes),2) AS total_minutes
FROM spotify
GROUP BY hour
ORDER BY total_minutes DESC;

--Q11.Weekday vs Weekend listening behaviour
SELECT 
    CASE 
        WHEN DATENAME(WEEKDAY, event_time) IN ('Saturday', 'Sunday')
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    round(SUM(listening_minutes) / 60.0,2) AS listening_hours
FROM spotify
GROUP BY 
    CASE 
        WHEN DATENAME(WEEKDAY, event_time) IN ('Saturday', 'Sunday')
        THEN 'Weekend'
        ELSE 'Weekday'
    END;

--Q12.Which tracks do I replay the most?
SELECT TOP 10
    track,
    artist,
    COUNT(*) AS play_count
FROM spotify
GROUP BY track, artist
ORDER BY play_count DESC;

--Q13.Which tracks do I spend the most time listening to?
SELECT TOP 10
    track,
    artist,
    round(SUM(listening_minutes),2) AS total_minutes
FROM spotify
GROUP BY track, artist
ORDER BY total_minutes DESC;

--Q14.What is my most common listening hour for each device?
SELECT *
FROM (
    SELECT 
        device_type,
        hour,
        round(SUM(listening_minutes),2) AS total_minutes,
        RANK() OVER (PARTITION BY device_type ORDER BY SUM(listening_minutes) DESC) AS rnk
    FROM spotify
    GROUP BY device_type, hour
) t
WHERE rnk = 1;

--Q15.Am I more "picky" (skipping more) in the morning or the evening?
SELECT 
    day_part,
    COUNT(*) AS total_listens,
    SUM(CASE WHEN skipped = 1 THEN 1 ELSE 0 END) AS total_skips,
    ROUND(CAST(SUM(CASE WHEN skipped = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2) AS skip_percentage
FROM spotify
GROUP BY day_part
ORDER BY skip_percentage DESC;


GO

CREATE OR ALTER VIEW Spotify_Final_Dataset AS
SELECT 
    s.*, 
    s.track AS track_clean, 
    m.genres,
    m.artist_image,
    m.popularity,
    t.album_cover,
    t.album_name
FROM [spotify] s
LEFT JOIN artist_metadata m 
    ON TRIM(s.artist) = TRIM(m.artist)
LEFT JOIN track_metadata t
    ON TRIM(s.track) = TRIM(t.track) 
    AND TRIM(s.artist) = TRIM(t.artist);

GO
SELECT TOP 10 * FROM artist_metadata;

SELECT 
    COUNT(DISTINCT artist) AS unique_artist_count
FROM spotify;
