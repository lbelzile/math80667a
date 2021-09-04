# Completely randomized designs with one factor {#onewayanova}

This chapter describes the most simply experiment, corresponding to comparing $K$ sub-populations which differ only in the treatment they received. 

In completely randomized experiments, the with a single treatment with $K$ levels, we are be interested in testing whether the mean of some outcome for $K$ different treatments sub-populations are equal.
The basic assumption of most designs is that we can decompose the observation obtained into two components [@Cox:1958]
\begin{align*}
\begin{pmatrix} \text{quantity depending only } \\ 
\text{on the particular unit} 
\end{pmatrix} + 
\begin{pmatrix} \text{quantity depending} \\
 \text{on the treatment used}\end{pmatrix}
\end{align*}
This **additive** decomposition further assumes that each unit is unaffected by (or independent of) the treatment of the other units and that the average effect of the treatment is constant. 

Let $\mu_1, \ldots, \mu_K$ denote the expectation (theoretical mean) of each of the $K$ sub-populations defined by the difference treatment. Lack of difference between treatments is equivalent to equality of means, which translates into the hypotheses
\begin{align*}
\mathscr{H}_0: & \mu_1 = \cdots = \mu_K \\
\mathscr{H}_a: & \text{at least two treatments have different averages, }
\end{align*}
The null hypothesis is, as usual, a single numerical value. The null hypothesis imposes $K-1$ restrictions (the number of equality signs, with the value of the global mean $\mu$ left unspecified). The alternative is the complement of this event, i.e., all potential scenarios for which not all expectations are equal. 

A **one-way analysis of variance** consists in comparing the average of each treatment group $T_1, \ldots, T_K$. Since we have $K$ groups, there will be $K$ averages (one per group) to estimate. 
One slight complication arising from the above is that the values of $\mu_1, \ldots, \mu_K$ are unknown. The (theoretical unknown) average in treatment $T_j$ is $\mu_j$ and this is perhaps the more natural parametrization, although it is ill-suited for hypothesis testing because none of the $\mu_i$ values are known in practice. 


An equivalent formulation writes for each treatment group the average as $\mu_j = \mu + \delta_j$, where $\delta_j$ is the difference between the treatment average $\mu_j$ and the global average of all groups. This however requires imposing the constraint $\delta_1 + \cdots + \delta_K=0$ to ensure the average of effects equals $\mu$.

The most common parametrization is in terms of **constrasts**, namely differences between a reference group (say $T_1$) and the group of interest. We thus have $\mu_1$ for the average of treatment $T_1$ and $\mu_1 + a_i$ for treatment $T_i$, where $a_i=0$ for $T_1$ and $a_i = \mu_i -\mu_1$ otherwise.


We can still assess the hypothesis by comparing the sample means in each group, which are noisy estimates of the expectation: their inherent variability will limit our ability to detect differences in mean if the signal-to-noise ratio is small.




