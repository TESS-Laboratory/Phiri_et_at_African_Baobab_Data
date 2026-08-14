# A dataset of baobab trees and their comparators from across Africa

This repository contains the data and code used to reproduce the Quality Assurance and Quality Control Checks (QAQC) procedures, analyses and figures presented in:

> Chafika Phiri, Andrew M. Cunliffe, Sarah Venter, Aisha T. Bello, Alan D. Nare, Adler Santana Medeiros, Dawn Cory-Toussaint, Dave Hodgson, Kenneth F. Egbadzor, Lena Grieger, Nicholas Bii, Okopi Ade, & Tapiwa Gumbo. (Year). *Paper title*. Journal. DOI: https://doi.org/...

A permanent version of this repository is archived at [![DOI](https://zenodo.org/badge/DOI/...svg)](...)

Use of this code is licensed under [![Licence: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](...)

Contact Chafika Phiri at Email: cp844@exeter.ac.uk

---

## Project overview

Provide a brief overview of the project (approximately 2–4 sentences), including the research question or objective, the study system or data, and the purpose of the repository.

---

## Repository contents

The analysis is managed as a targets pipeline. Execution order is declared [Targets](https://books.ropensci.org/targets/)) and resolved automatically, so scripts are not numbered.

### Scripts

| Script | Description |
|---------|-------------|
| *_targets.R* | States each step and its dependencies. |
| *functions.R* | Helper functions called during data prepartion. |
| *Convert_Degrees_to_Decimal.R* | Conversion of coordinates from degrees–minutes–seconds to decimal degrees. |
| *QAQC_BAM_Data.qmd* | Performs all quality assurance and quality control checks, and writes the shareable dataset. |
| *Summary_Report_BAM.qmd* | Produces summary statistics, distribution maps and figures. |

### Data

| File | Description |
|------|-------------|
| *BAM_data_for_public.csv* | Cleaned dataset for public release. |

---

## Acknowledgements

We gratefully acknowledge financial support from Few and Far Collection within the Oppenheimer Programme in African Landscape Systems (OPALS) (https://opals-exeter.org/), which enabled Chafika Phiri's research.

## Getting started

Clone this repository and review the project overview and repository structure before running the analysis. 

TESS Lab projects typically use [renv](https://rstudio.github.io/renv/) to record package dependencies and software versions. 
Where an renv.lock file is included, restore the project environment before running any analyses:
```r
renv::restore()
```

## Running the analysis

Unless otherwise stated, scripts should be run in numerical order:

1. *Convert_Degrees_to_Decimal.R* 
2. *QAQC_BAM_Data.qmd*
3. *Summary_Report_BAM.qmd* 

---
