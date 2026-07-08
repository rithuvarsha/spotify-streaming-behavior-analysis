# spotify-streaming-behavior-analysis

This project demonstrates a complete analytics workflow using **Python**, **Spotify Web API**, **SQL Server**, and **Power BI**, transforming raw JSON streaming logs into meaningful business insights through data cleaning, feature engineering, analytical querying, and interactive dashboard development.
The project follows a complete Data Analytics Workflow:
Python → Spotify Web API → SQL Server → Power BI

1. Project Overview
The objective of this project was to analyze personal Spotify streaming history and identify meaningful behavioral patterns in music consumption. Using Spotify's Extended Streaming History, the project investigates:
- Listening habits and engagement trends
- Artist and album preferences
- Music discovery patterns
- Device usage behavior
- Time-based listening activity
- Replay and skip behavior
  
2. Dataset Summary -
  **Source:** Spotify Extended Streaming History (JSON)
  ### Initial Dataset
  - **35,625** streaming events
  - **23** metadata fields

  ### Data Preparation
  The dataset was cleaned and standardized by:
  - Removing **57** incomplete records containing missing values in essential fields
  - Removing podcast and audiobook-related columns with predominantly null values
  - Converting timestamps into **DateTime**
  - Standardizing platform names into device categories
  - Engineering analytical features for behavioral analysis
  
  ### Engineered Features
  - Year
  - Month
  - Day of Week
  - Hour
  - Listening Minutes
  - Device Type
  - Day Part
  - Season
  - Is Weekend
    
  Final dataset:
  - **35,568 streaming records**
  - **23 refined columns**

3. Exploratory Data Analysis (EDA)
   Python was used to prepare the raw streaming logs for analysis.
   ### Key preprocessing tasks included:
   - Missing value treatment
   - Column standardization
   - Timestamp conversion
   - Platform standardization
   - Feature engineering
   - Data validation
   The cleaned dataset provided a reliable foundation for downstream SQL analysis and dashboard development.

4. Spotify Web API Enrichment
   The Spotify Web API was integrated to enrich the streaming history with additional artist metadata.
   Metadata retrieved included:
   - Artist Genres
   - Artist Popularity
   - Album Artwork
   This enrichment enabled deeper analysis of musical preferences and significantly improved dashboard storytelling.

5. SQL Based Analysis
   A total of **15 SQL queries** were developed to explore listening behavior from multiple analytical perspectives.
   - Key Findings:
     1. Total Listening Time
        A total of approximately 1,979 hours were spent listening to Spotify between 2022 and 2025, indicating consistent long-term engagement with the platform.
     2. Year-over-Year Listening Trend
        Annual listening hours remained relatively stable with gradual growth over the years, reflecting consistent music consumption habits.
     3. Average Daily Listening Time
        The average daily listening time was approximately 105 minutes, suggesting Spotify is a regular part of daily routines.
     4. Top 10 Artists
        A small group of artists accounted for the highest listening hours, highlighting strong preferences for specific musicians.
     5. Top 5 Artist Dominance
        The top five artists contributed a significant percentage of total listening time, indicating concentrated listening around favorite artists while still exploring others.
     6. Artist Diversity Over Time
        The number of unique artists listened to per year shows gradual variation, suggesting a balance between discovering new artists and revisiting familiar ones.
     7. Device Usage
        Mobile devices accounted for the largest share of listening time, indicating a preference for listening on the go.
     8. Device Usage Trend
        Device preferences remained relatively consistent across the years, with mobile devices dominating listening activity throughout the analysis period.
     9. Device Usage by Time of Day
         Different devices were used at different times of the day, suggesting listening habits vary based on daily activities and context.
     10. Peak Listening Hours
         Listening activity peaked during specific hours of the day, revealing the user's preferred periods for music consumption.
     11. Weekday vs Weekend Behavior
         Listening hours are higher during weekends, suggesting Spotify is used more extensively during leisure time compared to workdays.
     12. Most Replayed Tracks
         Replay analysis shows that certain tracks are played repeatedly, reflecting strong emotional or habitual attachment to specific songs.
     13. Tracks with Highest Listening Time
         The songs with the highest accumulated listening minutes represented tracks that maintained long-term engagement rather than one-time popularity.
     14. Most Common Listening Hour by Device
         Each device category exhibits a distinct peak listening hour, reinforcing the idea that listening behavior varies based on context and device availability.
     15. Skip Behavior by Time of Day
         Skip rate analysis shows higher skipping during certain parts of the day, suggesting more distracted or passive listening during those periods.

6. Power BI Dashboard
   Key Insights
   - Total listening exceeded **1,900 hours** across the analysis period.
   - More than **1,900 unique artists** were streamed.
   - Mobile devices accounted for the largest share of listening activity.
   - Listening remained consistent across multiple years with gradual growth.
   - Morning and evening emerged as the most active listening periods.
   - A small group of artists contributed a significant proportion of total listening time.
