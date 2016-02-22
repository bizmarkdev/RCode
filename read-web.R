# Reading data from the web

# http://www.theatlantic.com/technology/archive/2014/01/how-netflix-reverse-engineered-hollywood/282679/
# http://www.r-bloggers.com/?s=Web+Scraping

# Getting data off webpages - readLines()
con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

library(XML)
#url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"  
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html,"//title",xmlValue)  # xmlValue is a function to extract contents of a leaf XML node
xpathSApply(html,"//td[id='col-citedby']", xmlValue)

# GET from the httr package
library(httr)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml,"//title",xmlValue)

# GET from the httr package: accessing websites with passwords
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd"))
pg2
names(pg2)
# having got to this point, use the "content" to access the data

# Using handles
# handles: cookies will stay with the handle and so will save authentication and session info
# http://cran.r-project.org/web/packages/httr/httr.pdf
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")


