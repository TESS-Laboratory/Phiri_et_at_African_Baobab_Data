#-------------------------------------------------------------------------------
# Introduction
#-------------------------------------------------------------------------------

# This script is designed to convert latitude and longitude coordinates from 
# degrees, minutes, seconds (DMS) format to decimal degrees (DD) format. 
# The script handles two different formats of coordinate representation 
# found in the dataset to convert coordinates from degrees, minutes, seconds 
# (DMS) to decimal degrees (DD)

# load the required packages

library(tidyverse)
library(stringr)

# load the data 

venda_data <- readxl::read_excel(
  "C:/Workspace/Baobabs_in_Africa_Mapped/Baobab_Data_From_Dr_Sarah/Venda Data for Chafika V1.xlsx",
  sheet = 2
)

# venda_data

# Function to extract LATITUDE 

parse_lat <- function(lat_str, long_str) {
  
  if (grepl("°", lat_str)) {                          # Checks if the string contains "°"
    val <- as.numeric(                                 # Converts the extracted text to a number
      gsub(".*S([0-9.]+)°.*", "\\1", lat_str)         # Uses regex to capture digits after "S" and before "°"
    )                                                  # e.g. "S22.56392° E30.49024°" → "22.56392" → 22.56392
    return(-val)                                       # Returns negative because Southern hemisphere = negative latitude
  }
  
  # If no "°", it's the DMS format in a separate column
  dms <- trimws(gsub("[NSEW]", "", lat_str))           # Removes the "S" direction letter and trims whitespace
  parts <- strsplit(dms, "\\s+")[[1]]                  # Splits "22 28 56.7" into c("22", "28", "56.7")
  dd <- as.numeric(parts[1]) +                         # Degrees
    as.numeric(parts[2]) / 60 +                    # Minutes converted to degrees
    as.numeric(parts[3]) / 3600                    # Seconds converted to degrees
  return(-dd)                                          # Returns negative for Southern hemisphere
}


# Function to extract LONGITUDE 

parse_long <- function(lat_str, long_str) {
  
  if (grepl("°", lat_str)) {                          # Again checks for "°" 
    val <- as.numeric(                                 # Converts the extracted text to a number
      gsub(".*E([0-9.]+)°.*", "\\1", lat_str)         # Captures digits after "E" and before "°"
    )                                                  # e.g. "S22.56392° E30.49024°" → "30.49024" → 30.49024
    return(val)                                        # Returns positive because Eastern hemisphere = positive longitude
  }
  
  # If no "°", longitude is in its own separate column 
  dms <- trimws(gsub("[NSEW]", "", long_str))          # Removes the "E" direction letter and trims whitespace
  parts <- strsplit(dms, "\\s+")[[1]]                  # Splits "30 58 44.9" into c("30", "58", "44.9")
  dd <- as.numeric(parts[1]) +                         # Degrees
    as.numeric(parts[2]) / 60 +                    # Minutes converted to degrees
    as.numeric(parts[3]) / 3600                    # Seconds converted to degrees
  return(dd)                                           # Returns positive for Eastern hemisphere
}


# Apply both functions to the dataframe 

venda_dataframe <- venda_data |>                      # Passes venda_data into the pipeline
  mutate(                                              # Creates new columns while keeping all existing ones
    Latitude_DD  = mapply(parse_lat,                   # mapply() applies parse_lat row-by-row with TWO inputs
                          `Lat - South`,               # First input: the Lat - South column
                          `Long - East`),              # Second input: the Long - East column 
    
    Longitude_DD = mapply(parse_long,                  # Same approach for longitude
                          `Lat - South`, 
                          `Long - East`)
  )

# view(venda_dataframe)

# save as a csv file

write_csv(venda_dataframe, "C:/Workspace/Baobabs_in_Africa_Mapped/Data/Excel_Files/Venda Data for Chafika V1.csv")