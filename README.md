# `gwverse`: a template for a new generic Geographically Weighted R package

Alexis Comber<sup>1*</sup>, Martin Callghan<sup>2</sup>, Paul Harris<sup>3</sup>, Binbin Lu<sup>4</sup>, Nick Malleson<sup>1</sup> and Chris Brunsdon<sup>5</sup>

<sup>1</sup> School of Geography, University of Leeds, Leeds, UK.\
<sup>2</sup> School of Computing, University of Leeds, Leeds, UK.\
<sup>3</sup> Sustainable Agriculture Sciences North Wyke, Rothamsted Research, Okehampton, UK.\
<sup>4</sup> School of Remote Sensing and Information Engineering, Wuhan University, Wuhan, China.\
<sup>5</sup> National Centre for Geocomputation, Maynooth University, Maynooth, Ireland.

<sup>*</sup> contact author: a.comber@leeds.ac.uk




# Abstract
GWR is a popular approach for investigating the spatial variation in relationships between response and predictor variables, and critically for investigating and understanding process spatial heterogeneity. The geographically weighted (GW) framework is increasingly used to accommodate different types of models and analyses, reflecting a wider desire to explore spatial variation in model parameters and outputs. However, the growth in the use of GWR and different GW models has only been partially supported by package development in both R and Python, the major coding environments for spatial analysis. The result is that refinements have been inconsistently included within GWR and GW functions in any given package. This paper outlines the structure of a new `gwverse` package, that may over time replace `GWmodel`, that takes advantage of recent developments in the composition of complex, integrated packages. It conceptualises `gwverse` as having a modular structure, that separates core GW functionality and applications such as GWR. It adopts a function factory approach, in which bespoke functions are created and returned to the user based on user-defined parameters. The paper introduces two demonstrator modules that can be used to undertake GWR and identifies a number of key considerations and next steps. 

The paper has been submitted to Geographical Analysis and will be Open Access if accepted for publication. Details to follow when published. 

# Code
To run the analysis in this paper you should download the the R script `GA_code_git.R` and install the packages. Package and other info is below. The data are pulled from the GitHub site. The code recreates the results as the same sequence in the paper.

If you have any problems with data / code / versions etc please contact Lex Comber at the email above.

```{r}
> sessionInfo()
R version 4.2.0 (2022-04-22)
Platform: x86_64-apple-darwin17.0 (64-bit)
Running under: macOS Big Sur 11.4

Matrix products: default
BLAS:   /Library/Frameworks/R.framework/Versions/4.2/Resources/lib/libRblas.0.dylib
LAPACK: /Library/Frameworks/R.framework/Versions/4.2/Resources/lib/libRlapack.dylib

locale:
[1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] RColorBrewer_1.1-3 rlang_1.0.2        gwregr_0.0.1      
 [4] gw_0.0.3           sf_1.0-7           devtools_2.4.3    
 [7] usethis_2.1.5      repmis_0.5         jsonlite_1.8.0    
[10] RCurl_1.98-1.6     dlstats_0.1.5      forcats_0.5.1     
[13] stringr_1.4.0      dplyr_1.0.9        purrr_0.3.4       
[16] readr_2.1.2        tidyr_1.2.0        tibble_3.1.6      
[19] ggplot2_3.3.6      tidyverse_1.3.1    kableExtra_1.3.4  
[22] knitr_1.39        

loaded via a namespace (and not attached):
 [1] nlme_3.1-157       bitops_1.0-7       fs_1.5.2          
 [4] lubridate_1.8.0    webshot_0.5.3      httr_1.4.2        
 [7] rprojroot_2.0.3    R.cache_0.15.0     tools_4.2.0       
[10] backports_1.4.1    utf8_1.2.2         R6_2.5.1          
[13] KernSmooth_2.23-20 DBI_1.1.2          mgcv_1.8-40       
[16] colorspace_2.0-3   withr_2.5.0        prettyunits_1.1.1 
[19] processx_3.5.3     tidyselect_1.1.2   curl_4.3.2        
[22] compiler_4.2.0     cli_3.3.0          rvest_1.0.2       
[25] xml2_1.3.3         desc_1.4.1         labeling_0.4.2    
[28] scales_1.2.0       classInt_0.4-3     proxy_0.4-26      
[31] callr_3.7.0        systemfonts_1.0.4  digest_0.6.29     
[34] rmarkdown_2.14     svglite_2.1.0      R.utils_2.11.0    
[37] pkgconfig_2.0.3    htmltools_0.5.2    sessioninfo_1.2.2 
[40] dbplyr_2.1.1       fastmap_1.1.0      readxl_1.4.0      
[43] rstudioapi_0.13    farver_2.1.0       generics_0.1.2    
[46] R.oo_1.24.0        magrittr_2.0.3     s2_1.0.7          
[49] Matrix_1.4-1       Rcpp_1.0.8.3       munsell_0.5.0     
[52] fansi_1.0.3        lifecycle_1.0.1    R.methodsS3_1.8.1 
[55] stringi_1.7.6      brio_1.1.3         pkgbuild_1.3.1    
[58] plyr_1.8.7         grid_4.2.0         crayon_1.5.1      
[61] lattice_0.20-45    haven_2.4.3        splines_4.2.0     
[64] hms_1.1.1          ps_1.7.0           pillar_1.7.0      
[67] pkgload_1.2.4      wk_0.6.0           reprex_2.0.1      
[70] glue_1.6.2         evaluate_0.15      remotes_2.4.2     
[73] data.table_1.14.2  modelr_0.1.8       vctrs_0.4.1       
[76] tzdb_0.3.0         testthat_3.1.3     cellranger_1.1.0  
[79] gtable_0.3.0       assertthat_0.2.1   cachem_1.0.6      
[82] xfun_0.30          broom_0.8.0        e1071_1.7-9       
[85] class_7.3-20       viridisLite_0.4.0  memoise_2.0.1     
[88] units_0.8-0        ellipsis_0.3.2    
```
