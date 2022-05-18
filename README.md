# `gwverse`: a template for a new generic Geographically Weighted R package

Alexis Comber<sup>1*</sup>, Martin Callghan<sup>2</sup>, Paul Harris<sup>3</sup>, Binbin Lu<sup>4</sup>, Nick Malleson<sup>1</sup> and Chris Brunsdon<sup>5</sup>

<sup>1</sup> School of Geography, University of Leeds, Leeds, UK.\
<sup>2</sup> School of Computing, University of Leeds, Leeds, UK.\
<sup>3</sup> Sustainable Agriculture Sciences North Wyke, Rothamsted Research, Okehampton, UK.\
<sup>4</sup> School of Remote Sensing and Information Engineering, Wuhan University, Wuhan, China.\
<sup>5</sup> National Centre for Geocomputation, Maynooth University, Maynooth, Ireland.\\

<sup>*</sup> contact author: a.comber@leeds.ac.uk




# Abstract
GWR is a popular approach for investigating the spatial variation in relationships between response and predictor variables, and critically for investigating and understanding process spatial heterogeneity. The geographically weighted (GW) framework is increasingly used to accommodate different types of models and analyses, reflecting a wider desire to explore spatial variation in model parameters and outputs. However, the growth in the use of GWR and different GW models has only been partially supported by package development in both R and Python, the major coding environments for spatial analysis. The result is that refinements have been inconsistently included within GWR and GW functions in any given package. This paper outlines the structure of a new `gwverse` package, that may over time replace `GWmodel`, that takes advantage of recent developments in the composition of complex, integrated packages. It conceptualises `gwverse` as having a modular structure, that separates core GW functionality and applications such as GWR. It adopts a function factory approach, in which bespoke functions are created and returned to the user based on user-defined parameters. The paper introduces two demonstrator modules that can be used to undertake GWR and identifies a number of key considerations and next steps. 

# Code
To run the analysis in this paper you should download the the R script `GA_code_git.R` and install the packages. Package and other info is below. The data are pulled from the GitHub site. The code recreates the results as the same sequence in the paper.

If you have any problems with data / code / versions etc please contact Lex Comber at the email above.
