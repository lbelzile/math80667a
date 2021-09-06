# Completely randomized designs with one factor {#onewayanova}

This chapter describes the most simply experiment, corresponding to comparing $K$ sub-populations which differ only in the treatment they received. 

In completely randomized experiments, we are interested in the effect of treatment variables. We start for simplicity with a single variable with $K$ different treatments levels. The global hypothesis of interest is testing whether the mean of some outcome for $K$ different treatments sub-populations are equal. 


The basic assumption of most designs is that we can decompose the observation obtained into two components [@Cox:1958]
\begin{align*}
\begin{pmatrix} \text{quantity depending only } \\ 
\text{on the particular unit} 
\end{pmatrix} + 
\begin{pmatrix} \text{quantity depending} \\
 \text{on the treatment used}\end{pmatrix}
\end{align*}
This **additive** decomposition further assumes that each unit is unaffected by (or independent of) the treatment of the other units and that the average effect of the treatment is constant. 

Let $\mu_1, \ldots, \mu_K$ denote the expectation (theoretical mean) of each of the $K$ sub-populations defined by the different treatments. Lack of difference between treatments is equivalent to equality of means, which translates into the hypotheses
\begin{align*}
\mathscr{H}_0: & \mu_1 = \cdots = \mu_K \\
\mathscr{H}_a: & \text{at least two treatments have different averages, }
\end{align*}
The null hypothesis is, as usual, a single numerical value: it imposes $K-1$ restrictions (the number of equality signs, with the value of the global mean $\mu$ left unspecified). The alternative is not unique, since it comprises all potential scenarios for which not all expectations are equal. 

## Parametrization

A **one-way analysis of variance** consists in comparing the average of each treatment group $T_1, \ldots, T_K$. Since we have $K$ groups, there will be $K$ averages (one per group) to estimate. 

One slight complication arising from the above is that the values of $\mu_1, \ldots, \mu_K$ are unknown. The (theoretical unknown) average in treatment $T_j$ is $\mu_j$ and this is perhaps the more natural parametrization, although it is ill-suited for hypothesis testing because none of the $\mu_i$ values are known in practice. 


An equivalent formulation writes for each treatment group the average as $\mu_j = \mu + \delta_j$, where $\delta_j$ is the difference between the treatment average $\mu_j$ and the global average of all groups. This however requires imposing the constraint $\delta_1 + \cdots + \delta_K=0$ to ensure the average of effects equals $\mu$.

The most common parametrization is in terms of **constrasts**, namely differences between a reference group (say $T_1$) and the group of interest. We thus have $\mu_1$ for the average of treatment $T_1$ and $\mu_1 + a_i$ for treatment $T_i$, where $a_i=0$ for $T_1$ and $a_i = \mu_i -\mu_1$ otherwise.


We can still assess the hypothesis by comparing the sample means in each group, which are noisy estimates of the expectation: their inherent variability will limit our ability to detect differences in mean if the signal-to-noise ratio is small.



## F-statistic for ANOVA

The following section tries to shed some light into how the $F$-test statistic works as a summary of evidence: it isn't straightforward in the way it appears how this is the case. Under the null hypothesis, all groups have the same mean $\mu$ and we can compute the overall average $\widehat{\mu}$ and the group averages $\widehat{\mu}_1, \ldots, \widehat{\mu}_K$, where $\widehat{\mu}_i$ indicates the sample average in the $i$th group.

The $F$-statistic is heuristically
\begin{align}
F = \frac{\text{between-group variability}}{\text{within-group variability}} 
(\#eq:Fstatheuristic)
\end{align}
The between-group variance is the squared differences between the overall mean $\widehat{\mu}$ and the group mean for each observation in the $i$th group $\widehat{\mu}_i$, suitably rescaled. If there is no mean difference, the numerator is an estimate of the population variance, and so is the denominator of \@ref(eq:Fstatheuristic). If there are many observations (and relatively fewer groups), the ratio is approximately one on average. 

If there is no difference in mean, the _F_-statistic follows in large sample a _F_-distribution, whose shape is governed by two parameters named degrees of freedom. The first is the number of restrictions imposed by the null hypothesis ($K-1$, the number of groups minus one), and the second is the number of observations minus the number of *mean parameters estimates* ($n-K$, where $n$ is the overall sample size and $K$ is the number of groups).^[The overall mean is full determined by the other averages, since $n\widehat{\mu} =n_1\widehat{\mu}_1 + \cdots + n_K \widehat{\mu}_K$.]


