#Initiualize libraries and import plot1.R, plot4.R
initialize<-function()
{
  source("plot1.R")
  source("plot4.R")
  library(ggplot2)
  library(sqldf)
  #cleans dtJoin not to use the one from previous plot
  if(exists("dtJoin"))
  {
    rm(dtJoin)
  }
  
}

#join data from the 2 files
joinTables5 <- function()
{
  #gets the summary datatable
  dtSummary<-getDt()
  
  #gets data from Soruce classification
  dtSourceClassif <- getDtSourceClassif()
  
  if(!exists("dtJoin"))
  {
    
    #join and get only data fro Baltimore
    # combustion from motor source is assumed to contain
    #the word "mobile"
    dtJoin <<- sqldf("SELECT 
                     dts.* 
                     , dtc.EI_Sector
                     FROM  dtSummary dtS 
                     INNER JOIN dtSourceClassif dtC
                     on dtS.SCC = dtC.SCC
                     WHERE dtC.EI_Sector like '%Mobile%'
                     AND dts.fips ='24510' ")
  }
  
  return (dtJoin)
}

##gets aggregated data per year from joinTable()
## This datatable will be used to plot
getPlotDt5 <- function()
{
  #gets the joined datatable
  dtJoin <- joinTables5()
  
  if(!exists("dtPlot5"))
  {
    dtPlot5 <<- sqldf("SELECT 
                     sum(Emissions) as 'Emissions'
                    , year
                    FROM
                     dtJoin
                     GROUP BY year")
  }
  return(dtPlot5)
}

##Plots graph 5: Emissions in Baltimore from motor sources
plot5 <-function()
{
  #gets the datatable ready to plot
  dtPlot <- getPlotDt5()
  
  #plots the graph
  qplot(year, Emissions, data=dtPlot, ylab='Total Emissions ', geom='line', main='Total Emissions from Motor Source in Baltimore')
}