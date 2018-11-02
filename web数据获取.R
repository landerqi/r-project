# web数据获取
# 结构化的网页数据抓取
library(XML)
webpage <- 'http://landerqi.com'
# webpage <- 'https://bulma.io/documentation/elements/table/'
tables <- readHTMLTable(webpage, stringsAsFactors = FALSE)
tables
raw <- tables[[2]]
data <- raw[, 3:5]
data <- data[-1, ]
names(data) <- c('lan', 'lon', 'deep')
sapply(data, class)
data$deep <- as.numeric(data$deep)
summary(data$deep)
raw[which.max(data$deep), ]
data <- transform(data, lan = as.numeric(lan), lon = as.numeric(lon))
hist(data$lan, 40)
hist(data$lon, 40)

# 非结构化网页数据抓取
### xpath使用
library(XML)
url <- 'http://landerqi.com/'
landerqi <- htmlParse(url, encoding = 'UTF-8')
xpath <- '//*[@id="wrapper"]/article[1]/div/div'
nodes <- getNodeSet(landerqi, xpath)
names <- sapply(nodes, xmlValue)

# Api
# https://api.douban.com/v2/movie/subject/5323968