---
title: "multiple files"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

library(dplyr)
library(readr)
library(purrr)
library(tidyr)
library(tm)
library(wordcloud)
library(widyr)

```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}

#Python
training_python <- "D:/ITM/Text mining/Python files/"

# Define a function to read all files from a folder into a data frame
python_docs <- VCorpus(DirSource(training_python))
summary(python_docs)
inspect(python_docs) # displays entire corpus
inspect(python_docs[[1]]) # displays first document in corpus

attributes(python_docs)

#removing commented section
removeComments_python <- function(python_docs) {
  gsub("#.*"," ", python_docs)
} 

#removing quoted section
removeQuoted_python <- function(python_docs){
  gsub("(\".*\")", "", python_docs)
}

#removing unwanted puntuation
removePunct_python <- function(python_docs){
  gsub("[][\"!#$%*/+?,():<=>@\\^|~{}']", "", python_docs)
}
#cleaning and pre-processing the corpus
  
python_docs <- tm_map(python_docs, content_transformer(removeComments))
python_docs <- tm_map(python_docs, content_transformer(removeQuoted))
python_docs <- tm_map(python_docs, content_transformer(removePunct))
python_docs <- tm_map(python_docs, stripWhitespace)

#converting corpus to term frequency document 

dtm_python <- TermDocumentMatrix(python_docs)
python_matrix <- as.matrix(dtm_python)
freq_python <- sort(rowSums(python_matrix),decreasing=TRUE)
python_df <- data.frame(word = names(freq_python),freq=freq_python)
head(python_df, 40)
tail(python_df,30)

#plot in a wordcloud
set.seed(1234)
wordcloud(words = python_df$word, freq = python_df$freq, min.freq = 15,
          max.words=150, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


# java 
training_folder <- "D:/ITM/Text mining/Java files/"

# Define a function to read all files from a folder into a data frame
java_docs <- VCorpus(DirSource(training_folder))
summary(java_docs)
inspect(java_docs)
inspect(java_docs[[2]])

attributes(java_docs)

#removing commented section
removeComments <- function(java_docs) {
  gsub("[/\\*].*"," ", java_docs)
} 

#removing quoted section
removeQuoted <- function(java_docs){
  gsub("(\".*\")", "", java_docs)
}

#removing unwanted puntuation
removePunct <- function(java_docs){
  gsub("[][\"!#$%*/+?,():<=>@\\^|~{}']", "", java_docs)
}
#cleaning and pre-processing the corpus
  
java_docs <- tm_map(java_docs, content_transformer(removeComments))
java_docs <- tm_map(java_docs, content_transformer(removeQuoted))
java_docs <- tm_map(java_docs, content_transformer(removePunct))
java_docs <- tm_map(java_docs, stripWhitespace)


dtm_java <- TermDocumentMatrix(java_docs)
dtm
java_matrix <- as.matrix(dtm_java)

freq_java <- sort(rowSums(java_matrix),decreasing=TRUE)
java_df <- data.frame(word = names(freq_java),freq=freq_java)
head(java_df, 40)
tail(java_df,30)

#plot in a wordcloud
set.seed(1234)
wordcloud(words = java_df$word, freq = java_df$freq, min.freq = 5,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


```



## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)

java_pair <-  findAssocs(dtm_java, c("new"), corlimit = 0.9)
barplot(height = java_pair$new, angle = 90)
python_pair <- findAssocs(dtm_python, c("not"), corlimit = 0.95)
python_pair

#"public","static","new"



```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
