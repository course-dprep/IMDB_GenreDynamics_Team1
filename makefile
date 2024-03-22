# Debug: movie_data.csv
all: src/analysis/paper.pdf

src/data_prep/movie_data.csv: src/data_prep/Getting_the_Data.R
	R --vanilla < src/data_prep/Getting_the_Data.R 

src/data_prep/movie_data_cleaned.csv: src/data_prep/movie_data.csv src/data_prep/Data_prep.R
	R --vanilla < src/data_prep/Data_prep.R
	
src/analysis/regression_analysis.pdf: src/data_prep/movie_data_cleaned.csv src/analysis/regression_analysis.R
	R --vanilla < src/analysis/regression_analysis.R
	
src/analysis/paper.pdf: src/analysis/plots.pdf gen/paper/paper.Rmd
	R --vanilla < gen/paper/paper.Rmd

app: src/data_prep/Getting_the_Data.R src/data_prep/data_prep.R src/analysis/regression_analysis.R src/analysis/app.R
	R --vanilla < src/analysis/app.R

clean:
	R -e "unlink('.Rhistory')"
	R -e "unlink('*.csv')"
	R -e "unlink('*.pdf')"