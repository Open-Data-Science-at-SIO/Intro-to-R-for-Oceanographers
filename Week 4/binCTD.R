
binCTD <- function(file.loc, bin.size){
  
  # Function to combine CTD cast data and average by a specified bin size
  # file.loc: path where .csv files from CTD casts are stored
  # bin.size: size of depth bins (m) data should be averaged in
  # Returns a data frame of averaged salinity, temp, and fluorescence data
  
  file.names <- list.files(file.loc) # name all files within file.loc
  
  data <- data.frame() # initialize a data frame
  
  for (f in file.names){ # we're going to loop through each CTD file
    
    cast <- read.csv(paste(file.loc, f, sep="")) # read in the first CTD file
    bins <- seq(0, max(cast$Depth), by=bin.size) # set up bins
  
    for (d in 1:(length(bins)-1)){ # now loop through each bin size
      
      i <- which(cast$Depth>=bins[d] & cast$Depth<bins[d+1]) # obs in that bin
      
      # create a new data frame row for bin d and cast f
      nd <- data.frame("Cast.ID" = unlist(strsplit(f, "[.]"))[1], # cast name
                       "Depth.Bin" = bins[d], # bin start
                       "Avg.Sal" = mean(cast$SaltAve_Corr[i]),
                       "Avg.Temp" = mean(cast$TempAve[i]),
                       "Avg.Fluor" = mean(cast$FluorV[i]))
      
      data <- rbind(data, nd) # append this new row onto the results df
      
    } # end d
    
  } # end f
  
  return(data) # return the data frame 
  
} # end function
