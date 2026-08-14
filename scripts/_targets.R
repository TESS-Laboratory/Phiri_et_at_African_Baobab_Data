# ==============================================================================
# _targets.R

# This is the control file for the {targets} pipeline. 

# The file has three jobs, in this order:
#   1. Load the packages the pipeline itself needs.
#   2. Set required packages the codes needs.
#   3. Lists targets. That list is the pipeline.

# Important: Do not run this script, but only run tar_make() in the console, and 
# targets reads this file.
# ==============================================================================


# ------------------------------------------------------------------------------
# Packages required by the pipeline itself. These packages are loaded 
# automatically 
# ------------------------------------------------------------------------------

library(targets)      
library(tarchetypes)  


# ------------------------------------------------------------------------------
# packages required by the code, but not the pipeline itself.
# ------------------------------------------------------------------------------

tar_option_set(
  packages = c(          
    "tidyverse",         
    "readxl",            
    "writexl",           
    "sf",                
    "rnaturalearth",     
    "rnaturalearthdata", 
    "knitr",             
    "janitor",           
    "WorldFlora",        # Species-name harmonisation against the WFO backbone
    "fuzzyjoin",         # Approximate joins used in the species matching
    "tools",             # file_ext(), used in the photo-renaming step
    "patchwork"          
  ),
  format = "rds"         
)


# ------------------------------------------------------------------------------
# Load helper functions
# ------------------------------------------------------------------------------

tar_source("R")


# ------------------------------------------------------------------------------
# The pipeline itself
# ------------------------------------------------------------------------------

list(
  
  # ----------------------------------------------------------------------------
  # TARGET 1: raw_input_files
  
  # Registers every raw data file the QAQC report reads.
  # ----------------------------------------------------------------------------
  
  tar_target(
    name    = raw_input_files,
    command = c(
      "Data/raw/BAM_Data_from_Kobo.xlsx",
      "Data/Excel_Files/Adansonia digitata_Togo_cleaned_coordinates.xlsx",
      "Data/Excel_Files/Kremetart_Data.xlsx",
      "Data/Excel_Files/Mapungubwe_Data.xlsx",
      "Data/Excel_Files/Big Tree Data from Kobo.xlsx",
      "Data/Excel_Files/Venda Data for Chafika V1.xlsx",
      "Data/WFO/classification.csv"
    ),
    format  = "file"
  ),
  
  
  # ----------------------------------------------------------------------------
  # TARGET 2: venda_source_file
  # The single Venda workbook, tracked separately because the coordinate
  # conversion depends on it alone. 
  # ----------------------------------------------------------------------------
  
  tar_target(
    name    = venda_source_file,
    command = "Data/raw/Venda_Data_Original.xlsx",
    format  = "file"
  ),
  
  
  
  # ----------------------------------------------------------------------------
  # TARGETS 3 and 4: qaqc_document and summary_document
  # ----------------------------------------------------------------------------
  
  tar_target(
    name    = qaqc_document,
    command = "QAQC_BAM_Data.qmd",
    format  = "file"
  ),
  
  tar_target(
    name    = summary_document,
    command = "Summary_Report_BAM.qmd",
    format  = "file"
  ),
  
  
  # ----------------------------------------------------------------------------
  # TARGET 5: venda_decimal_degrees_file
  # Runs your coordinate-conversion script. 
  # ----------------------------------------------------------------------------
  
  tar_target(
    name    = venda_decimal_degrees_file,
    command = convert_venda_coordinates(
      input_path  = venda_source_file,
      output_path = "Data/Excel_Files/Venda_Data_Decimal_Degrees.csv"
    ),
    format  = "file"
  ),
  
  
  # ----------------------------------------------------------------------------
  # TARGET 6: qaqc_report
  # Renders the QAQC document. 
  # ----------------------------------------------------------------------------
  
  tar_target(
    name    = qaqc_report,
    command = {
      raw_input_files                                  
      qaqc_document                                    
      quarto::quarto_render("QAQC_BAM_Data.qmd")       
      "QAQC_BAM_Data.pdf"                              
    },
    format  = "file"
  ),
  
  
  # ----------------------------------------------------------------------------
  # TARGET 7: public_data_file
  # The cleaned CSV that the QAQC report writes to Data/outputs/ and renders the
  # report as pdf
  # ----------------------------------------------------------------------------
  
  tar_target(
    name    = public_data_file,
    command = {
      qaqc_report                              
      "Data/outputs/BAM_data_for_public.csv"  
    },
    format  = "file"
  ),
  
  
  # ----------------------------------------------------------------------------
  # TARGET 8: renders summary_report as pdf
  # ----------------------------------------------------------------------------
  
  tar_target(
    name    = summary_report,
    command = {
      public_data_file                                    
      summary_document                                    
      quarto::quarto_render("Summary_Report_BAM.qmd")     
      "Summary_Report_BAM.pdf"                            
    },
    format  = "file"
  )
  
)