# Investigating the influence of genre preferences on movie/series rating patterns over time

## Research Motivation

The entertainment industry is highly dynamic. Consumer preferences keep changing, and new movies and series are produced regularly. These changes in preferences require the industry to respond accordingly. For
example, showing an ankle in a movie might have been considered scandalous in the 1950s, but it is now just a minor detail. To make an impact in such an ever-evolving industry, movie directors need to get creative. These changes in the industry influence how movies and series are produced and how consumers react to them. One way to understand these patterns is by examining the genre of a product. 

Genre preferences reflect what consumers have enjoyed watching in the past, and hence are likely to enjoy in the future. Therefore, genre can be used as a criterion for selecting productions, based on which consumers decide whether to watch a particular production or not. An understanding of genre preferences provides filmmakers with guidance on which genre to choose to increase the chances of success and to best
convey their intended message. However, the nature of genres is constantly evolving, and it is important to comprehend how current consumers respond to the evolution of a genre over time. For instance, an action movie today might have rapid scene changes, multiple plot twists, and lengthy fight scenes, but on average, such movies may only receive moderate ratings at best. In contrast, action movies from two decades ago had a more gradual plot development and were less overwhelming, yet they received a higher average rating. When consumers rely on the genre productions of the past to make their choice, it may adversely impact their evaluation of a current production in the same genre.

In order to gain a better understanding of how modern consumers rate products and services, it is crucial to comprehend how they use their past preferences as a point of reference. Hence, this research paper aims to explore whether there exist any discernible patterns in genre preferences over time, and whether some genres tend to have a greater impact on average ratings than others.

## Method and results

This repository investigates what the influence of consumers' genre preference is on the ratings consumers give movies and series over time. This is done using four IMDb datasets. First, these datasets are merged, inspected, and cleaned. Next, the data is analyzed  using regression analysis. Consumers' movie/series ratings (averageRatings) serve as the dependent variable. Consequently, genre is regressed on averageRatings. We ran separate regressions for each 5 year period available in the dataset (e.g., 1960-1964 and 2005-2009). Genre preferences over time are viable to many unobservables. To account for those, fixed effects (e.g. title and title type) were added to the regression analysis.

To improve the reliability of our results, a cut off based on the number of votes on the movies and series was used. Since the dependent variable is *average* ratings, movies/series with only a few votes may receive more extreme average ratings. This can be the case because each rating, including the extreme ones, receives more weight when calculating the average, simply because there are only a few ratings. So, the average ratings may be more extreme, causing to skew the overall results. Therefore, movies/series receiving a number of votes that are below the cut off won't be included in the regression analysis. 

The results showed that 18 out of 25 genres influenced average ratings over time. 

## Repository overview

```
├── data
├── gen
│   ├── data_preperation
│   │   ├── input
│   │   ├── output
│   │   │   ├── table
│   │   │   └──  figures
│   │   └── temp
│   ├── data_analysis
│   │   ├── input
│   │   │   └── figures
│   │   ├── output
│   │   │   └──  pdf
│   │   └── temp
│   └── paper
└── src
│   ├── data_generation
│   └── data_prep
│   └── analysis
└── web_app

```
    
* gen: all generated files such as tables, figures, logs.
  - Three parts: data_preparation, analysis, and paper.
  - audit: put the resulting log/tables/figures of audit program. It has three sub-folders: figure, log, and table.
  - temp : put the temporary files, such as some intermediate datasets. We may delete these files in the end.
  - output: put results, including the generated figures in sub-folder figure, log files in sub-folder log, and tables in sub-folder table.
  - input: put all temporary input files
* data: all raw data.
* src: all source codes.
  -Three parts: Getting_the_Data, Data_Prep, and analysis.

## Running instructions
### Required programs

The workflow of the current repository depends on a few programs: 

* Git - to be able to run the repository locally (on your own computer) [Istallation guide](https://tilburgsciencehub.com/topics/automation/version-control/start-git/git/)
* R - programming language used to run code [Installation guide R and RStudio](https://tilburgsciencehub.com/topics/computer-setup/software-installation/rstudio/r/)
* RStudio - software that makes running R easier [Installation guide R and RStudio](https://tilburgsciencehub.com/topics/computer-setup/software-installation/rstudio/r/)
* Make - tool to automate the workflow [Installation guide](https://tilburgsciencehub.com/topics/automation/automation-tools/makefiles/make])
* VPN - Please make sure that you are connected to a vpn if you have one. This will improve the collection of the data. Otherwise IMDB will occasionally block you.
### How to get started

1. Install the required programs (see installation guides in the previous section).
2. Fork the repository, so that you have a copy of your own. [Instructions](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo)
3. Open the command prompt or terminal on your computer and set the working directory to the directory where you want the clone of the repository to be saved. You can do this by typing `cd PATH_TO_THE_DIRECTORY`.
4. Clone the repository by typing `git clone LINK_TO_THE_FORKED_REPOSITORY`. The link to the repository can be found by clicking the drop-down arrow under `Code` in GitHub. [Instructions](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#cloning-your-forked-repository)
5. Now you are all set to work with the repository locally!

### How to run the Workflow

1. Open the command prompt or terminal on your computer and set the working directory to the directory of the repository clone. You can do this by typing `cd PATH_TO_THE_DIRECTORY`.
2. Run the following command in the command line: `R --vanilla < installing_packages.R`. Now all the R packages you need to run the workflow are installed.
2. Type `make` to run the entire workflow.

## Authors

| Name                    | GitHub username  |
|-------------------------|------------------|
| Timo Philipse           | timophilipse     |
| Bram Teunissen          | bwg_teunissen    |
| Rodrigo Pačeko Rudzājs  | rprudzajs        |
| Dian de Ridder          | Ciertje          |
| Linda van den Boogaart  | lindavdboogaart  |
