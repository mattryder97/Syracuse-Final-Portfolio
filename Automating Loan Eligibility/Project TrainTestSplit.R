# train test split

randIndex = sample(1:nrow(projectdata))

cutValue = floor(2*nrow(projectdata)/3)

trainData = projectdata[randIndex[1:cutValue],]
testData = projectdata[randIndex[(cutValue+1):nrow(projectdata)],]
