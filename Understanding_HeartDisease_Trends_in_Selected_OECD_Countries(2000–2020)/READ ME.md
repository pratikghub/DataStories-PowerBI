# Understanding Heart Disease Trends in Selected OECD Countries (2000–2020)

**Author**: Pratik Ganguli

## Overview

This project delivers an in-depth analysis of heart disease trends in **a selected group of OECD countries** between 2000 and 2020, using five-year benchmark intervals (2000, 2005, 2010, 2015, 2020). The analysis focuses on:

- Mortality rates and Potential Years of Life Lost (PYLL)
- Lifestyle risk factors (alcohol, tobacco use, body weight)
- Healthcare access (physician density, insurance coverage)
- Socio-economic drivers (government spending, regional disparities)

Aligned with **Sustainable Development Goal 3: Good Health and Well-being**, this project offers insights to support policies aimed at reducing premature deaths and health inequities.

Data from **OECD Health Statistics** was cleaned, modeled, and visualized through an interactive **Power BI dashboard**. Despite minor OCR-related limitations during PDF exports, the dashboard provides robust insights across countries and decades.

---

## Table of Contents

- [Dataset Overview](#dataset-overview)  
- [Data Preparation, Wrangling & Modeling](#data-preparation-wrangling--modeling)  
- [Visualization and Page Interpretations](#visualization-and-page-interpretations)  
- [Results](#results)  
- [Conclusions](#conclusions)  
- [Requirements](#requirements)  
- [Data Sources](#data-sources)  
- [License](#license)  
- [Acknowledgments](#acknowledgments)

---

## Dataset Overview

This project draws from **10–15 datasets** accessed via the **OECD Health Statistics portal**, covering **only those OECD countries specifically mentioned and visualized in the dashboard**, not all 38 members. Key variables include:

### Health Metrics
- Mortality rates (acute myocardial infarction, ischemic heart disease)
- PYLL (per 100,000)
- Alcohol consumption (liters per person)
- Tobacco consumption (e.g., cigarettes per capita)
- Body weight (BMI categories)
- Healthcare coverage and utilization
- Food supply metrics (e.g., caloric intake)

### Socio-Economic Metrics
- Government health expenditure (via GOFOG)
- Physician availability (regional breakdowns, per 1,000 population)

### SDG Indicators
- Metrics from **Sustainable Development Goal 3** on preventable mortality and healthcare equity

> OCR-related issues affected some fields during Power BI PDF export, but core metric trends and country-level comparisons remain valid and insightful.

---

## Data Preparation, Wrangling & Modeling

A **high-quality, intensive data preparation process** was conducted entirely within **Power BI**, involving both automated and manual techniques to transform, cleanse, and model the data.

### Integration & Cleaning
- Combined multiple datasets using **country ISO codes** and **five-year benchmark intervals**.
- Standardized definitions and formats across disparate sources for consistency.

### High-Quality Imputation
- Missing values were handled using **benchmark-year-based logic**:
  - If data for a given year (e.g., 2005) was unavailable, values were **imputed from the next or previous benchmark year** (e.g., 2000 or 2010) based on temporal proximity and trend integrity.
- Used **if-then logic**, **pivot/unpivot transformations**, and **merge/append queries** to maintain structural consistency.

### Data Transformation
- Corrected OCR anomalies (e.g., alcohol values showing as “10.1” for all countries).
- Standardized data units (e.g., mortality per 100,000 population).
- Categorized and cleaned BMI data, tobacco usage, and alcohol consumption to enable cross-country comparisons.

### Star Schema Modeling
- Constructed a **robust star schema** to support dynamic, drill-down capabilities in Power BI:
  - **Fact Table**: Heart disease-related health outcomes by year and country
  - **Dimension Tables**: Country metadata, lifestyle factors, healthcare metrics, policy spending

### Validation
- Final values were compared against official OECD reports for accuracy.
- Anomalous entries flagged during OCR exports were reviewed manually and corrected when necessary.

> This rigorous data modeling approach enabled smooth, scalable dashboard functionality and ensured the integrity of analytical outputs across years and dimensions.

---

## Visualization and Page Interpretations

The **Power BI dashboard** consists of six core pages, each designed for thematic storytelling and analytical depth:

### Page 1: Project Overview
- Introduces heart disease trends
- Highlights focus areas: mortality, lifestyle risks, access to care
- States data sources and benchmark years

### Page 2: Analyzed Factors
- Maps key variables: mortality causes, alcohol/tobacco use, BMI, coverage, physician availability, and SDG 3 indicators

### Page 3: Prevalence & Mortality
- Total deaths (2000–2020): **2.56 million**
- Average mortality: **132.6 per 100K**
- PYLL: **776.5 per 100K**
- Cross-country and temporal trends visualized through bar and line charts

### Page 4: Lifestyle Determinants
- Compares five selected countries on alcohol use, tobacco use, and body weight
- Despite OCR errors, insights on regional risk factor disparities are preserved

### Page 5: Healthcare Access
- Shows changes in physician density across countries
- Highlights gaps in access between countries and over time

### Page 6: Healthcare Access (Continued)
- Further explores coverage and regional physician distributions
- Some repetitive or garbled year labels acknowledged due to export errors

---

## Results

| **Metric**              | **Finding**                                                 |
|-------------------------|-------------------------------------------------------------|
| Total Deaths            | 2.56 million (2000–2020), with a consistent decline         |
| Mortality Rate          | 132.6 per 100K on average; declines significantly after 2010|
| PYLL                    | 776.5 per 100K; high early mortality remains a concern      |
| Lifestyle Determinants  | Alcohol, tobacco, and obesity strongly linked to mortality  |
| Healthcare Access       | Physician availability has improved, but disparities persist|
| Socio-Economic Drivers  | Higher spending correlates with better heart health outcomes|

---

## Conclusions

### Recommended Interventions

#### 1. Lifestyle Reform
- Reduce alcohol use to under **7 liters/person/year**
- Limit tobacco use to under **1,000 cigarettes/year**
- Support national obesity-reduction campaigns

#### 2. Expand Healthcare Access
- Increase physician training and deployment in underserved regions
- Expand insurance coverage and preventive care access

#### 3. Policy & Investment
- Align policies with **SDG 3** to reduce preventable mortality
- Increase health spending by **5–10%** in underperforming countries

#### 4. Data Quality Enhancements
- Strengthen lifestyle metric collection methodologies
- Improve export tools to eliminate OCR-based data loss

**2030 Target**:  
- ↓ PYLL by **20%**  
- ↓ Mortality by **10%**

---

## Requirements

### Tools Used
- **Power BI Desktop** (latest version)
- **Web scraping connectors within Power BI** (OECD public data portals)

### Hardware
- Recommended: **16 GB RAM**, modern CPU
- Minimum: **8 GB RAM**, 4-core CPU

---

## Data Sources

- [OECD Health Statistics](https://www.oecd.org/health/)
- [GOFOG – Government Expenditure by Function](https://data.oecd.org/gga/general-government-spending.htm)
- [SDG 3 Indicators – UN](https://sdgs.un.org/goals/goal3)
- [OECD Regional Statistics](https://stats.oecd.org/)

---

## License

This project is licensed under the **MIT License**.

---

## Acknowledgments

- Thanks to the **OECD** for making comprehensive health datasets publicly accessible.
- Developed as part of an academic and analytical exploration in public health and policy at the [University of Auckland](https://www.auckland.ac.nz/en.html).
