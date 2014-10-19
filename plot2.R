##Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
##Use the base plotting system to make a plot answering this question.
initialize <- function()
{
  #reuses code from plot1.R
  source("plot1.R")
}

getDtBaltimore <-function ()
{
  #from plot1.R
  dt<-getDt();
  
  #selects the sum of Emissions in Baltimore
  if(!exists("dtReturn"))
  {
    dtReturn<<-sqldf("select sum(Emissions), year from dt 
        WHERE fips='24510'  
        group by year ");
  }
  
  
  return (dtReturn)
  
}

#plots the graph
plot2 <- function()
{
  ##initializes with code from plot1.R
  initialize()
  
  #gets data for Baltimore City
  dtBaltimore <-getDtBaltimore()
  
  #plots the graph
  plot(data.frame(dtBaltimore[2], dtBaltimore[1]/1000.00), type='l', xlab='year', ylab=' Emissions PM25 (x 1000)', main='Total Emissions PM25 (x 1000) per year in Baltimore')
 
  #saves the file
  saveAndClose("plot2", 600)
}
                  