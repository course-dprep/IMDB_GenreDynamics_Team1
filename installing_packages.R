# This Rscript searches all the project's source code for references to packages,
# and subsequently installs all packages which are needed, but yet uninstalled.

# Find all source code files
files <- list.files(
  path = "./src", # Tells the function to only search through files in the source code folder (src)
  pattern = '[.](R|rmd)$', # Tells the function to only list .R and .Rmd files.
  all.files = T, # Includes invisible files as well
  recursive = T, # Makes sure the names of the sub directories are returned as well as the file names.
  full.names = T, # Returns relative paths instead of just file names.
  ignore.case = T)

# Read in source code
code = unlist(sapply(files, scan, what = 'character', quiet = TRUE))

  # sapply applies a function over a list or vector. It returns a vector or matrix.
  # In our case it applies the scan function to the list ('files') we created before.
  # The two arguments thereafter are arguments of the scan function.
  # scan reads data values. By specifying what = 'character' we indicate that the 
  # scan function should read character data. And by setting quiet to TRUE, we
  # prevent a line to be print that indicates how many items have been read.
  # In our case sapply creates a vector with character values for each of the files in the files object.
  # By putting the list of vectors returned by sapply into unlist, a single vector
  # is returned containing all of the character values that were present in the list.
  # We then store this vector in the object 'code'.

# Retain only source code starting with library
code <- code[grepl('^library', code, ignore.case=T)]
code <- gsub('^library[(]', '', code) # Removes 'library(' from the code, only retaining all 'package_name)'.
code <- gsub('[)]', '', code) # Removes the closing bracket ')' after the package name as well.
code <- gsub('^library$', '', code)

# retain unique packages
uniq_packages <- unique(code)

# kick out "empty" package names
uniq_packages <- uniq_packages[!uniq_packages == ''] 

# order alphabetically
uniq_packages <- uniq_packages[order(uniq_packages)] 

# Prints required packages
cat('Required packages: \n')
cat(paste0(uniq_packages, collapse= ', '),fill=T)
cat('\n\n\n')

# retrieve list of already installed packages
installed_packages <- installed.packages()[, 'Package']

# identify missing packages
to_be_installed <- setdiff(uniq_packages, installed_packages)

if (length(to_be_installed)==length(uniq_packages)) cat('All packages need to be installed.\n')
if (length(to_be_installed)>0) cat('Some packages already exist; installing remaining packages.\n')
if (length(to_be_installed)==0) cat('All packages installed already!\n')

# install missing packages
if (length(to_be_installed)>0) install.packages(to_be_installed, repos = 'https://cloud.r-project.org')

cat('\nDone!\n\n')
