# Naive Bayes

library(e1071)
library(ggplot2)

nb = naiveBayes(decision_status ~ credit_score + requested_loan_term_ + requested_loan_amount_ +
                  preapproved_loan_amount_ + preapproved_loan_term_ + person_degree_type_desc +
                  actual_net_income_ + monthly_debt_capacity_ + age, data = trainData)
nbPreds = predict(nb, testData, type = 'class')

testData$nbPred = nbPreds

nbWrong = abs(as.numeric(testData$decision_status)-as.numeric(testData$nbPred))
nbCountWrong = sum(nbWrong)

nbPlot = ggplot(testData) +
  geom_point(aes(x = actual_net_income_, y = credit_score, shape = nbPred, color = decision_status, size = as.factor(nbWrong))) +
  ggtitle('Naive Bayes Predictions')

nbPlot
