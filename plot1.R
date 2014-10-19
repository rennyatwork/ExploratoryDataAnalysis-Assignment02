## Question1:
## Have total emissions from PM2.5 decreased in the United States 
##from 1999 to 2008? Using the base plotting system, make a plot showing
##the total PM2.5 emission from all sources for each of the years 
##1999, 2002, 2005, and 2008.

##initialize to use library sqldf
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
  if(!exists("lixo"))
  {
    lixo <<- readRDS(getFullPathFileName('summarySCC_PM25'))
  }
  return (lixo);
  #transform(NEI, year = factor(year)
}

## saves and close the file
saveAndClose <- function(pName, pWidth=480, pHeight=480)
{
  dev.copy(png, paste(pName, ".png", sep=""), width=pWidth, height=pHeight)
  dev.off()
}

plot1<-function()
{
  #initialize
  initialize()
  
  #read the data into variable NEI
  NEI<-getDt()
  
  #generate new datatable with data suitable for plotting
  dt2 <-  sqldf("select sum(Emissions), year from NEI group by year")
  
  #plots the graph
  plot(data.frame(dt2[2], dt2[1]/1000.00), type='l', xlab='year', ylab=' Emissions PM25 (x 1000)', main='Total Emissions PM25 (x 1000) per year')
  
  #saves and closes
  saveAndClose("plot1")
}
##This function loads the desired dataset (NEI or SCC)
#get

#summary <-file(getFullPathFileName('summarySCC_PM25'))
# NEI <- readRDS(getFullPathFileName('summarySCC_PM25'))
#dt2 <-  sqldf("select sum(Emissions), year from NEI group by year")
#plot(data.frame(dt2[2], dt2[1]))
# plot(data.frame(dt2[2], dt2[1]/1000.00), type='l', xlab='year', ylab=' Emissions PM25 (x 1000)', main='Total Emissions PM25 (x 1000) per year')