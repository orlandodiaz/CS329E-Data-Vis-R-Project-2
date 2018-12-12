require("tidyr")
require("dplyr")
require("ggplot2")
require("jsonlite")
require("RCurl")
require("grid")

# call in data from data.world
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ",'oraclerest.cs.utexas.edu:5000/rest/native/?query="select * from pantheria"')),httpheader=c(DB='jdbc:data:world:sql:jlee:s-17-edv-project-2', USER='jlee', PASS=redacted , MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE) ))

#df <- read.csv("https://query.data.world/s/e87oaimd6h5idzo35twdrkxap",header=T);

# display summary, head, and subset of the dataframe
print(summary(df))
print(head(df))
print(subset(df))
