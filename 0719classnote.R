data(iris)
iris

train <-iris[,-5]
train
str(train)

km <- kmeans(train, center=3, iter.max = 100)
km
km$cluster
table(iris[,5],km$cluster)

km2 <- kmeans(scale(train, center=T,scale=T), center=3, iter.max = 100)
km2
table(iris[,5],km2$cluster)


?glm

# regression

library(MASS)
data("birthwt")
str(birthwt)

scale(birthwt)

fit <- lm(bwt ~ age+lwt+factor(race)+factor(smoke)+ptl+factor(ht)+factor(ui)+ftv, 
          data=birthwt)
fit
summary(fit)

# prediction

set.seed(1234)
tar <- sample(1:nrow(birthwt),round(nrow(birthwt)*0.7))
train <- birthwt[tar,]
test <- birthwt[-tar,]
it <- lm(bwt ~ age+lwt+factor(race)+factor(smoke)+ptl+factor(ht)+factor(ui)+ftv, 
         data=train)
pd <- predict(fit,test)

sum(abs(pd-test[,"bwt"]))


# 연관분석

if(!require(arules)) install.packages("arules")
library(arules)

data("Groceries")
str(Groceries)
summary(Groceries)

dvdread <- read.csv("./data/dvdtrans.csv")
head(dvdread)
dvdtran <- read.transactions("./data/dvdtrans.csv")
inspect(dvdtran[1:10,])

dvdread
inspect(dvdtran)

load("./data/dvdTranSample.RData")
inspect(dvdTranSample)

dvdread

as(split(dvdread$Item,dvdread$ID)), "transcation"





rule <- apriori(data=Groceries,
                parameter = list(support=0.01,confidence=0.2,minlen=2))

