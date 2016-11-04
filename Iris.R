source("F:\\RStudio Projects\\Neural Networks\\functions.R")

addPackage("neuralnet")

irisData <- iris[sample(1:150, 50),]

print(irisData)

trainingSet <- irisData

trainingSet$setosa <- c(trainingSet$Species == 'setosa')

trainingSet$versicolor <- c(trainingSet$Species == 'versicolor')

trainingSet$virginica <- c(trainingSet$Species == 'virginica')

print(trainingSet)

trainingSet$Species <- NULL

nn <- neuralnet(setosa + versicolor + virginica ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, trainingSet, hidden=40,lifesign = "full")

plot(nn, rep="best")

plot(nn, rep = "best", intercept=FALSE)


predict <- compute(nn, iris[1:4])

print(predict)

result <- 0

for (i in 1:150) { result[i] <- which.max(predict$net.result[i,]) }

print(result)


for (i in 1:150) { if (result[i]==1) { result[i] = "setosa"}}

for (i in 1:150) { if (result[i]==2) {result[i] = "versicolor"} }

for (i in 1:150) { if (result[i]==3) {result[i] = "virginica"} }

print(result)

comparison <- iris

print(iris)

comparison$Predicted <- result

print(comparison)


#accepting user input:

Sepal_Length <- 5.9
Sepal_Width <- 3.0
Petal_Length <- 5.1
Petal_Width <- 1.8


userobs <- data.frame(SepalLength=double(),
  SepalWidth=double(),
  PetalLength=double(),
  PetalWidth=double(),
  stringsAsFactors=FALSE)

userobs <- rbind(userobs, data.frame(SepalLength=Sepal_Length,
  SepalWidth=Sepal_Width,
  PetalLength=Petal_Length,
  PetalWidth=Petal_Width,
  stringsAsFactors=FALSE))

predict <- compute(nn, userobs[1:4])

result <- 0

result[1] <- which.max(predict$net.result[1,])

if (result==1) { result = "setosa"}
if (result==2) {result = "versicolor"}
if (result==3) {result = "virginica"}

comparison <- userobs

comparison$Predicted <- result

print(comparison)
