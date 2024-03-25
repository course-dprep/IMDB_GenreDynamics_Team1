# Welcome, this will take a while. Get a coffee, you deserve it. 
# Please ensure you are logged in on your VPN if you have one. Otherwise tbe downloading of the data may fail.

# Define objects to improve efficieny
# = src/data_generation/getting_the_data.R
data_download = src/data_generation/getting_the_data.R
data_merging = src/data_prep/merging_the_data.R
data_cleaning = src/data_prep/data_prep.Rmd
data_analysis = src/analysis/regression_analysis.Rmd
paper = gen/paper/paper.Rmd

# Define targets and dependencies
Debug: gen/paper/paper.pdf
# All:

#Input
# Target to download data
data/movie_data.RData: $(data_download)
	R --vanilla < $(data_download)

# Transformation
# Target to merge data
data/movie_data.csv: $(data_merging) data/movie_data.RData
	R --vanilla < $(data_merging)
	
# Target to clean data, and safe graph data
data/movie_data_cleaned.csv: $(data_cleaning) data/movie_data.csv
	Rscript -e "rmarkdown::render('$<')"

# Target to analyse data, and safe graph data
data/graph_data.csv: $(data_analysis) data/movie_data_cleaned.csv
	Rscript -e "rmarkdown::render('$<')"

#Output
# Target to safe the pdf of the paper
gen/paper/paper.pdf: $(paper) data/graph_data.csv
	Rscript -e "rmarkdown::render('$<')"

# Target to run the shiny web application, if you are done using the shiny web application manually stop the make and type "clear" to clean up the terminal
app: data/graph_data.csv app.R
		R --vanilla <app.R

#cleaning up after outselves
clean:
	R -e "unlink('.Rhistory')"
	R -e "unlink('*.RData')"
	R -e "unlink('data/*.RData')"
	R -e "unlink('*.csv')"
	R -e "unlink('data/*.csv')"
	R -e "unlink('*.pdf')"
	R -e "unlink('gen/data_analysis/*.pdf')"
	R -e "unlink('gen/data_preparation/*.pdf')"
	R -e "unlink('gen/paper/*.pdf')"
	R -e "unlink('*.png')"
	R -e "unlink('gen/data_analysis/*.png')"
	R -e "unlink('gen/data_preparation/*.png')"