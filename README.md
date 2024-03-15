---
title: "Investigating the influence of genre preferences on movie/series rating patterns over time"
---

## Research Motivation
The entertainment industry is a dynamic industry. Consumer preferences continuously change, and new movies and series are continuously being produced. Genre continues to be an important topic in the entertainment industry. Genre preferences indicate what consumers liked to watch in the past, and therefore probably also would like to watch in the future. Thus, genre can serve as a selection criteria, based on which consumers decide whether to watch a certain movie or not. Therefore, an understanding of genre preferences gives movie producers a direction on what type of genre they should adopt to increase chances of success and to best deliver the message they want to bring across. Consequently, it is important to investigate the evolution of consumers’ genre preferences over time, which will be done in the current repository. 

## Method and results
This repository investigates what the influence of consumers' genre preference is on the ratings consumers give movies and series over time. This is done using five datasets containing movie data. First, these datasets are merged, inspected, and cleaned. Next, the data is analyzed  using regression analysis. Consumers' movie/serie ratings (averageRatings) serve as the dependent variable. Consequently, the explanatory variables are regressed on averageRatings. The explanatory variables are: 

* Genre
* Series vs Movies 
* Running Time 
* Director 
* Adult title vs non-adult title
* Date

To improve the reliability of our results, a cut off based on the number of votes on the movies and series will be used. Since the dependent variable is *average* ratings, movies/series with only a few votes may receive more extreme average ratings. This can be the case because each rating, including the extreme ones, receives more weight when calculating the average, simply because there are only a few ratings. So, the average ratings may be more extreme, causing to skew the overall results. Therefore, movies/series receiving a number of votes that are below the cut off won't be included in the regression analysis. 

## Repository overview

├── data
├── gen
│   ├── analysis
│   │   ├── input
│   │   ├── output
│   │   │   ├── figure
│   │   │   ├── log
│   │   │   └── table
│   │   └── temp
│   ├── data_preparation
│   │   ├── audit
│   │   │   ├── figure
│   │   │   ├── log
│   │   │   └── table
│   │   ├── input
│   │   ├── output
│   │   │   ├── figure
│   │   │   ├── log
│   │   │   └── table
│   │   └── temp
│   └── paper
└── src
    ├── analysis
    ├── Getting_the_Data
    └── Data_Prep
    
* gen: all generated files such as tables, figures, logs.
  - Three parts: data_preparation, analysis, and paper.
  - audit: put the resulting log/tables/figures of audit program. It has three sub-folders: figure, log, and table.
  - temp : put the temporary files, such as some intermediate datasets. We may delete these filed in the end.
  - output: put results, including the generated figures in sub-folder figure, log files in sub-folder log, and tables in sub-folder table.
  - input: put all temporary input files
* data: all raw data.
* src: all source codes.
  -Three parts: Getting_the_Data, Data_Prep, and analysis.

## How to get started

## How to run the Workflow
Open your command line tool:

* Check whether your present working directory is xyz-workflow by typing pwd in terminal
  if not, type cd yourpath/xyz to change your directory to xyz
* Type make in the command line.

## Authors
Timo Philipse            timophilipse 
Bram Teunissen           bwg_teunissen
Rodrigo Pačeko Rudzājs   rprudzajs
Dian de Ridder           Ciertje
Linda van den Boogaart   lindavdboogaart 	
