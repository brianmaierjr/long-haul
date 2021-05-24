library(ggcorrplot)
library(htmlwidgets)
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
library(corrplot)
library(RColorBrewer)


# the data

setwd("C:/Users/User/Documents/WEB5/rsocattan.github.io/assets/img")

load(paste0(getwd(),"/SNADATA.RData"))



#PLOTS

# 1 key flows -----

kf<-d3 %>%  
  
  ggplot( aes(x = reorder(names, -mean),
              y = mean,
              fill=mean)) +
  
  
  geom_bar(stat = "identity")+
  
  
  
  geom_errorbar(aes(ymin=min, ymax=max),
                width=.025
                ) +
  
  
  
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




saveWidget(ggplotly(kf),
           "key_flows.html",
           selfcontained = F,
           libdir = paste0(getwd()))






# 2 heatmap -------



# average share by sector
dfheat<-data.frame(t(data.frame(lapply(FLOWS2, function(x) apply(x[,c("row",
                                                                      "governo",
                                                                      "financeiras",
                                                                      "firmas",
                                                                      "familias",
                                                                      "goods_services")]/FLOWS2$GDP$total_renda,2,mean)))))


# naming col for melt
dfheat$transactions<-names(FLOWS2)


# RENAMING
#rownames(dfheat)<-names2[-which(names2=="Government Consumption")]
colnames(dfheat)<-c("RoW",
                    "Government",
                    "Banks",
                    "NFC",
                    "Households",
                    "Goods/Services",
                    "Transactions")






# rescaling
dfheatn<-data.frame(t(data.frame(apply(dfheat[,1:ncol(dfheat)-1],1,function(x) (x)/sd(x)))))
dfheatn$transactions<-rownames(dfheat)





# PLOT

melt(dfheatn ,id.vars = "transactions") %>% 
  
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






# 3 SANKEY RSC-----

RESOURCES2<-RESOURCES


RESOURCES2$GDP<-FLOWS$GDP



#TRANSFERS
#lapply(FLOWS, function(x) which(x$governo<0))
TRANSFERS<-RESOURCES2$PENS_ADJ+RESOURCES2$CASH_TRANSF +RESOURCES2$OTHER_TRANSF+RESOURCES2$SOC_BEN+RESOURCES2$CONT_SOC_EMP


#TAXES
#lapply(FLOWS, function(x) which(x$governo>0))
TAXES<-RESOURCES2$SOC_CONT+RESOURCES2$INC_WEALTH_TX+RESOURCES2$NET_TY 



# WEALTH
RESOURCES2$IED_profits$Years<-seq(2000,2017)
WEALTH<-RESOURCES2$DIVIDENDS+ RESOURCES2$DESEMB_FBKF+RESOURCES2$NAT_RESOURCE +RESOURCES2$IED_profits





#OTHERS
OTHERS<-RESOURCES2$K_TRANSD+RESOURCES2$NET_K_TRANS +RESOURCES2$PENS_ADJ

#merging
RESOURCES2$TRANSFERS<-TRANSFERS
RESOURCES2$WEALTH <-WEALTH
RESOURCES2$OTHERS<-OTHERS
RESOURCES2$TAXES<-TAXES


# EXPORTs
RESOURCES2$EXPORTS$firmas<-RESOURCES2$EXPORTS$total


#PLOTTING
# renaming subcols
for(i in 1:length(RESOURCES2)){
  
  colnames(RESOURCES2[[i]])<-c("Total",
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




links2<-data.frame(lapply(RESOURCES2, function(x) x[18,]) %>%
                     
                     reshape::melt() %>%
                     
                     filter(variable %nin% noshow) %>%
                     
                     filter(L1 %in% cats)%>%
                     
                     filter(!value=="0") %>%
                     
                     mutate(source=L1,
                            target=variable) %>%
                     
                     select(source,target, value))



links2

# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes2 <- data.frame(
  name=c(as.character(colnames(RESOURCES2$EXPORTS)[c(3,5,6,7,8)]), 
         as.character(cats)) %>% unique()
)



# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
links2$IDsource <- match(links2$source, nodes2$name)-1 
links2$IDtarget <- match(links2$target, nodes2$name)-1




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










# 4 SANKEY USES -----
# USES
USES2<-USES

#GDP
USES2$GDP<-FLOWS$GDP

#TRANSFERS
#lapply(FLOWS, function(x) which(x$governo<0))
TRANSFERS<-USES2$PENS_ADJ+USES2$CASH_TRANSF +USES2$OTHER_TRANSF+USES2$SOC_BEN+USES2$CONT_SOC_EMP


#TAXES
#lapply(FLOWS, function(x) which(x$governo>0))
TAXES<-USES2$SOC_CONT+USES2$INC_WEALTH_TX+USES2$NET_TY 



# WEALTH
USES2$IED_profits$Years<-seq(2000,2017)
WEALTH<-USES2$DIVIDENDS+ USES2$DESEMB_FBKF+USES2$NAT_RESOURCE +USES2$IED_profits





#OTHERS
OTHERS<-USES2$K_TRANSD+USES2$NET_K_TRANS +USES2$PENS_ADJ

#merging
USES2$TRANSFERS<-TRANSFERS
USES2$WEALTH <-WEALTH
USES2$OTHERS<-OTHERS
USES2$TAXES<-TAXES


# TRADE
USES2$EXPORTS$row <-USES2$EXPORTS$total
USES2$MPORTS$firmas<-USES2$MPORTS$total



#PLOTTING
# renaming subcols
for(i in 1:length(USES2)){
  
  colnames(USES2[[i]])<-c("Total",
                              "Goods",
                              "RoW",
                              "Domestic",
                              "Government",
                              "Banks",
                              "Firms",
                              "Households",
                              "Years")
  
  
}



lapply(USES2,function(x) colnames(x))

noshow<-c("Total",
          "Goods",
          "Domestic",
          "Years")


cats2<-c("EXPORTS",
        "MPORTS",
         "INVESTMENT",
          "CONSUMPTION",
      #  "GDP",
        "WAGES",
        "INTERESTS",
        "TRANSFERS",
        "TAXES",
        "WEALTH",
        "OTHERS")




links3<-data.frame(lapply(USES2, function(x) x[18,]) %>%
                     
                     reshape::melt() %>%
                     
                     filter(variable %nin% noshow) %>%
                     
                     filter(L1 %in% cats2)%>%
                     
                     filter(!value=="0") %>% 
                     
                     mutate(source=variable,
                            target=L1) %>%
                     
                     select(source,target, value))






# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes3 <- data.frame(
  name=c(as.character(cats2),
         as.character(colnames(USES2$EXPORTS)[c(3,5,6,7,8)])
         ) %>% unique()
)



# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
links3$IDsource <- match(links3$source, nodes3$name)-1 
links3$IDtarget <- match(links3$target, nodes3$name)-1



plot_ly(
  type = "sankey",
  arrangement = "snap",
  node = list(
    label = nodes3$name,
    pad = 10), # 10 Pixel
  link = list(
    source = links3$IDsource,
    target = links3$IDtarget,
    value = links3$value))






# 5 SANKEY BIND -----

# BINDING

links3a<-links3

links3a$target<-paste0(links3$target,".U")

links4<-rbind(links2,links3a)[,c(1:3)]



# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
links4$IDsource <- match(links4$source, c(nodes2$name,
                                          nodes3$name,
                                          links3a$target))-1 

links4$IDtarget <- match(links4$target, c(nodes2$name,
                                          nodes3$name,
                                          links3a$target))-1



# reescaling second targets
links4$IDtarget[31:nrow(links4)]<-as.numeric(links4$target[31:nrow(links4)])+4




# renaming target cols
links4$target<- sub(".U","",links4$target,fixed = TRUE)

 
# nodes
s1<-unique(links4[order(links4$IDsource,decreasing = F),1])[1:5]
ord<-links4%>%
  filter(IDsource>4)%>%
  select(IDsource)%>%
  order()

s2<-unique(links4[ord,1])

s3<-links4%>%
  filter(IDtarget>10) %>%
  select(target) %>%
  unique()


sanks<-links4%>%
  filter(!value<0) %>%
  plot_ly(
    type = "sankey",
    arrangement = "snap",
    node = list(label=c(s1,s2,as.character(s3$target)),
                pad = 10), # 10 Pixel
    link = list(
      source = links4$IDsource,
      target = links4$IDtarget,
      value = links4$value))




saveWidget(sanks,
           "sanks.html",
           selfcontained = F,
           libdir = paste0(getwd()))



# key stocks --------


NET_STOCKS3<-NET_STOCKS  


# renaming cols naming
for(i in 1:length(NET_STOCKS3)){colnames(NET_STOCKS3[[i]]) <- c("sector",
                                                                "Total",
                                                                "Deposits",
                                                                "Bonds",
                                                                "Loans",
                                                                "Equities",
                                                                "Insurance. Res.",
                                                                "Others")}








# [1] Which are the most relevant accounts?

# checking which are the driving transactions: accumulated flows/ accumulated GDP for all sectors

agg_stocks<- data.frame(instruments=rowSums(data.frame(lapply(NET_STOCKS3, function(x) abs(colSums(x))))))



# normalizing, cleaning and ordering
agg_stocks_n<-agg_stocks/sum(FLOWS$GDP$total_renda)
agg_stocks_n<-data.frame(instruments=rownames(agg_stocks_n)[-c(1,2)],value=sort(agg_stocks_n[-c(1,2),1],decreasing = T))
agg_stocks_n<-agg_stocks_n[order(agg_stocks_n),]
agg_stocks_n<-agg_stocks_n[!is.na(agg_stocks_n$value),]
agg_stocks_n<-agg_stocks_n[order(agg_stocks_n$value,decreasing = T),]



#plotings
LtoM <-colorRampPalette(c('red', 'yellow' ))
Mid <- "snow3"
MtoH <-colorRampPalette(c('lightblue', 'darkblue'))


key_stocks<-ggplot(agg_stocks_n, aes(x = reorder(instruments, -value),
                         y = value,
                         fill=value)) +
  
  geom_bar(stat = "identity")+
  
  labs(y="%",
       fill="%",
       x="")+
  
  scale_fill_gradient2(low=LtoM(4), mid='snow3', 
                       high=MtoH(4), space='Lab')+
  
  theme(axis.title.x=element_blank())+
  
  theme_classic2()



saveWidget(ggplotly(key_stocks),
           "key_stocks.html",
           selfcontained = F,
           libdir = paste0(getwd()))




# WTW -------




# ploting totals

mpf_totals<-cbind(melt(data.frame(lapply(MPF2, function(x) x["Total",]/FLOWS$GDP$total_renda[10]))),
                  Counterpart=rep(colnames(MPF2$BANKS),
                                  ncol(MPF2$BANKS)))



wtw_p<- ggplot(mpf_totals)+
  
  
  geom_bar(aes(x=variable,
               y=value,
               fill=Counterpart),
           stat = "identity",
           position = "stack") +
  
  geom_point(data=melt(lapply(MPF2, function(x) sum(x[1,])/FLOWS$GDP$total_renda[10])),
             aes(x=L1,
                 y=value,
                 color="Net Fin. Wealth")
  ) +
  
  scale_colour_manual(values = c('black')) +
  
  
  scale_fill_jco()+
  
  labs(y="%")+
  
  
  theme(axis.title.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text=element_text(size=7),
        axis.title=element_text(size=7,face="bold"),
        legend.title = element_blank(),
        panel.background = element_rect(fill = "white", colour = "white",
                                        size = 2, linetype = "solid"),
        panel.grid.major = element_line(size = 0.1, linetype = 'solid',
                                        colour = "grey96"),
        plot.margin = unit(c(.8,.1,.8,.8),"cm")
  ) 

wtw_p



saveWidget(ggplotly(wtw_p),
           "wtw.html",
           selfcontained = F,
           libdir = paste0(getwd()))






# creating year column

NS<-lapply(NET_STOCKS, function(x) cbind(x,year=seq(2004,2017)))

names(NS)<-c(names(NS)[c(1,2,3,4)],"Domestic",names(NS)[6])



# renaming columns
for (i in 1:length(NS)){
  
  colnames(NS[[i]])<-c(colnames(NS[[i]])[1],
                       "Total",
                       "Deposits",
                       "Bonds",
                       "Loans",
                       "Equities",
                       "Insurances",
                       "Others",
                       "year")}


#ploting
stocks_all<-reshape2::melt(NS,id.vars="year") %>% 
  
  filter(variable %in% c("Deposits",
                         "Bonds",
                         "Loans",
                         "Equities",
                         "Insurances",
                         "Others")) %>%
  
  mutate(rel_value=value/FLOWS2$GDP$total_renda[5:18]) %>%
  
  ggplot(aes(x=year,
             y=rel_value,
             group=variable,
             fill=variable))+
  
  geom_bar(position="stack", stat="identity") + 
  
  scale_fill_jco() +
  
  labs(fill="",
       y="%",
       x="")+
  
  facet_wrap(~L1,
             #   dir = "v",
             #  scales = "free_y"
  ) +
  
  theme_bw()



stocks_all




saveWidget(ggplotly(stocks_all) ,
           "stocks_all.html",
           selfcontained = F,
           libdir = paste0(getwd()))



