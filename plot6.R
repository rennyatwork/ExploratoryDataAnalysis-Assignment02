#Initiualize libraries and import plot1.R, plot4.R, plot5.R
initialize<-function()
{
  source("plot1.R")
  source("plot4.R")
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
joinTablesLA <- function()
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
                     dts.SCC
                     , dts.Emissions
                     , dts.year
                     , dts.fips
                     , dtc.EI_Sector
                     FROM  dtSummary dtS 
                     INNER JOIN dtSourceClassif dtC
                     on dtS.SCC = dtC.SCC
                     WHERE dtC.EI_Sector like '%Mobile%'
                     AND (dts.fips ='06037' 
                     OR dts.fips ='24510') ")
  }
  
  return (dtJoin)
  }

##gets aggregated data per year from joinTable()
## This datatable will be used to plot
getPlotDt6 <- function()
{
  #gets the joined datatable
  dtJoin <- joinTablesLA()
  
  if(!exists("dtPlot6"))
  {
    dtPlot6 <<- sqldf("SELECT 
                     sum(Emissions) as 'Emissions'
                    , year
                    , fips 
                    FROM
                     dtJoin
                     GROUP BY year, fips")
  }
  return(dtPlot6)
}

##Plots graph 5: Emissions in Baltimore from motor sources
plot6 <-function()
{
  
  
  #gets the datatable ready to plot
  dtPlot <- getPlotDt6()
  
  #plots the graph

  ##http://stackoverflow.com/questions/17240536/r-unary-operator-error-from-multiline-ggplot2-command
  ##This is a well-known nuisance when posting multiline commands in R.  
  ##Rule: put the dangling '+' at the end of a line so R knows the command is unfinished:
  
  qplot(year, Emissions, data=dtPlot, 
        ylab='Total Emissions'
        , geom='line'
        , main='Total Emissions from Motor Source in Baltimore and LA'
        , color = unlist(dtPlot$fips)
        ) +
    scale_colour_discrete(name='City' 
                           , breaks=c(unique(dtPlot$fips))
                           ,labels=c('LA', 'Baltimore')
                           )
}
