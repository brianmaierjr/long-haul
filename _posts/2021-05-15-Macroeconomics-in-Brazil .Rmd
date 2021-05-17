---
title: "Brazil's Macroeconomics"
description: This post presents important features of the Brazilian economy macroeconomic
  system.
date: '2021-05-17'

---

```{r setup, include=FALSE}

library(tis)
library(cowplot)
library(readxl)
library(xlsx)
library(urca)
library(dynlm)

library(heatmaply)
library(kableExtra)
library(reshape)
library(reshape2)
library(plotly)

library(Hmisc)
library(dplyr)
require(gridExtra)
library(tibble)

library(hrbrthemes)
library(viridis)
library(plotly)
#library(d3heatmap)

require(gplots)
require(RColorBrewer)
require(heatmaply)
library(data.table)
library(ggplot2)
library(magrittr)
library(plyr)
library(ggpubr)

library(tidyverse)
library(ggraph)
library("ggplot2")
library("plyr")
library("scales")
library("likert")
library("ggsci")
library("sfcr")


knitr::opts_chunk$set(include = FALSE)
load(paste0(getwd(),"/SNADATA.RData"))

```

## R Markdown

This webpage shows key macroeconomic features of Brazilian economy. These features were mostly studied during my Ph.D project. Understanding them helps to understand economic cycles and growth.




## Agents and transactions

In order to understand the macroeconomic features we need to ask which are the agents and how they earn and expend their financial inflows.

Agents are classifiend in accordance with the Brazilian Institute of Geography and Statistics (IBGE) as:

1. Households
2. Non-Financial Corporations
3. Financial Corporations
4. Government
5. Foreing Sector


The agents relate to eachother through two channels: a) transactions, and b) balance sheet.

Let's first check-out which are the transaction. With some cleaning procedures below we illustrate their average values in relation to GDP: 




```{r first, echo=FALSE, fig.align='center', fig.cap="**Economic Transactions (% GDP)** ", message=FALSE, warning=FALSE, anchor="figure", paged.print=FALSE}

d3 %>%  
  
  ggplot( aes(x = reorder(names, -mean),
              y = mean,
              fill=mean)) +
  
  
  geom_bar(stat = "identity")+
  

  
  geom_errorbar(aes(ymin=min, ymax=max),
                width=.2) +
  
  
  
  coord_flip()+
  
  scale_fill_gradient2(low=LtoM(4), mid='snow3', 
                       high=MtoH(4), space='Lab')+
  
  labs(fill="%")+
  
  
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        axis.ticks.x=element_blank(),
        panel.background = element_rect(fill = "white", colour = "white",
                                        size = 2, linetype = "solid"),
        panel.grid.major = element_line(size = 0.1, linetype = 'solid',
                                        colour = "grey96") 
  )

```




 By definition, however, each expenditure for a sector, represents an income for another. So it is key to understand if those transactions represent income sources our expenditures, for each sector.

In order to understand that, we have calculted, first, each sector source of income. The results are illustrate below:

```{r echo=FALSE, message=FALSE, warning=FALSE, paged.print=TRUE}
# cleaning


#TRANSFERS
#lapply(FLOWS, function(x) which(x$governo<0))
TRANSFERS<-RESOURCES$PENS_ADJ+RESOURCES$CASH_TRANSF +RESOURCES$OTHER_TRANSF+RESOURCES$SOC_BEN+RESOURCES$CONT_SOC_EMP
  

#TAXES
#lapply(FLOWS, function(x) which(x$governo>0))
TAXES<-RESOURCES$SOC_CONT+RESOURCES$INC_WEALTH_TX+RESOURCES$NET_TY 



# WEALTH
RESOURCES$IED_profits$Years<-seq(2000,2017)
WEALTH<-RESOURCES$DIVIDENDS+ RESOURCES$DESEMB_FBKF+RESOURCES$NAT_RESOURCE +RESOURCES$IED_profits





#OTHERS
OTHERS<-RESOURCES$K_TRANSD+RESOURCES$NET_K_TRANS +RESOURCES$PENS_ADJ

#merging
RESOURCES$TRANSFERS<-TRANSFERS
RESOURCES$WEALTH <-WEALTH
RESOURCES$OTHERS<-OTHERS
RESOURCES$TAXES<-TAXES


# EXPORTs
RESOURCES$EXPORTS$firmas<-RESOURCES$EXPORTS$total


#PLOTTING
# renaming subcols
for(i in 1:length(RESOURCES)){
  
  colnames(RESOURCES[[i]])<-c("Total",
                              "Goods",
                              "RoW",
                              "Domestic",
                              "Government",
                              "Banks",
                              "Firms",
                              "Households",
                              "Years")
  
  
}





noshow<-c("Total",
          "Goods",
          "Domestic",
          "Years")


cats<-c("EXPORTS",
        "MPORTS",
       # "INVESTMENT",
      #  "CONSUMPTION",
        "GDP",
        "WAGES",
        "INTERESTS",
        "TRANSFERS",
        "TAXES",
        "WEALTH",
        "OTHERS")




links2<-data.frame(lapply(RESOURCES, function(x) x[18,]) %>%
  
  reshape::melt() %>%
  
  filter(variable %nin% noshow) %>%
  
  filter(L1 %in% cats)%>%
  
  filter(!value=="0") %>%

  mutate(source=L1,
         target=variable) %>%
  
  select(source,target, value))
  

  


# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes2 <- data.frame(
  name=c(as.character(colnames(RESOURCES$EXPORTS)[c(3,5,6,7,8)]), 
         as.character(cats)) %>% unique()
)



# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
links2$IDsource <- match(links2$source, nodes2$name)-1 
links2$IDtarget <- match(links2$target, nodes2$name)-1



# sankeyNetwork(Links = links2,
#               Nodes = nodes2,
#               Source = "IDsource",
#               Target = "IDtarget",
#               Value = "value",
#               NodeID = "name", 
#               width = 700,
#               height = 500,
#              # iterations = 15,
#               fontSize = 12,
#               nodeWidth = 12)
# 

plot_ly(
  type = "sankey",
  arrangement = "snap",
  node = list(
    label = nodes2$name,
    pad = 10), # 10 Pixel
  link = list(
    source = links2$IDsource,
    target = links2$IDtarget,
    value = links2$value))


```











With some data manipulation have calculated the agents' inflows (green) and outflow (red). The values are the normalized average share on GDP of each transaction.



<p align="center">
```{r echo=FALSE, fig.cap="**Economic Transactions (normalized values)** ", message=FALSE, warning=FALSE, paged.print=FALSE}

# average share by sector
dfheat<-data.frame(t(data.frame(lapply(FLOWS3, function(x) apply(x[,c("row",
                                                                      "governo",
                                                                      "financeiras",
                                                                      "firmas",
                                                                      "familias")]/FLOWS2$GDP$total_renda,2,mean)))))


# naming col for melt
dfheat$transactions<-names(FLOWS3)


# RENAMING
#rownames(dfheat)<-names2[-which(names2=="Government Consumption")]
colnames(dfheat)<-c("RoW",
                    "Government",
                    "Banks",
                    "NFC",
                    "Households",
                    "Transactions")






# rescaling
dfheatn<-data.frame(t(data.frame(apply(dfheat[,1:ncol(dfheat)-1],1,function(x) (x)/sd(x)))))
dfheatn$transactions<-rownames(dfheat)





# PLOT

reshape::melt(dfheatn ,id.vars = "transactions") %>% 
  
  mutate(value, round(value,2)) %>% 
  
  
  ggplot(aes(x=variable, y=transactions, fill= value)) + 
  
  geom_tile() +
  
  scale_fill_gradient2(low="red",
                       mid="white",
                       high="green") +
  
  
  theme(axis.title.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text=element_text(size=7),
        axis.title=element_text(size=7,face="bold"),
        legend.title = element_blank(),
        panel.background = element_rect(fill = "white", colour = "white",
                                        size = 2, linetype = "solid"),
        panel.grid.major = element_line(size = 0.1, linetype = 'solid',
                                        colour = "grey96"),
        plot.margin = unit(c(.8,.8,.8,.8),"cm")
  ) 


```
