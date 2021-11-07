---
layout: post
mathjax: true
title: "Microdados" 
date:   2021-11-07
---
<head>
    <meta charset="UTF-8"/>
    <style>
        body{
            background-color: hsla(195,81%,93%, 0.6);
            color: rgba(0,0,0,1);
        }
        p{
            text-align: justify;
        }
    </style>
</head>


```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Microdados

### Description

In this package I provide a easy and fast way to get PNAD using R. With this package you have access to the PNADs (pessoas and domicilios) from 1992 to 2015, except for 1994,
2000 and 2010, years in which the PNAD was not carried out. Enjoy !



| Source     |     Data  | Function  |  Period  | Sub dataset |
| :---       |    :----: |      ---: |     ---: |     ---:    |
| IBGE    | PNAD      | load_pnad  | 1992 to 2015 | pessoas e domicilios |




### Installation

```
install.packages("devtools")
devtools::install_github("mj-ribeiro/Microdados")
library('Microdados')
```

If you receive this error: "system error 267, O nome do diretório é inválido", or something similar try the following code:

```
install.packages("remotes")
Sys.setenv(R_REMOTES_STANDALONE="true")
remotes::install_github("mj-ribeiro/Microdados" )
library('Microdados')
```


### Examples

```
load_pnad(2001, 'pessoas')       # load PNAD pessoas from 2001
load_pnad(1996, 'domicilios')    # load PNAD domicilios from 1996
```

My R course can be view in my channel on [YouTube ](https://www.youtube.com/channel/UChWkFzZwrWrfQgZ2PIEJbhg). 

