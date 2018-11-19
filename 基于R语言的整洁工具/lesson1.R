# 整理jane austen的作品
### janeaustenr包中有jane austen的六本小说的电子文档
library(janeaustenr)
library(dplyr)
library(stringr)
original_books <- austen_books() %>% 
  group_by(book) %>% 
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex('^chapter [\\divxlc]', ignore_case = TRUE)))) %>%
  ungroup()
original_books

### 找出最常见的单词
library(tidytext)
tidy_books <- original_books %>%
  unnest_tokens(word, text); tidy_books # word是列名，text是original_books中要分析的text列
data(stop_words)
tidy_books <- tidy_books %>%
  anti_join(stop_words) # 删除停用词如：'the', 'of', 'to'
tidy_books %>% count(word, sort = TRUE) #查找最常见的单词

### 生成图表
library(ggplot2)
tidy_books %>%
  count(word, sort = TRUE) %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() # x,y transform
  
