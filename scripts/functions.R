# ------------------------------------------------------------------------------
# R/functions.R
# ------------------------------------------------------------------------------

# this script is used to independently convert the excel spreadsheet coordinates
# recorded in other formats to decimal degrees

# ------------------------------------------------------------------------------
# This section converts one latitude entry to decimal degrees.
# ------------------------------------------------------------------------------

parse_lat <- function(lat_str, long_str) {
  
  if (grepl("°", lat_str)) {                       
    val <- as.numeric(                             
      gsub(".*S([0-9.]+)°.*", "\\1", lat_str)      
    )
    return(-val)                                   
  }
  
  dms   <- trimws(gsub("[NSEW]", "", lat_str))     
  parts <- strsplit(dms, "\\s+")[[1]]              
  dd    <- as.numeric(parts[1]) +                 
    as.numeric(parts[2]) / 60 +                    
    as.numeric(parts[3]) / 3600                    
  return(-dd)                                      
}


# ------------------------------------------------------------------------------
# This section converts one longitude entry to decimal degrees.
# ------------------------------------------------------------------------------

parse_long <- function(lat_str, long_str) {
  
  if (grepl("°", lat_str)) {                       
    val <- as.numeric(                             
      gsub(".*E([0-9.]+)°.*", "\\1", lat_str)      
    )
    return(val)                                   
  }
  
  dms   <- trimws(gsub("[NSEW]", "", long_str))    
  parts <- strsplit(dms, "\\s+")[[1]]              
  dd    <- as.numeric(parts[1]) +                  
    as.numeric(parts[2]) / 60 +                    
    as.numeric(parts[3]) / 3600                    
  return(dd)                                       
}


# ------------------------------------------------------------------------------

# This section reads the Venda spreadsheet, adds the two decimal-degree
# columns, writes the result to a CSV, and returns the path of that CSV.

# ------------------------------------------------------------------------------

convert_venda_coordinates <- function(input_path, output_path) {
  
  venda_data <- readxl::read_excel(                
    input_path,                                    
    sheet = 2                                      
  )
  
  venda_dataframe <- venda_data |>                 
    dplyr::mutate(                                 
      Latitude_DD  = mapply(parse_lat,             
                            `Lat - South`,
                            `Long - East`),
      Longitude_DD = mapply(parse_long,            
                            `Lat - South`,
                            `Long - East`)
    )
  
  dir.create(                                      
    dirname(output_path),                          
    recursive  = TRUE,                             
    showWarnings = FALSE                           
  )
  
  readr::write_csv(venda_dataframe, output_path)   # Writes the CSV
  
  output_path                                      
}