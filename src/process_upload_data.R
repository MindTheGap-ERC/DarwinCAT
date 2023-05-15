process_upload_data = function(upload = NULL, 
                               sep = ",",
                               upload_mode = "Trait Values Only",
                               tvo_col_name = "val",
                               tatv_col_name_t = "time",
                               tatv_col_name_trait ="val",
                               rescale = FALSE){
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
      list("ts" = list(list(time = c(-2,-1),
                            val = c(-1,1))),
           "status" = "Status: Nothing Uploaded",
           "names" = "No names found"
           )
    )
  }
  
  uploaded_data = read.csv(
    file = upload$datapath, 
    sep = sep
  )
  
  rec_names = paste( names(uploaded_data), sep = " \n ", collapse = "\n")
  
  if (upload_mode == "Times and Trait Values"){


    if (! (tatv_col_name_t %in% names(uploaded_data)  ) | ! (tatv_col_name_trait %in% names(uploaded_data)  ) ){
      return(
        list("ts" = list(list(time = c(-2,-1),
                              val = c(-1,1))),
             "status" = "Status: Could not Find Columns with given Names",
             "names" = rec_names
             )
      )
    }
    trait_vals = uploaded_data[[tatv_col_name_trait]]
    times_ul = uploaded_data[[tatv_col_name_t]]
    if ( rescale == TRUE) {
      times_ul = times_ul - min(times_ul)
      times_ul = times_ul/max(times_ul)*max(time_myr)
    }
    return(
      list("ts" = list(list(time = times_ul,
                            val = trait_vals)),
           "status" = "Status: Uploaded Trait Values Successfully",
           "names" = rec_names
           )
    )
  }
  
  if (upload_mode == "Trait Values Only"){

    if (! tvo_col_name %in% names(uploaded_data) ){
      return(
        list("ts" = list(list(time = c(-2,-1),
                              val = c(-1,1))),
             "status" = "Status: Could not Find Column with given Name",
             "names" = rec_names
             )
      )
    }
    trait_vals = uploaded_data[[tvo_col_name]]
    return(
      list("ts" = list(list(time = seq(0, max(time_myr), length.out = length(trait_vals)),
                            val = trait_vals)),
           "status" = "Status: Uploaded Trait Values Successfully",
           "names" = rec_names)
    )
  }
  

  
}