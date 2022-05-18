# `gwverse`: a template for a new generic Geographically Weighted R package
Alexis Comber^1^*, Martin Callaghan^1^, Paul Harris^2^, Binbin Lu^3^, Nick Malleson^1^ and Chris Brunsdon^4^
output:
  pdf_document: 
    keep_tex: True
bibliography: gw_SI_paper.bib
---

^1^ University of Leeds, UK

^2^ Rothamsted Research, UK

^3^ Wuhan University, China

^4^ Maynooth University, Ireland

\* Email:  a.comber@leeds.ac.uk 

# Abstract
GWR is a popular approach for investigating the spatial variation in relationships between response and predictor variables, and critically for investigating and understanding process spatial heterogeneity. The geographically weighted (GW) framework is increasingly used to accommodate different types of models and analyses, reflecting a wider desire to explore spatial variation in model parameters and outputs. However, the growth in the use of GWR and different GW models has only been partially supported by package development in both R and Python, the major coding environments for spatial analysis. The result is that refinements have been inconsistently included within GWR and GW functions in any given package. This paper outlines the structure of a new `gwverse` package, that may over time replace `GWmodel`, that takes advantage of recent developments in the composition of complex, integrated packages. It conceptualises `gwverse` as having a modular structure, that separates core GW functionality and applications such as GWR. It adopts a function factory approach, in which bespoke functions are created and returned to the user based on user-defined parameters. The paper introduces two demonstrator modules that can be used to undertake GWR and identifies a number of key considerations and next steps. 
