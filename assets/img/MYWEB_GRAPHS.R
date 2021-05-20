install.packages("ggcorrplot")
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



ggsave("flows.png")


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








# crisis -----


options(java.parameters = "-Xmx8000m")
crisis<-data.frame(read.xlsx("global2.xlsx",1))

#renaming
names(crisis)[10]<-"GDP"
names(crisis)[5]<-"banking"



cp<-aggregate(banking ~ Year, crisis, sum) %>%
  
  
  ggplot(.,aes(y=banking,
               x=Year,
               fill=banking)) +
  
  scale_fill_gradient2(low="royalblue",
                       mid="lightskyblue1",
                       midpoint=1,
                       high="#cb4154" )+
  
  geom_bar(stat="identity")+
  
  theme_classic()+
  
  annotate("text",
           x=c(1930,1971),
           y=c(25,30),
           label=c("1929 Crash",
                   "Bretton Woods Ends"),
           size=3)+
  
  
  geom_vline(xintercept =c(1971),
             size=.3,
             alpha=.5,
             linetype="dashed")+
  
  labs(y="crisis",
       fill="Nº")


cp2<-ggplotly(cp)
       
cp2

saveWidget(cp2,
           "crisis.html",
           selfcontained = F,
           libdir = paste0(getwd()))




# stocks x growth ---------


#data
gdp<-data.frame(read.xlsx("world.xlsx",1))[1:49,]


cor(gdp$hi,gdp$stocks)


# where are the .. ?
apply(gdp,2,function(x) which(x==".."))


# cleaned
gdp<-gdp[,-which(colnames(gdp)=="li")]


#combining growht and stocks in separate dfs
s<-list()

for (i in 1:ncol(gdp)){
  
  s[[i]]<-data.frame(time=gdp$Time, Growth=gdp[,i],stocks=gdp$stocks)

}

#renaming
names(s)<-colnames(gdp)



names(s)<-c("Time",
            "High Inc",
            "Low & Mid Income",
            "Lower Mid Income",
            "Upper Mid Income",
            "Stocks")



# plotting
gdpstocsk<-s[names(s) %nin% c("Time","Stocks")] %>% 


  bind_rows(.,.id="df") %>% 
  
  
  mutate(Prices=stocks/4)%>% 
    
  select(!stocks) %>%  
    
  
  reshape2::melt(.,id.vars=c("time","df")) %>% 


  ggplot(aes(x=time,
             y=value/4,
             color=variable)) +

  geom_line() +
    
    scale_y_continuous(
      
      # Features of the first axis
      name = "GDP",
      
      # Add a second axis and specify its features
      sec.axis = sec_axis( trans=~.*4, name="Stocks")
    ) +
  
  
  labs(color="")+


  facet_wrap(~df) +
  
  theme_bw()


gdpstocsk



saveWidget(ggplotly(gdpstocsk),
           "gdp_stocks_ts.html",
           selfcontained = F,
           libdir = paste0(getwd()))





# stocks prices plots ----

s[names(s) %nin% c("Time","Stocks")] %>% 
  
  
  
  bind_rows(.,.id="df") %>% 
  
  
  mutate(Prices=stocks)%>% 
  
  select(!stocks) %>%  
  
  filter(df=="High Inc")%>%
  
  ggplot(aes(x=Growth,
             y=Prices,
             color=time)) + 
  
  
  scale_color_gradient2(low="blue",
                        mid="white",
                        midpoint = median(gdp$Time),
                        high="red")+
  
  
  geom_point() +
  
  
  labs(color="")+
  
  
  geom_smooth(method = "glm",
              color="black",
              size=.5)+
  
  
  facet_wrap(~df) +
  
  theme_classic2()



# stocks x prices qrt US ----

# data
g1<-data.frame(read.xlsx("us.xls",1))


#outliers
outs<-apply(g1[,c(2,3)], 2, function(x) quantile(x, probs=c(.01, .99), na.rm = FALSE))


ga<-g1$gdp[g1$gdp>outs[1,1] & g1$gdp<outs[2,1]]
sa<-g1$shares[g1$shares>outs[1,2] & g1$shares<outs[2,2]]



data.frame(growth=ga,
           prices=sa) %>%
  
  
  ggplot(aes(x=growth,
             y=prices))+
  
  geom_smooth(method = "glm")+
  
  geom_point()






# stocks, housing, comm, ind -----
# data
g2<-data.frame(read.xlsx("fredgraph_g_qrt2.xls",1))


g3<-data.frame(apply(g2[,-1], 2, function(x) x[x>quantile(x, probs=c(.01, .99))[1] & x<quantile(x, probs=c(.01, .99))[2]]))

g3

names(g2)<-c("Time",
             "Shares",
             "Housing",
             "Production",
             "Commodities")


names(g3)<-c("Shares",
             "Housing",
             "Production",
             "Commodities")


hsc<-g2 %>%
  
  reshape2::melt(.,id.vars="Production") %>% 
  
  filter(!variable=="Time") %>%

  ggplot(aes(x=Production,
             y=value,
             color=variable))+
  

  geom_point()+
  
  
  geom_smooth(method = "glm",
              color="black",
              size=.5)+
  
    
  facet_wrap(.~variable,
             nrow = 2)+
  
  labs(color="",
       y="%"
       
       )


ggplotly(hsc)





# stocks, housing, prices level=====

g4<-data.frame(read.xlsx("fredgraph_index_qrt.xls",1))


s3

s3<-list()

for (i in 1:ncol(g4)){
  
  s3[[i]]<-data.frame(time=g4$time, variable=g4[,i], industrial=g4$industrial)
  
}


names(s3)<-colnames(g4)



# plotting

s3[names(s3) %nin% c("time","industrial")] %>% 
  
  
  bind_rows(.,.id="df") %>% 
  

  reshape2::melt(.,id.vars=c("time","df")) %>%  
  
  
  mutate(value2=log(value))%>%
  
  ggplot(aes(x=time,
             y=value2,
             color=variable,
             group=variable)) +
  
  geom_line() +
  
  # scale_y_continuous(
  #   
  #   # Features of the first axis
  #   name = "GDP",
  #   
  #   # Add a second axis and specify its features
  #   sec.axis = sec_axis( trans=~.*4, name="Stocks")
  # ) +
  # 
  # 
  labs(color="")+
  
  
  facet_wrap(~df) +
  
  theme_bw()







# composite index ------

comp<-data.frame(comp=apply(g4[,c(2,3,5)],1,mean))
g4$comp<-comp$comp




hsc<-plot_ly(g42,
        x=~time,
        y=~comp,
        type="scatter",
        mode="lines",
        name="Composite") %>%
  
  
  add_lines(x=~time,
            y=~industrial,
            yaxis = "y2",
            name="Industrial") %>%
  
  layout(yaxis2=list(
    overlaying = "y",
    side = "right",
    title = "Industrial Index"),
    
    yaxis=list(title="Composite Index"),
    
    xaxis=list(title=''))




saveWidget(ggplotly(hsc),
           "composite_index.html",
           selfcontained = F,
           libdir = paste0(getwd()))




# composite index growth 

gg4<- data.frame(apply(g4[,-1],2,function(x) (diff(x)/x[2:length(x)])*100))
  

#removing outliers?
gg42<-data.frame(apply(gg4[,-1], 2, function(x) x[x>quantile(x, probs=c(.005, .995))[1] & x<quantile(x, probs=c(.01, .99))[2]]))

  

hsc_g<-ggplot(data=data.frame(gg42),
              aes(x=comp,
             y=industrial,
             color=industrial
             )) +
  
  
  geom_point() +
  
  
  geom_smooth(method="glm",
              color="black",
              size=.5
              ) +
  
  ylim(c(-6,4))+
  
  scale_color_gradient2(low="white",
                       mid="royalblue",
                       high="white",
                       midpoint=0.6)+
  
  
  labs(color="%",
       y="Industrial",
       x="Composite")+
  
  theme_classic()



hsc2<-ggplotly(hsc_g)
hsc2


saveWidget(ggplotly(hsc2),
           "composite_growth.html",
           selfcontained = F,
           libdir = paste0(getwd()))




# debt x gfcg ------

debt<-data.frame(read.xlsx("debt_gdp.xls",1))

debt$recs<-ifelse(debt$recs>0,1,0)

names(debt) <-c("Time","Investments", "Debt",
                "GDP","Recessions")



# plot

debt_p<-plot_ly(debt)%>%
  
  
  add_trace(x=~Time,
           y=~Debt,
           type="scatter",
           mode="lines",
           name="Debt",
           alpha=.7) %>%
  
  add_trace(x=~Time,
             y=~Investments,
             type="scatter",
             mode="lines",
             name="Investments",
            alpha=.7) %>%
  
  add_bars(x=~Time,
           y=~Recessions*17,
           name='Recessions',
           marker=list(color="darkgrey"),
           alpha=.1) %>%
  
  
  add_trace(x = 2005,
            y = 13,
            type = 'scatter',
            mode = 'text',
            text = "Pre 2008",
            textposition = 'top',
            textfont = list(color = '#000000', size = 10),
            showlegend=F
            ) %>%
  
  
  add_trace(x = 1995,
            y = 10,
            type = 'scatter',
            mode = 'text',
            text = "Pre Dot-Com",
            textposition = 'top',
            textfont = list(color = '#000000', size = 10),
            showlegend=F
  )%>%
  
  add_trace(x = 1965,
            y = 15,
            type = 'scatter',
            mode = 'text',
            text = "Pre 69-70",
            textposition = 'top',
            textfont = list(color = '#000000', size = 10),
            showlegend=F
  )%>%
  layout(yaxis2=list(
    overlaying = "y",
    side = "right",
    title = "Debt (growth rate)"),
    
    yaxis=list(title="Investments (growth rate)",
               range=c(-10,20)),
    
    xaxis=list(title=''),
    bargap=.0)
 

debt_p

saveWidget(debt_p,
           "debt_gdp.html",
           selfcontained = F,
           libdir = paste0(getwd()))





# net lending x growth ------

#data
nl<-data.frame(read.xlsx("NL_DEBT_GDP.xls",1))


# creating binary positives and negative changes 
nl[2:nrow(nl),"pos"]<-ifelse(diff(nl$households)>0,0,1)

#new df with binary
nl2<-data.frame(hh=diff(nl$households),
                bus=diff(nl$business),
                gdp=nl$gdp[2:nrow(nl)],
                post=nl$pos[2:nrow(nl)])


#plt

nlp<-nl %>% 
  
  ggplot(.,aes(x=gdp,
               y=households,
               color=households))+
    
    geom_point() +
  
  scale_color_gradient2(low="white",
                        mid="royalblue",
                        midpoint = 0.02,#mean(lm(nl$gdp~nl$households)$fitted.values),
                        high="white")+
  
    geom_smooth(method = "lm",
                size=.5,
                color="black") +
  
  labs(color="",
       y="Households",
       x="GDP")+
  
  theme_classic2()


nlp

saveWidget(ggplotly(nlp),
           "nlp.html",
           selfcontained = F,
           libdir = paste0(getwd()))






# histogram nl gdp -----
source("http://www.sthda.com/upload/rquery_cormat.r")



#data
M<-data.frame(NL_PVT=nl$business[2:240],
              NL_HH=nl$households[2:240],
              GDP=nl$gdp[2:240],
              NLa_PVT=nl2$bus,
              NLa_HH=nl2$hh)


#plots

corrp<-ggplotly(ggcorrplot(cor(M), hc.order = TRUE, type = "lower",
           lab = TRUE,
           colors=c("red","white","blue")))



#saving
saveWidget(ggplotly(corrp),
           "corrp.html",
           selfcontained = F,
           libdir = paste0(getwd()))



