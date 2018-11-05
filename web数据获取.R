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
  
# 【数据获取】爬虫利器Rvest包
library(rvest)
web <- read_html("https://book.douban.com/top250?icn=index-book250-all", encoding="UTF-8")
position <- web %>% html_nodes("p.pl") %>% html_text()
# position <- iconv(position, from = 'UTF-8', to = 'GB2312')
Encoding(position)
position # 有时输出的中文是 unicode码 此时需要设置：Sys.setlocale("LC_CTYPE", "UTF-8")
# as.character(position)
# position_ch <- lapply(position, as.character)
# position_ch
# 第一行是加载Rvest包。
# 第二行是用read_html函数读取网页信息（类似Rcurl里的getURL），在这个函数里只需写清楚网址和编码（一般就是UTF-8）即可。
# 第三行是获取节点信息。用%>%符号进行层级划分。web就是之前存储网页信息的变量，所以我们从这里开始，然后html_nodes()函数获取网页里的相应节点。在下面代码里我简单的重现了原网页里的一个层级结构。可以看到，实际上我们要爬取的信息在25个class属性为pl的<p>标签里的文本。
