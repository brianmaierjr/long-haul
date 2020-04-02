---
title: "Um caminho simples para estimar o modelo GARCH no R"
output:
  html_document: default
  pdf_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

Importando as bibliotecas necessárias.

```{r message=FALSE, warning=FALSE, paged.print=FALSE}
library(tseries)
library(timeSeries)
library(quantmod)
library(fGarch)
library(mFilter)
```


Vamos utilizar o getSymbols para obter os dados do Ibovespa, de janeiro de 2007 até a data presente. 

```{r message=FALSE, warning=FALSE, paged.print=FALSE}

ibov = getSymbols('^BVSP', src='yahoo', from= '2007-01-01', auto.assign = F)[,4]
colnames(ibov)= c('ibov')
ibov = ibov[is.na(ibov)==F]   # elimina os na's da amostra

```

Para ver as seis primeiras observações da amostra usarei o comando head.

```{r}
head(ibov)

```



```{r, fig.width=10, fig.height=6}
plot(ibov)
```


Agora vou calcular os retornos logaritmos do Ibov.

```{r}
ret = diff(log(ibov))
colnames(ret) = c('ret')
ret = ret[is.na(ret)==F]  # Drop na to work
```

O próximo passo é plotar os retornos e a autocorrelação desses retornos.

```{r, fig.width=10, fig.height=8}
par(mfrow=c(2,1))
plot(ret, main='Evolução dos retornos do IBOV')
acf(ret)   # There isn't autocorrelation in returns. So isn't possible predict ret
```


Note que os retornos não são autocorrelacionados. Logo não há uma estrutura de dependência entre eles. Sendo assim não é possivel prever tais retornos. Tente você mesmos estimar um Modelo ARIMA com esses dados. Você perceberá que os coeficientes estimados não são significativos.

Agora vamos fazer o mesmo para o quadrado dos retornos.


```{r, fig.width=10, fig.height=8}
par(mfrow=c(2,1))
plot(ret^2, main= 'Evolução do quadrado dos retornos do IBOV')
acf(ret^2)   # In squares of returns there is autocorrelation  
```


As estatíscas descritivas do IBOV e seus retornos podem ser calculadas utilizando a função basicStats da biblioteca fGarch.



```{r}
basicStats(ret)
```



```{r}
basicStats(ibov)
```


Agora vamos estimar o modelo GARCH(1, 1). Usualmente estimamos vários modelos GARCH de ordens diferentes, calculamos o critério de informação de Akaike ou o critério de informação Bayesiano, o modelo com o maior desses indicadores é considerado o mais adequado. No entanto, já sabemos que para séries financeiras o GARCH(1, 1) resolve bem o problema.


```{r, results="hide"}
garch1 = garchFit(formula = ~garch(1,1),data = ret)

```


```{r}
summary(garch1)

```


Agora que temos um objeto chamado garch1 vamos extrair desse objeto a volatilidade estimada.

```{r}
data = index(ret)
vol = garch1@sigma.t
vol = as.xts(vol, order.by = data)

```



```{r, fig.width=10, fig.height=8}
par(mfrow=c(2, 2))
plot(ibov, main='Evolution of IBOV')
plot(ret, main='Evolution of IBOV returns')
plot(ret^2, main='Evolution of square \n of IBOV returns')
plot(vol, main= 'Volatility of IBOV \n returns by GARCH(1,1)')
```


Note que a volatilidade estimada pelo GARCH é bastante elevada já a partir de janeiro de 2020. Tal volatilidade é maior que da crise de 2008. Esse fato pode ser creditado a crise do COVID-19.




Agora vamos estimar o GARCH(1,1) utilizando a biblioteca rugarch.


```{r message=FALSE, warning=FALSE, paged.print=FALSE}
library(rugarch)
spec = ugarchspec()
spec

```



```{r, results="hide"}

spec1 = ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)), 
                       mean.model=list(armaOrder=c(1,0), include.mean=TRUE),  
                       distribution.model="norm")

garch2 = ugarchfit(spec = spec1, data= ret)

```


```{r}
garch2
```

Use o predict para prever 5 passos a frente.


```{r}

pred2 = ugarchforecast(garch2, n.ahead = 5)
#plot(pred2)

```








