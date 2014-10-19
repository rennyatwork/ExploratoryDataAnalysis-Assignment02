initialize<-function()
{
  source("plot1.R")
  library(ggplot2)
  library(sqldf)
}

#this corresponds to the second file
getDtSourceClassif <- function()
{ 
  if(!exists("dtSourceClassif"))
  {
    dtSourceClassif <<- readRDS(getFullPathFileName('Source_Classification_Code'))
  }
  return (dtSourceClassif);
  #transform(NEI, year = factor(year)
}


#join data from the 2 files
joinTables <- function()
{
  #gets the summary datatable
  dtSummary<-getDt()
  
  #gets data from Soruce classification
  dtSourceClassif <- getDtSourceClassif()
  
  if(!exists("dtJoin"))
  {
  
  #join and get only data fro Baltimore
  dtJoin <<- sqldf("SELECT 
                  dts.* 
                  , dtc.EI_Sector
                  FROM  dtSummary dtS 
                  INNER JOIN dtSourceClassif dtC
                  on dtS.SCC = dtC.SCC
                  WHERE dtC.EI_Sector like '%Comb%Coal' ")
  }
  
  return (dtJoin)
}

##gets aggregated data per year from joinTable()
## This datatable will be used to plot
getPlotDt <- function()
{
  #gets the joined datatable
  dtJoin <- joinTables()
  
  if(!exists("dtPlot"))
  {
    dtPlot <<- sqldf("SELECT 
                     sum(Emissions) as 'Emissions'
                    , year
                    FROM
                     dtJoin
                     GROUP BY year")
  }
  return(dtPlot)
}

#plots the graph using ggplot2
plot4 <- function()
{
  dtPlot <- getPlotDt()
  qplot(year, Emissions/1000, data=dtPlot, ylab='Total Emissions (x1000)', geom='line', main='Total Emissions from Coal Combustion Source in the US')
}
