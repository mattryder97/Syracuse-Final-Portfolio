library(readxl)

projectdata = read_xlsx('D:/Fall 2020/IST 687- Intro to Data Science/projectdata.xlsx')

str(projectdata)
colnames(projectdata)

projectdata$loan_application_date = as.Date(projectdata$loan_application_date)
projectdata$person_birthdate = as.Date(projectdata$person_birthdate)
projectdata$person_marital_status = as.factor(projectdata$person_marital_status)
projectdata$person_gender = as.factor(projectdata$person_gender)
projectdata$person_degree_type_desc = as.factor(projectdata$person_degree_type_desc)
projectdata$person_employment_type_desc = as.factor(projectdata$person_employment_type_desc)
projectdata$industry = as.factor(projectdata$industry)

for (i in 1:nrow(projectdata)){
  if(projectdata$decision_status[i] == "Credit score below minimum"){
    projectdata$decision_status[i] = "Denied"
  }
  else if(projectdata$decision_status[i] == "Financial credit denied"){
    projectdata$decision_status[i] = "Denied"
  }
  else if(projectdata$decision_status[i] == "Monthly debt capacity below minimum"){
    projectdata$decision_status[i] = "Denied"
  }
  else {projectdata$decision_status[i] = "Approved"}
}
projectdata$decision_status = as.factor(projectdata$decision_status)
projectdata$loan_disbursement_date = as.Date(projectdata$loan_disbursement_date)
projectdata$first_repayment_date = as.Date(projectdata$first_repayment_date)
projectdata$Locations = as.factor(projectdata$Locations)

projectdata$age = as.numeric(round(difftime(projectdata$loan_application_date, projectdata$person_birthdate, units = "days")/365.25, digits = 0))

names(projectdata) <- sub("(in dollars)", "", names(projectdata))
names(projectdata) <- sub("(in months)", "", names(projectdata))
names(projectdata) <- sub(" ", "_", names(projectdata))
names(projectdata) <- sub("\\(\\)", "", names(projectdata))
names(projectdata) <- sub("\\(", "", names(projectdata))
names(projectdata) <- sub('_)', '', names(projectdata))
colnames(projectdata)

str(projectdata)
