rm( list = ls ( all = TRUE))

require(devtools)
install_github('rCharts', 'ramnathv')
library(rCharts)
library(base64enc)

## Example map
map3 <- Leaflet$new()
map3$setView(c(23.9179593,120.67751640000006), zoom = 7)
map3$marker(c(25.0435203,121.5574173), bindPopup = "<p> Hi. I am in R-Ladies Taipei </p>")
map3$marker(c(22.7570901, 121.15177849999998), bindPopup = "<p> Hi. I am from here </p>")
map3

## Example 1 Facetted Scatterplot
names(iris) = gsub("\\.", "", names(iris))
ex1 <- rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')
ex1$save('ex1.html', standalone = TRUE)

## Example 2 Facetted Barplot
hair_eye = as.data.frame(HairEyeColor)
ex2 <- rPlot(Freq ~ Hair | Eye, color = 'Eye', data = hair_eye, type = 'bar')
ex2$save('ex2.html', standalone = TRUE)

## Example 3 MTcars
## https://rstudio-pubs-static.s3.amazonaws.com/45786_b5e54c2d3c824f51abd2d559506cf81f.html
ex3 <- rPlot(mpg ~ wt | am + vs, data = mtcars, type = "point", color = "gear")
ex3$save('ex3.html', standalone = TRUE)

## Example 4
data(economics, package = "ggplot2")
econ <- transform(economics, date = as.character(date))
ex4 <- mPlot(x = "date", y = c("psavert", "uempmed"), type = "Line", data = econ)
ex4$set(pointSize = 0, lineWidth = 1)
ex4$save('ex4.html', standalone = TRUE)

## Example 5
hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == "Male")
ex5 <- nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male, type = "multiBarChart")
ex5$save('ex5.html', standalone = TRUE)

## Example 6
require(reshape2)
uspexp <- melt(USPersonalExpenditure)
names(uspexp)[1:2] = c("category", "year")
ex6 <- xPlot(value ~ year, group = "category", data = uspexp, type = "line-dotted")
ex6$save('ex6.html', standalone = TRUE)

## Example 7
testData = MASS::survey
names(testData) = gsub("\\.", "", names(testData))
ex7 <- hPlot(x = "WrHnd", y = "NWHnd", data = testData, type = c("line", "bubble", "scatter"), group = "Clap", size = "Age")
ex7$save('ex7.html', standalone = TRUE)

## save to html
text = "<html>"
for(i in 1:7)
{
  text = paste0(text, "<iframe src=\"ex", i, ".html\"", " height=\"100%\" width=\"100%\" scrolling=no frameborder=0></iframe>")
}
text = paste0(text, "</html>")
fileConn<-file("main.html")
writeLines(text, fileConn)
close(fileConn)