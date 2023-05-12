process_upload_data = function(upload = NULL){
  #' @title process_upload_data
  #' 
  #' @description
    #' preprocesses and checks user uploads
  #' @param upload data passed on by the  
  #' 
  #' @returns a list with two elements. first is a ts that can be transformed by 
  #' the function transform_ts, second is a status message
  #' 
  
  if (is.null(upload)){
    return(
      list("ts" = list(list(time = range(time_myr),
                            val = c(-1,1))),
           "status" = "Nothing Uploaded")
    )
  }

  return(
    list("ts" = list(list(time = c(0),
                     val = c(0))))
  )
  
}