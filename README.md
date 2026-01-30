# Application Exercise RSE INBO
This repository contains the source code (R script: exercise_RSE_INBO.R) which contains my solution for the exercise.

## Instructions
The R script expects the user to enter their working directory at line 11:
```
# Set working directory to folder containing provided data
## The data is expected to be in a folder named "data" within the working directory
## Please change this to your own relevant working directory
setwd("ENTER WORKING DIRECTORY")
```
The working directory is expected to contain a folder names "data", which contains the data folders provided for the exercise:
```
Working directory/
└── data/
    ├── poc_0.9.0
    ├── poc_0.10.0
    ├── poc_0.11.0
    ├── poc_0.12.0
    ├── poc_0.13.0
    ├── poc_0.13.1
    └── poc_0.13.0
```
## Expected output
The code should succesfully reproduce generation of following plot:

## Session Info
```
R version 4.5.2 (2025-10-31 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 26100)

Matrix products: default
  LAPACK version 3.12.1

locale:
[1] LC_COLLATE=English_Belgium.utf8  LC_CTYPE=English_Belgium.utf8    LC_MONETARY=English_Belgium.utf8
[4] LC_NUMERIC=C                     LC_TIME=English_Belgium.utf8    

time zone: Europe/Brussels
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] forcats_1.0.1 tidyr_1.3.2   ggplot2_4.0.1 dplyr_1.1.4   n2khab_0.13.0

loaded via a namespace (and not attached):
 [1] gtable_0.3.6       git2rdata_0.5.1    compiler_4.5.2     tidyselect_1.2.1   Rcpp_1.1.1        
 [6] stringr_1.6.0      git2r_0.36.2       assertthat_0.2.1   scales_1.4.0       yaml_2.3.12       
[11] R6_2.6.1           plyr_1.8.9         generics_0.1.4     curl_7.0.0         classInt_0.4-11   
[16] sf_1.0-24          tibble_3.3.1       units_1.0-0        rprojroot_2.1.1    DBI_1.2.3         
[21] RColorBrewer_1.1-3 pillar_1.11.1      rlang_1.1.7        stringi_1.8.7      S7_0.2.1          
[26] cli_3.6.5          withr_3.0.2        magrittr_2.0.4     class_7.3-23       grid_4.5.2        
[31] remotes_2.5.0      lifecycle_1.0.5    vctrs_0.7.1        KernSmooth_2.23-26 proxy_0.4-29      
[36] glue_1.8.0         farver_2.1.2       e1071_1.7-17       purrr_1.2.1        tools_4.5.2       
[41] pkgconfig_2.0.3
```
