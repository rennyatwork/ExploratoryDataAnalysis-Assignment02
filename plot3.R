
initialize<-function()
{
  source("plot1.R")
  library(ggplot2)
  library(sqldf)
}

##this corresponds to the second file
#getDtSourceClassif <- function()
#{ 
#  if(!exists("dtSourceClassif"))
#  {
#    dtSourceClassif <<- readRDS(getFullPathFileName('summarySCC_PM25'))
#  }
#  return (dtSourceClassif);
#  #transform(NEI, year = factor(year)
#}


## Gets the data for Baltimore: Sum(Emission), Year, Type
getDtWithType<-function()
{
  dt<-getDt()   
  
  #selects the sum of Emissions in Baltimore
  if(!exists("dtWithType"))
  {
    dtWithType<<-sqldf("select sum(Emissions), year, type from dt 
        WHERE fips='24510'  
        GROUP BY year, type
        ORDER BY year, type ");
  }
  
  
  return (dtWithType)
}

#Plots the graph
plot3 <-function()
{
  #get data for baltimore
  dtBaltimore <- getDtWithType()
  
  #dtBaltimore[1] =sum(Emissions), [2]=year, [3]=type
  # plots the graph
  qplot(unlist(dtBaltimore[2]), unlist(dtBaltimore[1]), data=dtBaltimore,
        color=unlist(dtBaltimore$type), geom='line', xlab='Year', ylab='Emissions PM25')  +  scale_colour_discrete(name='Type')
}

##join data from the 2 files
#joinTables <- fuction()
#{
#  #gets the summary datatable
#  dtSummary<-getDt()
#  
#  #gets data from Soruce classification
#  dtSourceClassif <- getDtSourceClassif()
#  
#  #join and get only data fro Baltimore
#  dtJoin <- sqldf("SELECT ")
#}


# qplot(unlist(x[2]), unlist(x[1]), data=x, color=unlist(x$type), geom='line', xlab='Year', ylab='Emissions PM25')  +  scale_colour_discrete(name='Type')