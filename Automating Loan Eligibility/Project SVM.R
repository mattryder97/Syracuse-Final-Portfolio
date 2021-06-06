# SVM
library(kernlab)
library(ggplot2)

svm1 = ksvm(decision_status ~ credit_score + requested_loan_term_ + requested_loan_amount_ +
            preapproved_loan_amount_ + preapproved_loan_term_ + person_degree_type_desc +
            actual_net_income_ + monthly_debt_capacity_ + age, data = trainData,
            kernel = 'rbfdot', cost = 5, type = 'C-svc')

svm1Preds = predict(svm1, testData)

testData$svmPred = svm1Preds
svm1Wrong = abs(as.numeric(testData$decision_status)-as.numeric(testData$svmPred))
svm1CountWrong = sum(svm1Wrong)


svm1Plot = ggplot(testData) +
  geom_point(aes(x = actual_net_income_, y = credit_score, shape = svmPred, color = decision_status, size = as.factor(svm1Wrong))) +
  ggtitle('SVM Predictions')

svm1Plot
