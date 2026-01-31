# 🎲 Board Game Popularity & Rating Analysis

📌 Project Overview
This project performs an end-to-end data analysis of the board game industry using the BoardGameGeek dataset. The goal is to identify the key factors that influence a board game’s popularity, ratings, complexity, and long-term success through structured SQL analysis and Python-based exploration.

🎯 Objectives

Analyze factors that define successful and popular board games
Study industry trends across release years, player count, playtime, and complexity
Identify evergreen classic games and modern high-performing titles
Understand the relationship between ratings, complexity, ownership, and fanbase

🛠️ Tech Stack

SQL – Data storage, cleaning, validation, and analysis
Python – Data analysis and visualization
Libraries: Pandas, NumPy, Matplotlib
Database Connectivity: pyodbc
Environment: Jupyter Notebook

🔄 Methodology

Loaded the BoardGameGeek dataset into a SQL database
Performed data validation to remove duplicates and logical inconsistencies
Handled missing and erroneous values using mean imputation
Engineered new features such as player range and playtime range
Executed analytical SQL queries to uncover industry patterns
Used Python to perform statistical analysis and create visualizations

📊 Key Insights

The board game industry has grown rapidly, especially after 2015
Games with higher complexity generally receive higher ratings
Highly rated games attract larger ownership and fanbases
4-player games are the most common and best-rated format
Several pre-2010 games remain evergreen classics with lasting popularity

📁 Repository Structure
├── SQL Queries/
│   └── 1st.sql
├── Python Analysis/
│   └── boardgame.ipynb
├── Dataset/
│   └── boardgame-geek-dataset.csv
└── README.md

✅ Conclusion
The analysis shows that the modern board game market is both growing and evolving. Quality game design, reflected through higher ratings, plays a critical role in long-term success, while both complex strategy games and simple gateway games continue to thrive.
