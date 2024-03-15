# Debug: movie_data.csv

movie_data.csv: getting_the_data.R
	R --vanilla < getting_the_data.R

movie_data_cleaned.csv: movie_data.csv data_prep.R
	R --vanilla < data_prep.R
	
...: movie_data_cleaned.csv regression_analysis.R
	R --vanilla < regression_analysis.R

clean:
	R -e "unlink('.Rhistory')"
	# R -e "unlink('*.csv')"