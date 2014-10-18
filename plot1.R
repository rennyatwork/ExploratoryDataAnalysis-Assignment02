initialize <-function ()
{
  library(sqldf)
}

##This function return the full path+ file name to be read
getFullPathFileName <-function(pFileName)
{
  return (paste(paste(getwd(),paste("exdata_data_NEI_data", pFileName, sep="/"), sep="/"), ".rds" , sep=""))
}

## Gets the NEI Dt
getDt <- function()
{
  return (readRDS(getFullPathFileName('summarySCC_PM25')))
  #transform(NEI, year = factor(year)
}

sumPerYear <-function()
{
  
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
#dt2 <-  sqldf("select sum(Emissions), year from NEI group by year")
#plot(data.frame(dt2[2], dt2[1]))
# plot(data.frame(dt2[2], dt2[1]/1000.00), type='l', xlab='year', ylab=' Emissions (x 1000)', main='Total Emissions (x 1000) per year')