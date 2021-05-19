---
layout: post
title: "Brazil's Macroeconomics"
description: This post presents important features of the Brazilian economy macroeconomic system. I think.
date: '2021-05-17'
---


### Why do we need a macroeconomic model?

Economic models are a representation of reality. To understand observed trends in the economy - such as financial crisis, how income grows, why people are unemployed or why prices are rising, we need to abstract a number of elements and focus on others. 



What to neglect and what to consider is a crucial part of building economic models. The more elements (or endogenous variables) a model incorporates, the harder it is to see the model's insights. 


We share the view, however, of George E. P. Box that *"All models are wrong, but some are useful "*. That is,


Economic models have different purposes. One of them is economic policy design. Given that economic models are often a mathematical framework, they can provide numerical insights in respect to what incentives could the government give in order to overcome observed problems.


Some real real problems, however, are often neglected by the standard economic theory. One of these problems is the role of finance in economic dynamics. Financial markets include credit creation by banks, the issue of bonds by the treasury, and even interest-beargin deposits. And most of these elements are absent in the mainstream analysis of cycles and growth.


The Nobel prize laureate [Paul Romer](https://paulromer.net/the-trouble-with-macro/WP-Trouble.pdf), for instance, became a vocal critic of the current state of modern neoclassical macroeconomics, including the omission of finance. The author cites as an example the following quote from a renowned colleague: *"although in the interest of disclosure, I must admit that I am myself less than totally convinced of the importance of money outside the case of large inflations"*.


In 2008, for instance. we could see that financial markets are not neutral in the economic process. But why "nobody saw it coming"? Most analysts couldn't grasp the nature of the financial-real crisis because crucial imbalances inside the economy are largely overlooked by the traditional modelling tools. 


And the 2008 crisis was not an isolated case.  Financial crisis are a long-lasting characteristic of capitalism, but they became more frequent for the past 40 years, since the end of the Bretton Woods agreement. By retrieving data from the Harvard Business School [website](https://www.hbs.edu/behavioral-finance-and-financial-stability/data/Pages/global.aspx), I have calculated the number of banking crisis, by year, since 1800:


<body>
    <div align="center">
      <figure>
  <iframe src="/assets/img/crisis.html" frameborder="0" height="600" width="630"    display:block></iframe>
	 <figcaption>Fig1. - Banking Crisis (absolute)  </figcaption>
      </figure>
    </div>
</body>



Morever, the increasing frequency of financial crisis, is not the only justification for including more realistic, non-efficient, financial markets into macroeconomic modelling. Modern financialised economies are greatly influenced by endogenous monetary components such as credit cycles, equities, housing and even commodities market - all of them integral part of the financial system. 

In order to illustrate how the "real" economy and the financial economy have strong co-movements, I have calculated a financial composite index, which is a simple average of shares prices, residential and commodities prices (All of them available in the St. Luis Fed [website] (https://fred.stlouisfed.org/)). Then, I have contrasted this composite with the industrial production in the US from 1992 until today. 

The results are illustrated below:


<body>
    <div align="center">
      <figure>
  <iframe src="/assets/img/composite_index.html" frameborder="0" height="600" width="630"    display:block></iframe>
	 <figcaption>Fig4. - Industrial Production and Composite (index)  </figcaption>
      </figure>
    </div>
</body>


It is possible to see a strong correlation between the two series both in upward and downward economic cycles. Although not conclusive, this highlights a real-financial connection that I believe to be missing on neoclassical economics. 

The positive association between the series is also clear by plotting their growth rates for the same period:



<body>
    <div align="center">
      <figure>
  <iframe src="/assets/img/composite_growth.html" frameborder="0" height="600" width="630"    display:block></iframe>
	 <figcaption>Fig4. - Industrial Production and Composite (growth)  </figcaption>
      </figure>
    </div>
</body>




The question is wheter financial cycles determine real business cycles, if business cycles determine financial cycles, or if the series are co-determined. 








Among the alternatives to incorporate financial aspects into macroeconomic analysis we highlight the post-Keynesian approach. One of the key aspects of the post-Keynesian economics is the key role played by financial markets, and the role played by money itself. (If you are curious about this research agenda I encourage you to visit [this](https://www.postkeynesian.net/) website, or to watch [this](https://www.youtube.com/watch?v=DEROFQIao4o) talk from Marc Lavoie)

Understading the real activity nexus to financial markets is, thus, of extreme relevance to understand macroeconomic dynamics. But how can we embody all those features in an econonomic model? 


A growing body of the post-Keynesian literature has adopted a modelling framework which cover precisely the importance of financial instruments for economic dynamics in the so-called Stock-Flow consistent modelling (SFC).

SFC models are characterised by placing a tight accounting system in which every expenditure for a sector represents an income for another (**flow consistency**),  every financial instrument represents an asset for somebody, and a liability for somebody else (**stock-consitency**). And that, every positive (negative) financial balance accumulates into wealth (debt) (**stock-flow consitency**).


Indeed, a number of works are already employing some of those features to develop empirical models. See examples for [England](https://www.bankofengland.co.uk/-/media/boe/files/working-paper/2016/a-dynamic-model-of-financial-balances-for-the-uk.pdf), [Denmark](http://www.levyinstitute.org/publications/an-empirical-stock-flow-consistent-macroeconomic-model-for-denmark), and [Italy](http://www.levyinstitute.org/publications/a-stock-flow-consistent-quarterly-model-of-the-italian-economy).


In this article I will examine what should be of concern to employ a SFC model for Brazil. This will be done through the exposition of the most relevant transactions, and the most relevant financial instruments of the Brazilian economy according to the data.




### Agents and transactions

In order to understand the macroeconomic features we need to ask which are the agents and how they earn and expend their financial inflows.

Agents are classifiend in accordance with the Brazilian Institute of Geography and Statistics (IBGE) as:

1. Households
2. Non-Financial Corporations
3. Financial Corporations
4. Government
5. Foreing Sector


The agents relate to eachother through two channels: a) transactions, and b) balance sheet. That is, they relate through **flows** (e.g., consumption, interest payments, government transfers) and through financial **stocks** (shares, bonds, deposits, etc.).  

Let's first check-out which are the most important transaction. With some cleaning procedures, below we illustrate their average values in relation to GDP: 


<figure>
	 <img src="/assets/img/flows.jpg" alt="" style="width:600px;" />
	<figcaption>Fig2. - Key Flows (% GDP) figcaption</figcaption>
</figure>



By definition, however, each expenditure for a sector, represents an income for another. So it is key to understand if those transactions represent income sources our expenditures, for each sector. In order to understand that, we have calculated each sector source of income, and their respective expenditures. The results are illustrate in the diagram below:


<body>
    <div align="center">
<figure>
<iframe src="/assets/img/sanks.html" frameborder="0" height="600" width="630" display:block></iframe>
	<figcaption>Fig3. - Income and Expenditures (R$ )  </figcaption>
</figure>
    </div>
</body>



A number of features could be highlighted from this result. I'll only highlight those which illustrate how actual data and economic growth theory diverge. **First**, we can see that GDP which is net value added is a source of income not only for firms, but also for banks, households, and even government (this last one, only for accounting purposes). Given that most macroeconomic growth models only rely on firms output, we can see that the real macroeconomic accounting system is significantly more complex than most theoretical representations of it. 

**Second**, interests and wealth (which also aggregates capital-related income) are an important income source for banks, as expected, but also for households, and firms. This stresses a financial source of income which derives from balance sheet relations. For instance, if households hold firms' equities or government bonds, this will influence their income sources, and, consequently, their expenditures's level. This real-financial nexus, although clear in the data (in even in the common sense) is largely neglected on mainstream macroeconomic models.

**Third**, transfers are a relevant share of households' disposable income. We can see that this source of income is similar to wages in absolute levels, meaning that a proper representation of households on macroeconomic models, should not overlook the distributive role played by the goverment. 

**Forth** firms, households, the government, an even banks invest (i.e. consume fixed capital). Most growth models embody none but firms as the responsibles for capital accumulation. Investments play a crucial role on economic dynamics in the short and - depending on your your theoretical background - in the long run as well. For this reason, it is key to embody some of these features in models that aim to study real phenomena through macroeconomic lens. 






### Financial Stocks

TBD






