# Georeferenced individual tree-level physical traits and condition observations of African baobabs and comparator trees.

This respository contains the data and code used to process and analyse community-contributed Baobab in Africa Mapped (BAM) dataset. It provides the resources needed to reproduce the quality control checks (QAQC) procedures, the figures, and tables presented in the following publication: 

> Chafika Phiri, Andrew M. Cunliffe, Sarah Venter, Okopi Ade, Aisha T. Bello, Nicholas Bii, Dawn Cory-Toussaint, Francis Chitsa, Kenneth F. Egbadzor, Tapiwa Gumbo, Lena Grieger, Dave Hodgson, Michelle Hurley, Steven Khosa, Justice Muvengwi, Alan D. Nare, Adler Santana Medeiros. (Year). *Paper title*. Journal. DOI: https://doi.org/...

A permanent version of this repository is archived at [![DOI](https://zenodo.org/badge/DOI/...svg)](...)

Use of this code is licensed under [![Licence: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](...)

Contact Chafika Phiri at Email: cp844@exeter.ac.uk

---

## Project overview

The Baobab in Africa Mapped (BAM) project aims to create an open-source, community-contributed dataset on the distribution and condition of African baobab trees. This dataset provides a valuable foundation for geospatial investigations of baobab distribution and condition, enabling assessments of their responses to environmental drivers, comparisons with co-occurring species, and evaluations of conservation effectiveness. Furthermore, it contributes to improving the representation of African landscapes within openly accessible ecological datasets. The dataset is harmonised, quality checked, and made available for public use.

---

## Repository contents

### Scripts

| Script | Description |
|---------|-------------|
| *harmonise_tree_data.R* | Reads individual contributor files and harmonises their column names and variables against the BAM variable dictionary. |
| *TRY_cross_check.R* | Identifies potential duplicate records by cross-referencing all *Adansonia* observations in the TRY database (Version 7) against the harmonised BAM baobab records. |
| *QAQC_BAM_Data.qmd* | Performs comprehensive quality assurance and quality control (QA/QC) checks and generates the final, shareable dataset. |
| *Summary_Report_BAM.qmd* | Generates summary statistics, spatial distribution maps, and visualisations to provide an overview of the BAM datase. |
| *environmental_covariates.R* | Extracts environmental covariates for every unique baobab location, including climate, soil, topography, and protected-area status. |

### Data

| File | Description |
|------|-------------|
| *BAM_data_for_public.csv* | Cleaned dataset for public release. |

---

## Acknowledgements

We gratefully acknowledge financial support from Few and Far Collection within the Oppenheimer Programme in African Landscape Systems (OPALS) (https://opals-exeter.org/), which made this research possible. We sincerely thank landowners at Kremetart, Bahiti, ZZ2, Francois Pauer, South African National Parks (SANParks) and all their neighbours for granting permission to conduct fieldwork on their properties. 

## Getting started

Clone this repository and review the project overview and repository structure before running the analysis. 

TESS Lab projects typically use [renv](https://rstudio.github.io/renv/) to record package dependencies and software versions. 
Where an renv.lock file is included, restore the project environment before running:

```r
renv::restore()
```

## Running the analysis

Scripts should be run in numerical order:

1. *harmonise_tree_data.R* 
2. *TRY_cross_check.R*
3. *QAQC_BAM_Data.qmd*
4. *Summary_Report_BAM.qmd*
5. *environmental_covariates.R*

---
