convert_input_data = function(data, 
                              header = TRUE,
                              separator = ";",
                              quote = "",
                              col_name_time = "t",
                              col_name_trait = "val") {
  if (is.null(data)){
trait_list = list()
  }
  


  df <- read.csv(file = data,
                header = input$header,
                sep = input$sep,
                quote = input$quote)
  
  if (header == TRUE){
    trait_list = list(time = df[col_name_time],
                      val = df[col_name_trait])
  }
  if (header == FALSE){
    trait_list = list(time = df[,1],
                      val = df[,2])
  }

  
  return(trait_list)
  
}