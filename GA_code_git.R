### Title: "`gwverse`: a template for a new generic Geographically Weighted R package"
## Lex Comber, University of Leeds, a.comber@leeds.ac.uk
## May 2022

# load packages
library(knitr)
library(kableExtra)
library(tidyverse)
library(dlstats)
library(RCurl)
library(jsonlite)
library(tidyverse)
library(repmis)

# Figure 1
# load scopus data  
source_data("https://github.com/gwverse/gwverseGAPaper/blob/main/scopus.RData?raw=True")
# or if saved locally then set your working director then load
# load("scopus.RData")
P1 <- df %>% 
  filter(Year > 1995 & Year < 2022) %>% 
  group_by(Year) %>% 
  summarise(`Annual Publication Count` = n()) %>%
  ggplot(mapping = aes(x = Year, y = `Annual Publication Count`)) + 
  geom_bar(stat="identity")
P1 +theme_bw()

# get CRAN and BioConductor data: used in manuscript text
x <-cran_stats(c("spgwr", "GWmodel", "McSpatial", "lctools"))
pkgs = c("spgwr", "GWmodel", "McSpatial", "lctools")
y <- bioc_stats(pkgs)
y %>% filter(package == "GWmodel") %>% summarise(t = sum(downloads)) -> bio.downloads

# Figure 2
# get CRAN downloads - this will take a bit of time
date.start = seq(as.Date("2013-01-01"),length=(9*12)+1,by="months")
date.end = date.start[-1]-1
date.start = date.start[-length(date.start)]
for (i in 1:length(date.end)){
  url = paste0("https://cranlogs.r-pkg.org/downloads/total/", date.start[i], ":", date.end[i], "/GWmodel")
  data.i <- getForm(url)
  # convert to data frame
  data.i <- fromJSON(data.i)
  if (i == 1) res = data.i
  if (i > 1) res = rbind(res, data.i)
}
P2 <- 
  res %>% mutate(start = as.Date(start), end = as.Date(end)) %>% 
  mutate(mid = start + (end-start)/2) %>% 
  ggplot(aes(x = mid, y = downloads, group = 1)) +
  geom_line(lty = 2, col = "indianred") + 
  geom_smooth(method = "gam", col = "firebrick3") + 
  theme_bw() +
  ylab("Downlaods") + xlab("") + 
  scale_x_date(breaks = seq(as.Date("2013-01-16"), as.Date("2022-01-16"), by="6 months"), date_labels = "%b\n%Y")
P2

## for use in text
cran.downloads = sum(res$downloads)
tot.downloads = as.vector(unlist(bio.downloads +cran.downloads))

## Table 1
source_data("https://github.com/gwverse/gwverseGAPaper/blob/main/GWmodel_func.RData?raw=True")
# or if saved locally then set your working director then load
# load("GWmodel_func.RData")
names(df) = gsub("\\.", " ", names(df))
index = t(apply(df, 1, function(x) is.na(x)))
df[index] = "-"
x = knitr::kable(df,
             caption = "The presence of GWmodel package functionality by the main groups of related specification options, where applicable.",
             format="latex", booktabs=TRUE, linesep = "" ) %>% 
  column_spec(2:6, width = "2cm") #%>%
  #kable_styling(latex_options="scale_down")
add_footnote(x, "* for mean/median only", notation = "none")

## Figure 3 uses the \usetikzlibrary tex package and is not repeated here 
## load gwverse modules
library(devtools)
install_github("gwverse/gw")
install_github("gwverse/gwregr")
library(gwregr)
data(liudaogou)

# define single bw function
gwr_bw_func = gw_single_bw_gwr(liudaogou, adaptive=TRUE, kernel="bisquare", eval="AIC")
# regression formula
formula = as.formula(TNPC ~ SOCgkg + ClayPC + SiltPC  + NO3Ngkg + NH4Ngkg) 
# apply them
gwr_bw_func(bw =100, formula)	

# examine environments
library(rlang)
# environments
env_print(gwr_bw_func)
fn_env(gwr_bw_func)$weight_func

## Finding the GWR bandwidth
# Optimise
opt = optimise(gwr_bw_func, c(10,nrow(liudaogou)), formula=formula, maximum=FALSE)
opt
# Linear search 
# create a vector of adaptive bandwidths
bws_adaptive = 10:nrow(liudaogou)
# apply the function to vector of bandwidths 
bws_res = sapply(bws_adaptive, function(x) gwr_bw_func(x, formula))
bws_adaptive[which.min(bws_res)]

## Figure 4
tibble(AIC = bws_res, bw = bws_adaptive) %>%
  ggplot(aes(x = bw, y = AIC)) +
  geom_line() + xlab("Adaptive Bandwidth") +
  geom_vline(xintercept=bws_adaptive[which.min(bws_res)], col = "red") +
  geom_label(data = data.frame(x = bws_adaptive[which.min(bws_res)], y = 1500), 
             aes(label = "Linear\nSearch", x = x, y = y)) +
  geom_vline(xintercept=opt$minimum, col = "red", lty = 2) +
  geom_label(data = data.frame(x = opt$minimum, y = 700), aes(label = "Optimised\nSearch", x = x, y = y)) +
  ylim(c(0, 2000)) +
  theme_bw()

# extract the best bandwidth
bw = bws_adaptive[which.min(bws_res)]
# define the GWR function
gwr_func = gw_regr(bw, formula, liudaogou, adaptive = T, "bisquare")
# apply to the data
coef_mat = gwr_func(formula)
# rename and examine
colnames(coef_mat) = c("Intercept", all.vars(formula)[-1])
round(apply(coef_mat, 2, summary), 3)

## Figure 5 
library(RColorBrewer)
liudaogou %>% select(geometry) %>% cbind(coef_mat) %>% st_transform(4326) %>%
  # st_transform(4326) %>% as("Spatial") %>% 
  ggplot() + geom_sf(aes(fill = SOCgkg), col = "darkgrey", pch= 21, size = 2.5) +
  scale_fill_gradientn(colours = brewer.pal(8, "YlOrRd")) +
  scale_x_continuous(breaks = c(110.35, 110.36, 110.37, 110.38)) + 
  scale_y_continuous(breaks = c(38.79, 38.80, 38.81)) 

## Pipeline example with Dublin data  
load("dubvotes.rda")
formula = as.formula(GenEl2004 ~ SC1 + Unempl + Age18_24 + Age25_44 + Age45_64)
gwr_bw_func = gw_single_bw_gwr(dubvotes, adaptive=TRUE, kernel="bisquare", eval="AIC")

# Investigate potential bandwidths
tibble(bw = 10:nrow(dubvotes)) %>%  
  # evaluate them with the bandwidth evaluation function
  rowwise() %>% 
  mutate(fit = gwr_bw_func(bw, formula)) %>% 
  as_tibble() %>%
  # find the best fit and output
  slice(which.min(fit)) %>%
  select(bw) %>% unlist() %>% as.vector() %>%
  # create the GWR function
  gw_regr(formula, dubvotes, adaptive = T, "bisquare") -> gwr_func

# lazy elements are included in the GWR function
env_print(gwr_func)
fn_env(gwr_bw_func)$bw
# the function is run 
coef_mat = gwr_func(formula)
colnames(coef_mat) = c("Intercept", all.vars(formula)[-1])
# now the lazy elements are populated 
fn_env(gwr_func)$bw

## Figure 6
dubvotes %>% select(geometry) %>% cbind(coef_mat) %>% st_transform(4326) %>%
  # st_transform(4326) %>% as("Spatial") %>% 
  ggplot() + geom_sf(aes(fill = Unempl), col = "black", lwd = 0.2) +
  scale_fill_gradientn(colours = brewer.pal(8, "YlGnBu"), name = "% Unemployed")

## Appendix figure not included

### END ###
