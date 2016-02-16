
# Write R code for writing out objects
dput(x,file="dumpfile.txt")

#========================================================
# Read all files in a directory into one dataframe

pollutantmean<-function(directory,id=1:332){
  # change to the requested directory
  home_wd<-getwd()
  setwd(directory)
  #debug print(getwd())
  #debug flush.console()
  
  # Construct data frame
  file_list <- list.files()
  #debug file_list_id <- as.numeric(substring(file_list,1,3)) 
  #debug files_processed<-0
  
  for (file in file_list){
    file_number <- as.numeric(substring(file,1,3))
    if (file_number %in% id){
      #debug files_processed<-append(files_processed, file_number)
      if (!exists("pollution_data")){
        pollution_data <- read.csv(file)
      }
      else if (exists("pollution_data")){
        temp_dataset <-read.csv(file)
        pollution_data<-rbind(pollution_data, temp_dataset)
        rm(temp_dataset)
      }
    }
  }
  
  #return to home directory
  setwd(home_wd)
  
  #debug return(files_processed)
  #debug return(id)
  #debug return(file_list_id)
  #debug return(file_list)
  #debug return(pollution_data)
}
#========================================================