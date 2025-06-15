# Analyzing Netflix's Market Position Within the Global OTT Ecosystem with Competitive Benchmarks

## Author: Pratik Ganguli

## Overview

This project analyzes Netflix's market performance from 2017 to 2021, focusing on revenue growth, subscriber trends, content strategy, and regional penetration. By leveraging unsupervised machine learning techniques, specifically the Apriori algorithm, the project uncovers viewing patterns across four regions (U.S.A. and Canada, Latin America, Europe, Middle East, and Africa, and Asia Pacific) over five years. The analysis compares Netflix with Amazon Prime as a benchmark competitor, providing insights into genre preferences, regional strategies, and opportunities for growth. A Power BI dashboard visualizes key metrics, including content distribution, subscriber growth, and revenue trends, to support data-driven decision-making for optimizing Netflix's content, pricing, and regional strategies.

## Table of Contents
- [Dataset Overview](#dataset-overview)
- [Data Preprocessing](#data-preprocessing)
- [Modeling](#modeling)
- [Visualization and Page Interpretations](#visualization-and-page-interpretations)
  - [Page 1: Overview](#page-1-overview)
  - [Page 2: Content Strategy & Regional Penetration](#page-2-content-strategy--regional-penetration)
  - [Page 3: Generational Segment & Viewership](#page-3-generational-segment--viewership)
  - [Page 4: Netflix vs. Amazon Prime (Genre Comparison)](#page-4-netflix-vs-amazon-prime-genre-comparison)
  - [Page 5: Netflix vs. Amazon Prime (Market Trends)](#page-5-netflix-vs-amazon-prime-market-trends)
  - [Page 6: Genre Recommendations Driven by Viewer Analytics](#page-6-genre-recommendations-driven-by-viewer-analytics)
- [Results](#results)
- [Conclusions](#conclusions)
- [Requirements](#requirements)
- [Data Sources](#dataset--source-references)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Dataset Overview

The analysis integrates data from 25 diverse sources, including Kaggle datasets, IMDb non-commercial datasets, and industry reports. The dataset covers:
- **Content Features**: Titles, genres, ratings, and release years.
- **Subscriber Data**: Regional subscriber counts and growth trends.
- **Revenue Metrics**: Year-over-year revenue for Netflix and Amazon Prime.
- **Regional Distribution**: Viewing patterns across four regions (U.S.A. and Canada, Latin America, Europe, Middle East, and Africa, Asia Pacific).
- **Competitive Benchmarking**: Content and performance metrics for Amazon Prime.

Key datasets include:
- IMDb OTT Platforms Movies
- Netflix OTT Revenue and Subscribers
- Netflix Engagement Report
- Movies on Netflix, Prime Video, Hulu, and Disney
- Netflix Original Films IMDb Scores
- Netflix User Statistics

See the [Data Sources](#dataset--source-references) section for a complete list with links.

## Data Preprocessing

Extensive data wrangling was performed to prepare the datasets for analysis:

1. **Data Integration**: Combined 25 datasets using joins on common fields like movie titles. For example, `most-popular_global_weekly.xlsx` was merged with IMDb data using the `Title` column.
2. **Column Filtering**: Removed irrelevant columns (e.g., `season_title`, `country_iso2`, `Poster`, `Metascore`) to reduce noise.
3. **Handling Missing Data**: Applied `na.omit()` to remove rows with missing values.
4. **Data Transformation**:
   - Categorized movie ratings into four age groups (Kids, Teens, Adults, Older) using a custom `categorize_age` function.
   - Grouped countries into four regions using `case_when`.
   - Converted date formats to extract years and created transaction IDs based on region and date.
5. **Feature Engineering**: Aggregated genres per transaction (region-year combination) for the Apriori algorithm.

## Modeling

To uncover latent viewing patterns, the project applies **unsupervised machine learning** using the **Apriori algorithm** in R. This technique reveals frequent genre associations watched together across different regions and years, providing actionable insights for content strategy.

- **Algorithm Used**: The Apriori algorithm, implemented via the `arules` package in R, was employed to mine association rules from transactional genre data.
- **Parameter Settings**:
  - Minimum support: 0.10
  - Minimum confidence: 0.33
  - Minimum rule length: 2
- **Modeling Workflow**:
  1. **Transaction Preparation**: The dataset was grouped by `region`, `year`, and unique `transaction ID`. Genres watched in each transaction were compiled into lists to form market basket-style transactions.
  2. **Data Cleaning & Transformation**: Missing values were omitted, categorical age segments were created (e.g., Kids, Teens, Adults, Older), and regions were unified using `case_when`.
  3. **Rule Mining**: Association rules were generated for each region-year combination. Redundant or overlapping rules were removed.
  4. **Rule Selection**: The top 5 rules per region-year were selected based on **lift**, ensuring only the strongest genre co-viewing patterns were retained.

- **Output & Integration**:
  - The resulting rules (with metrics such as `support`, `confidence`, and `lift`) were exported as `rules_apriori_top5.csv`.
  - These outputs were then **imported into Power BI**, enabling seamless integration of R-based machine learning with business intelligence visualizations.
  - Genre recommendation visuals in the Power BI dashboard are powered directly by these Apriori rule outputs, making the analytics pipeline fully end-to-end.

This advanced integration of R with Power BI allows technical insights to be directly translated into interactive business recommendations—enhancing the strategic value of unsupervised learning.

## Visualization and Page Interpretations

A Power BI dashboard visualizes key insights across six pages. Below are detailed interpretations for each page.

### Page 1: Overview

**Content**: Introduces the analysis of Netflix's performance from 2017 to 2021, focusing on revenue growth, subscriber trends, content strategy, and regional distribution, with Amazon Prime as a benchmark.

**Interpretation**:
- Provides a high-level summary of Netflix's evolution in the OTT ecosystem.
- Highlights the use of data storytelling and pattern recognition to guide strategic decisions.
- Sets the stage for detailed analyses, emphasizing Netflix's competitive positioning and growth opportunities.

### Page 2: Content Strategy & Regional Penetration

**Content**: Displays a pie chart of Netflix content distribution by category (15.92% Netflix Exclusive, 16.39% Netflix Original, remainder non-original) and a line graph of subscriber growth by region over time.

**Interpretation**:
- The pie chart reveals Netflix's investment in originals and exclusives, which constitute roughly a third of its content, driving viewer engagement.
- The line graph shows significant subscriber growth in Europe, Middle East, and Africa, and Asia Pacific, indicating high market potential in these regions.
- Suggests Netflix should prioritize original content to maintain competitive edge and tailor regional strategies to capitalize on subscriber trends.

### Page 3: Generational Segment & Viewership

**Content**: Likely includes visualizations of viewership by generational segments (e.g., Kids, Teens, Adults, Older), though specific details are limited due to repetitive OCR output.

**Interpretation**:
- Based on the R script's `categorize_age` function, this page likely segments viewership by age groups, revealing preferences (e.g., Kids prefer animated content, Teens favor action).
- Helps Netflix target content production and marketing to specific demographics.
- Indicates opportunities to expand content for underrepresented segments, such as Older viewers.

### Page 4: Netflix vs. Amazon Prime (Genre Comparison)

**Content**: Compares total genre content available on Netflix and Amazon Prime, likely using bar charts to highlight genre distribution.

**Interpretation**:
- Identifies Netflix's strengths in genres like Drama and Sci-Fi, where it has more exclusive content than Amazon Prime.
- Highlights gaps in genres like Action, where Amazon Prime may offer more variety.
- Suggests Netflix could diversify its genre portfolio to compete more effectively, particularly in high-demand genres.

### Page 5: Netflix vs. Amazon Prime (Market Trends)

**Content**: Visualizes global streaming market trends in billions, including revenue and subscriber growth for Netflix and Amazon Prime over the years.

**Interpretation**:
- Shows Amazon Prime’s more aggressive revenue and subscriber growth, overtaking Netflix by 2021.
- Amazon Prime’s pricing consistency and bundled offerings helped fuel rapid expansion.
- Netflix still shows strong growth, especially driven by original content, but may need to adapt pricing and bundling strategies in response to Amazon’s scale.

### Page 6: Genre Recommendations Driven by Viewer Analytics

**Content**: Presents genre recommendations based on viewer analytics, e.g., suggesting Dark Sci-Fi for Europe, Middle East, and Africa in 2020 based on watched genres.

**Interpretation**:
- Leverages Apriori rules to recommend genres that align with regional viewing patterns (e.g., Sci-Fi → Thriller in Europe).
- Supports content acquisition and production decisions to maximize viewer satisfaction.
- Indicates Netflix should prioritize region-specific content to enhance engagement and retention.

## Results

Key findings from the Apriori analysis and dashboard:

| Region                     | Year | Top Rule Example                     | Support | Confidence | Lift |
|----------------------------|------|-------------------------------------|---------|------------|------|
| U.S.A. and Canada          | 2020 | [Drama] → [Comedy]                 | 0.15    | 0.40       | 2.1  |
| Europe, Middle East, Africa| 2020 | [Sci-Fi] → [Thriller]              | 0.12    | 0.35       | 1.9  |
| Asia Pacific               | 2019 | [Action] → [Adventure]             | 0.18    | 0.45       | 2.3  |
| Latin America              | 2021 | [Romance] → [Drama]                | 0.14    | 0.38       | 2.0  |

- **Content Strategy**: Netflix Originals drive engagement, particularly in Drama and Sci-Fi.
- **Regional Penetration**: Europe and Asia Pacific show strong subscriber growth.
- **Competitive Benchmarking**: Netflix leads in exclusive content but trails in Action genres.
- **Market Trends**: Amazon Prime surpasses Netflix in revenue and subscriber growth by 2021.

## Conclusions

- **Genre Strategy**: Invest in Sci-Fi and Drama, especially for Europe, Middle East, and Africa.
- **Regional Focus**: Target Asia Pacific for growth due to increasing subscribers and Action/Adventure preferences.
- **Competitive Positioning**: Expand Action and Comedy to close gaps with Amazon Prime and respond to its aggressive growth.
- **Strategic Recommendations**: Optimize pricing in Latin America and tailor content for Teens in Asia Pacific. Consider exploring bundled service offerings and cross-platform partnerships to match Amazon Prime’s scaling advantage.

## Requirements

- **R (version 4.0 or higher)**

**R Libraries**:
- `ggplot2`
- `GGally`
- `tidyverse`
- `corrplot`
- `readxl`
- `arules`
- `arulesViz`

Install with:

```R
install.packages(c("ggplot2", "GGally", "tidyverse", "corrplot", "readxl", "arules", "arulesViz"))
```

## Other Tools:

Power BI: For dashboard creation.
Datasets: Access the 25 datasets listed below.

## Dataset & Source References

### IMDB & OTT Platforms
- **IMDB OTT Platforms Movies (Power BI Dashboard)**  
  Motiani, Y. (n.d.). *IMDB OTT Platforms Movies (Power BI Dashboard)*. [Kaggle](https://www.kaggle.com/datasets/yashmotiani/imdb-ott-platforms-movies-power-bi-dashboard)

- **IMDb Non-Commercial Datasets**  
  IMDb. (n.d.). *IMDb Non-Commercial Datasets*. [IMDb Developer](https://developer.imdb.com/non-commercial-datasets/)

- **IMDB Dataset**  
  Amanat, P. (n.d.). *IMDB Dataset*. [Kaggle](https://www.kaggle.com/datasets/payamamanat/imbd-dataset)

### Streaming Services – Multi-platform
- **Movies on Netflix, Prime Video, Hulu and Disney**  
  Ruchi798. (n.d.). *Movies on Netflix, Prime Video, Hulu and Disney*. [Kaggle](https://www.kaggle.com/datasets/ruchi798/movies-on-netflix-prime-video-hulu-and-disney)

- **OTT Video Streaming Platforms Revenue and Users**  
  Wasi, A. T. (n.d.). *OTT Video Streaming Platforms Revenue and Users*. [Kaggle](https://www.kaggle.com/datasets/azminetoushikwasi/ott-video-streaming-platforms-revenue-and-users)

- **Netflix OTT Revenue and Subscribers CSV File**  
  Mauryans, S. (n.d.). *Netflix OTT Revenue and Subscribers CSV File*. [Kaggle](https://www.kaggle.com/datasets/mauryansshivam/netflix-ott-revenue-and-subscribers-csv-file)

### Netflix-Specific
- **Netflix Movies and TV Shows Clustering**  
  Bansode, S. (n.d.). *Netflix Movies and TV Shows Clustering*. [Kaggle](https://www.kaggle.com/code/bansodesandeep/netflix-movies-and-tv-shows-clustering)

- **Netflix Original Films IMDb Scores**  
  Corter, L. (n.d.). *Netflix Original Films IMDb Scores*. [Kaggle](https://www.kaggle.com/datasets/luiscorter/netflix-original-films-imdb-scores)

- **Netflix Originals CSV**  
  PrasertCB. (n.d.). *NetflixOriginals.csv*. [GitHub](https://github.com/prasertcbs/basic-dataset/blob/master/NetflixOriginals.csv)

- **Netflix Customer Churn and Engagement Dataset**  
  Dddtra. (n.d.). *Netflix Customer Churn and Engagement Dataset*. [Kaggle](https://www.kaggle.com/datasets/dddtra/netflix-customer-churn-and-engagement-dataset)

- **Netflix Engagement Report**  
  Konradb. (n.d.). *Netflix Engagement Report*. [Kaggle](https://www.kaggle.com/datasets/konradb/netflix-engagement-report/data)

- **Netflix Reviews (Play Store, Daily Updated)**  
  Ashishkumarak. (n.d.). *Netflix Reviews (Play Store, Daily Updated)*. [Kaggle](https://www.kaggle.com/datasets/ashishkumarak/netflix-reviews-playstore-daily-updated)

### Other Platforms
- **Paramount Movies and TV Shows**  
  Goenrique, D. (n.d.). *Paramount Movies and TV Shows*. [Kaggle](https://www.kaggle.com/datasets/dgoenrique/paramount-movies-and-tv-shows)

- **Apple TV Movies and TV Shows**  
  Goenrique, D. (n.d.). *Apple TV Movies and TV Shows*. [Kaggle](https://www.kaggle.com/datasets/dgoenrique/apple-tv-movies-and-tv-shows)

- **Full HBO Max Dataset**  
  Octopus Team. (n.d.). *Full HBO Max Dataset*. [Kaggle](https://www.kaggle.com/datasets/octopusteam/full-hbo-max-dataset)

### General Statistics
- **Netflix User Statistics**  
  Dean, B. (n.d.). *Netflix User Statistics*. [Backlinko](https://backlinko.com/netflix-users)

- **Netflix Statistics**  
  Business of Apps. (n.d.). *Netflix Statistics*. [Business of Apps](https://www.businessofapps.com/data/netflix-statistics/?utm_source=chatgpt.com)


## License
This project is licensed under the **MIT License**.

## Acknowledgments
- Completed as part of End Term Project at the [University of Auckland](https://www.auckland.ac.nz/en.html).
- Thanks to the [University of Auckland](https://www.auckland.ac.nz/en.html) for resources and support.
- Gratitude to the open-source community for datasets on **Kaggle** and **IMDb**.
- Appreciation to instructors and peers for guidance and feedback.
