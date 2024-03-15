# Debug: movie_data.csv

movie_data.csv: Getting_the_Data.R
	R --vanilla < Getting_the_Data.R

movie_data_cleaned.csv: movie_data.csv Data_prep.R
	R --vanilla < Data_prep.R
	
...: movie_data_cleaned.csv regression_analysis.R
	R --vanilla < regression_analysis.R

clean:
	R -e "unlink('.Rhistory')"
	# R -e "unlink('*.csv')"