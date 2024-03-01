#Did you see this?!
##Consumer movie and series rating pattens over time 

* insert some image


## Introduction
This repository analyses consumer behaviour pattern on movie and serie ratings. The achieve this goal the exploratory variables (), are regressed on the Outcome variable (averageRatings). 

DV  averageRating   The mean rating determined by the number of votes (numVotes)
IV  genre           The categorical variable that determines the type of genre of movie ** m **  or serie ** s ** 

Genre			(Dummy)
Series vs. Movies 	(Dummy)
Running Time	        (Dummy)
Director		(Dummy)
Adult 			(Dummy) 
Region		        (Dummy)
Date			(Continuous String)

If movie > running time (Conditional Dummy)
if series > number of season and episodes
```
Lastly, we add general filters: First off, we'll only be looking at English movies and series, with their original title. Second off, we will have a cut off based on the number of votes on the movies and series. So, if the movie or serie has to little votes it will be cut out.

Perhaps the trend changed over time from, different running time lengths in movies or episodes of a serie, maybe the genre changed from horror to romantical.

## Research Motivation

## How to get started


## How to run the Workflow
Open your command line tool:

* Check whether your present working directory is xyz-workflow by typing pwd in terminal
  if not, type cd yourpath/xyz to change your directory to xyz
* Type make in the command line.

## Directory Structure
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
│       ├── input
│       ├── output
│       └── temp
└── src
    ├── analysis
    ├── data_preparation
    └── paper
    
* gen: all generated files such as tables, figures, logs.
  - Three parts: data_preparation, analysis, and paper.
  - audit: put the resulting log/tables/figures of audit program. It has three sub-folders: figure, log, and table.
  - temp : put the temporary files, such as some intermediate datasets. We may delete these filed in the end.
  - output: put results, including the generated figures in sub-folder figure, log files in sub-folder log, and tables in sub-folder table.
  - input: put all temporary input files
* data: all raw data.
* src: all source codes.
  -Three parts: data_preparation, analysis, and paper (including tex files).

## Authors
Timo Phillipse           
Bram Teunissen           bwg-teunissen
Rodrigo Pačeko Rudzājs   
Dian de Ridder           Ciertje
Linda van den Boogaar     	