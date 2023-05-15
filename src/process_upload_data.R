process_upload_data <- function(
    upload = NULL,
    sep = ",",
    upload_mode = "Trait Values Only",
    tvo_col_name = "val",
    tatv_col_name_t = "time",
    tatv_col_name_trait = "val",
    rescale = FALSE) {
  #' @title process_upload_data
  #'
  #' @description
  #' preprocesses and checks user uploads
  #' @param upload data passed on by the
  #' @param sep separator for csv file
  #' @param upload_mode character, whether only traits or times & traits are uploaded
  #' @param tvo_col_name character, col name when only traits are uploaded
  #' @param tatv_col_name_t character, col name for time when time and traits are uploaded
  #' @param tatv_col_name_trait character, col name for ttrait values when time and traits are uploaded
  #' @param rescale logical, if traits and time are uploaded, should the times be rescaled to match the timescale of observation?
  #'
  #' @returns a list with three elements. first is a "ts" that can be transformed by
  #' the function transform_ts, second is a "status" message, third "names" foudn in the uploaded file
  #'
  
  default_ts = list(list(
    time = c(-2, -1),
    val = c(-1, 1)
  ))
  # if no file is uploaded
  if (is.null(upload)) {
    return(
      list(
        "ts" = default_ts,
        "status" = "Status: Nothing uploaded",
        "names" = "No names found"
      )
    )
  }

  uploaded_data <- read.csv(
    file = upload$datapath,
    sep = sep
  )

  # names found in uploaded file
  rec_names <- paste(names(uploaded_data), sep = " \n ", collapse = "\n")


  if (upload_mode == "Times and Trait Values") {
    if (! tatv_col_name_t %in% names(uploaded_data) ) {
      return(
        list(
          "ts" = default_ts,
          "status" = "Status: Could not find column with time",
          "names" = rec_names
        )
      )
    }
    
    if (! tatv_col_name_trait %in% names(uploaded_data)) {
      return(
        list(
          "ts" = default_ts,
          "status" = "Status: Could not find column with traits",
          "names" = rec_names
        )
      )
    }
    
    
    trait_vals <- uploaded_data[[tatv_col_name_trait]]
    times_ul <- uploaded_data[[tatv_col_name_t]]
    if (rescale == TRUE) {
      times_ul <- times_ul - min(times_ul)
      times_ul <- times_ul / max(times_ul) * max(time_myr)
    }
    return(
      list(
        "ts" = list(list(
          time = times_ul,
          val = trait_vals
        )),
        "status" = "Status: Uploaded trait values successfully",
        "names" = rec_names
      )
    )
  }

  if (upload_mode == "Trait Values Only") {
    if (!tvo_col_name %in% names(uploaded_data)) {
      return(
        list(
          "ts" = default_ts,
          "status" = "Status: Could not find columns with the provided name",
          "names" = rec_names
        )
      )
    }
    trait_vals <- uploaded_data[[tvo_col_name]]
    return(
      list(
        "ts" = list(list(
          time = seq(0, max(time_myr), length.out = length(trait_vals)),
          val = trait_vals
        )),
        "status" = "Status: Uploaded trait values successfully",
        "names" = rec_names
      )
    )
  }
}
