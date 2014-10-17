initialize <-function ()
{
  library(sqldf)
}

##This function return the full path+ file name to be read
getFullPathFileName <-function(pFileName)
{
  return (paste(paste(getwd(),paste("exdata_data_NEI_data", pFileName, sep="/"), sep="/"), ".rds" , sep=""))
}


## From http://stackoverflow.com/questions/14923581/open-files-saved-with-rs-saverds-serialization-interface-with-stata
#resave <- function(infile)
#{
#  x <- readRDS(infile)
#  outfile <- sub("\\.rds$", "\\.csv", infile)
#  write.csv(x, outfile)
#}


##This function loads the desired dataset (NEI or SCC)
#get

#summary <-file(getFullPathFileName('summarySCC_PM25'))
# NEI <- readRDS(getFullPathFileName('summarySCC_PM25'))