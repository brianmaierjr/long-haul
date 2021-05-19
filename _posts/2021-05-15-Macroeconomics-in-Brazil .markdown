---
layout: post
title: "A note on Macroeconomic modelling"
description: This post highlights important gaps on mainstream macroeconomic modelling and illustrate the argument on real data.
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


Another important source of imbalances in the real economy comes from credit. Credit cycles, which are normally fueled by increasing asset prices, play an important role to determine investments. Unlike most DSGE models, however, credit constraints exits, and agents become overindebted - and even go bankrutp.


Below we illustrate the relation between investments and nonfinancial corporations indebtement (securities + loans) in the US:


<body>
    <div align="center">
      <figure>
  <iframe src="/assets/img/debt_gdp.html" frameborder="0" height="600" width="630"    display:block></iframe>
	 <figcaption>Fig5. - Investments, Debt and Recessions (% growth)  </figcaption>
      </figure>
    </div>
</body>



The question is wheter financial cycles determine real business cycles, if business cycles determine financial cycles, or if the series are co-determined. The workhorse of current neoclassical macroeconomics are DSGE models. In this framework, events such as economic crisis, when not ruled out by construction, are exogenous shocks, and not breeded withing the economic system.

Surprisingly this drawback was only recognised after the 2008  great financial crisis by neoclassical economists. Joseph Stiglitz [said] (https://watermark.silverchair.com/grx057.pdf?token=AQECAHi208BE49Ooan9kkhW_Ercy7Dm3ZL_9Cf3qfKAc485ysgAAAqAwggKcBgkqhkiG9w0BBwagggKNMIICiQIBADCCAoIGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMyGsjZH08CxN0HlbaAgEQgIICU4PGQpCmXG-i-cmub5b-Bn7l-Ifc-aK2CcB-3a1OKYq3Sc0DmoE7nY8yeVlCFT8XdBnLu4VfLdYHzaCZNQMxBq6e5wEcmLOuDvX2636Yma3PYjqhaX203rrffNuGQ8AjNh376GaTQcdJtjr16jmD9fPLR6OHMFvUZkc4vkmfHtVGxmk7_M2RVRTrOflcMX9sYoQzwOa4I3O1wM4lI8T6f5TkojBZiFxo_CdyfZkaVqb2-vbs09eXCd3Yq8HSYHaK2crCCK9QrEgUSO1Q0V39o6EMrU8Z0V2aCN7mxABHYDbyyud5pYamISOiYiW0hJPPz6imRuZ7qdVr4amnKo9mWDy8pnS5Ouw63wF_2ksexjna29aWb-0x6tZCVGrHcH3eRcSgwaNtiWanO2C7vx89kWBgq4mgEmHmn2MSithayE5cycBxcHA73rTRGIcRyY-Iw9QuBvdPHYd2ec85tgKcVOljhAReL5evjs--GqqARVo21_4m1l-tioUecKf1PByhHqPIgWo1MYOGyr4UAe4jluj3yuKp2ocws9cLaRdoy3Ma9krWyon5ZeRT-Tz_p6MnyMAQp3gebJcvM88De3n2n9jlzPLQXc9mFL-ZEuWHWK8hPTEbR1p1BlEf6xZvxtE_5ccsm6fLKsg2BGfYzEIv9UJtm_SACaUWIHok3ty55PSYv-99bJUUyNsvuKL9XDbu5SQBjac7gnc-x1wTznPd_MZw25cZuAJtGlmtJ--GBm_fJG9Ll92nK9fM-tFFPPJk6bstlB7qJSPQAJsxItSil0zIZec) the following about DSGE models: **Dynamic Stochastic General Equilibrium (DSGE) models, which have played such an important role in modern discussions of macroeconomics, in my judgement fail to serve the functions which a well-designed macroeconomic model should perform**





Among the alternatives to incorporate financial aspects into macroeconomic analysis we highlight the post-Keynesian approach. One of the key aspects of the post-Keynesian economics is the key role played by financial markets, and the role played by money itself. (If you are curious about this research agenda I encourage you to visit [this](https://www.postkeynesian.net/) website, or to watch [this](https://www.youtube.com/watch?v=DEROFQIao4o) talk from Marc Lavoie)

Understading the real activity nexus to financial markets is, thus, of extreme relevance to understand macroeconomic dynamics. But how can we embody all those features in an econonomic model? 


A growing body of the post-Keynesian literature has adopted a modelling framework which cover precisely the importance of financial instruments for economic dynamics in the so-called Stock-Flow consistent modelling (SFC). More on this subject will be addressed on the next [post](#brmodel)







