# 获取字符串的长度
fruit <- 'apple orange grape banana'
nchar(fruit)
length(fruit)

# 字符串分割
strsplit(fruit, split = ' ') # 分割之后是list结构
fruitvec <- unlist(strsplit(fruit, split = ' ')); fruitvec # 转成向量

# 字符串拼接
paste(fruitvec, collapse = ',')

# 字符串截取
substr(fruit, 1, 5)

# 字符串替代
gsub('apple', 'strawberry', fruit)

# 字符串匹配
grep('grape', fruitvec) # 返回位置
grepl('grape', fruitvec) # 返回逻辑向量

# 小练习：R官网上的扩展包信息
library(rvest)
web <- 'https://cran.r-project.org/web/packages/available_packages_by_name.html'
webhtml <- read_html(web);
packages <- webhtml %>% html_node('table') %>% html_table(header = FALSE);
pnames <- packages[[1]][ ,1]
length(pnames)


###
library(rvest)
births <- read_html("https://www.ssa.gov/oact/babynames/numberUSbirths.html")
html_table(html_nodes(births, "table")[[2]])

tdist <- read_html("http://en.wikipedia.org/wiki/Student%27s_t-distribution")
tdist %>%
  html_node("table.infobox") %>%
  html_table(header = FALSE)

