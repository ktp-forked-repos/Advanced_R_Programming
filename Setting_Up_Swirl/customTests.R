# Get the swirl state
getState <- function(){
  # Whenever swirl is running, its callback is at the top of its call stack.
  # Swirl's state, named e, is stored in the environment of the callback.
  environment(sys.function(1))$e
}

# Get the value which a user either entered directly or was computed
# by the command he or she entered.
getVal <- function(){
  getState()$val
}

# Get the last expression which the user entered at the R console.
getExpr <- function(){
  getState()$expr
}

coursera_on_demand <- function(){
  selection <- getState()$val
  if(selection == "Yes"){
    email <- readline("What is your email address? ")
    token <- readline("What is your assignment token? ")
    
    payload <- sprintf('{  
                       "assignmentKey": "PL3Db49VEea2YhJ0DzyiSg",
                       "submitterEmail": "%s",  
                       "secret": "%s",  
                       "parts": {
                       "Vv9SG": {  
                       "output": "correct"  
                       },
                       "NGfmh": {  
                       "output": "incorrect"  
                       }
                       }  
  }', email, token)
    url <- 'https://www.coursera.org/api/onDemandProgrammingScriptSubmissions.v1'
    
    respone <- httr::POST(url, body = payload)
    if(respone$status_code >= 200 && respone$status_code < 300){
      message("Grade submission succeeded!")
    } else {
      message("Grade submission failed.")
      message("Press ESC if you want to exit this lesson and you")
      message("want to try to submit your grade at a later time.")
      return(FALSE)
    }
} else if(selection == "No"){
  return(TRUE)
} else {
  message("Submit the following code as the answer")
  message("to a quiz question on Coursera.\n")
  message("#########################\n")
  message(keygen(), "\n")
  message("#########################")
  return(TRUE)
}
  }