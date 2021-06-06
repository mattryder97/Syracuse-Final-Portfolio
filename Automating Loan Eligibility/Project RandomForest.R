# random forest
library(randomForest)
library(pROC)
library(ggplot2)

rf1 = randomForest(decision_status ~ credit_score + requested_loan_term_ + requested_loan_amount_ +
  preapproved_loan_amount_ + preapproved_loan_term_ + person_degree_type_desc +
  actual_net_income_ + monthly_debt_capacity_ + age, data = trainData, ntree = 1000, mtry = 4)

rf1
importance(rf1)

# drop least important variables, person_degree_type_desc amd see if the model improves
rf2 = randomForest(decision_status ~ credit_score + requested_loan_term_ + requested_loan_amount_ +
                     preapproved_loan_amount_ + preapproved_loan_term_ +
                     actual_net_income_ + monthly_debt_capacity_ + age, data = trainData, ntree = 1000, mtry = 4)

rf2
importance(rf2)

# rf1 is better but lets try and refine it some more
# Test different mtry
rf3 = randomForest(decision_status ~ credit_score + requested_loan_term_ + requested_loan_amount_ +
                     preapproved_loan_amount_ + preapproved_loan_term_ + person_degree_type_desc +
                     actual_net_income_ + monthly_debt_capacity_ + age, data = trainData, ntree = 1000, mtry = 3)
rf3
# the same

rf4 = randomForest(decision_status ~ credit_score + requested_loan_term_ + requested_loan_amount_ +
                     preapproved_loan_amount_ + preapproved_loan_term_ + person_degree_type_desc +
                     actual_net_income_ + monthly_debt_capacity_ + age, data = trainData, ntree = 1000, mtry = 5)
rf4
# worse

# We will stick to mtry = 4

# Try less trees
rf5 = randomForest(decision_status ~ credit_score + requested_loan_term_ + requested_loan_amount_ +
                     preapproved_loan_amount_ + preapproved_loan_term_ + person_degree_type_desc +
                     actual_net_income_ + monthly_debt_capacity_ + age, data = trainData, ntree = 500, mtry = 4)
rf5
# worse

rf6 = randomForest(decision_status ~ credit_score + requested_loan_term_ + requested_loan_amount_ +
                     preapproved_loan_amount_ + preapproved_loan_term_ + person_degree_type_desc +
                     actual_net_income_ + monthly_debt_capacity_ + age, data = trainData, ntree = 750, mtry = 4)
rf6
# same

# we will use rf1 with mtry=4 and ntree=1000

rfPreds = predict(rf1, testData)
testData$rfPred = rfPreds

rfWrong = abs(as.numeric(testData$decision_status)-as.numeric(testData$rfPred))
rfCountWrong = sum(rfWrong)

rfPlot = ggplot(testData) +
  geom_point(aes(x = actual_net_income_, y = credit_score, shape = rfPred, color = decision_status, size = as.factor(rfWrong))) +
  ggtitle('Random Forest Predictions')

rfPlot
