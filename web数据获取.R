# web数据获取
# 结构化的网页数据抓取
library(XML)
#webpage <- 'http://data.earthquake.cn/datashare/globeEarthquake_csn.html'
webpage <- 'http://www.cea.gov.cn/publish/dizhenj/464/479/index.html'
webpage
tables <- readHTMLTable(webpage, stringsAsFactors = FALSE)
tables
raw <- tables[[6]]
raw
data <- raw[, 3:5]
data

# 非结构化网页数据抓取

# Api