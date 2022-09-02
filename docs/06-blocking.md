# Designs to reduce the error


The previous chapter dealt with factorial experiments in which all experimental factors are of interest. In many instances, some of the characteristics of observational units are not of interest: for example, EEG measurements of participants in a lab may differ due to time of the day, to the lab technician, etc. These are instances of **blocking factors**: by filtering their effect out and looking at the residual variability that is unexplained by the blocking factors, we can increase power. Block designs reduce the error term, at the cost of including and estimating additional parameters (group average or slope). 

We will analyse block designs in the same as we did for multi-way analysis of variance model, with one notable exception. Typically, we will assume that there is **no interaction** between experimental factor and blocking factors^[We can check for this assumption.] Thus, we will be interested mostly in marginal effects.

A related design is to include a continuous covariate to the analysis of variance. If we randomized the observations properly, this shouldn't be necessary. The linear model term helps again reduce the residual variability, which increases the power to detect differences due to experimental conditions. Such a design was historically called **analysis of covariance**, an instance of a linear model.


Including blocking factor or covariates should in principle increase power provided the variables used as control are correlated with the response. Generally, they are not needed for valid inference, which is guaranteed by randomization, and shouldn't be used to assign treatment.


## Analysis of covariance {#ancova}

In an analysis of covariance, we include a linear component for a (continuous) covariate, with the purpose again to reduce residual error. A prime example is prior/post experiment measurements, whereby we monitor the change in outcome due to the manipulation.

In such setting, it may seem logical to take the difference in post and prior score as response: this is showcased in Example \@ref(exm:vanStek) and @Baumann:1992, an analysis of which is presented on [the course website](https://edsm.rbind.io/example/06-ancova/). 

When we add a covariate, we need the latter to have a strong linear correlation for the inclusion to make sense. We can assess graphically whether the relationship is linear, and whether the slopes for each experimental condition are the same.^[If not, this implies that the covariate interacts with the experimental condition.]

<div class="figure" style="text-align: center">
<img src="06-blocking_files/figure-html/fig-ancovadifftrend-1.png" alt="Simulated data from two groups with an analysis of covariance model. " width="85%" />
<p class="caption">(\#fig:fig-ancovadifftrend)Simulated data from two groups with an analysis of covariance model. </p>
</div>

The left panel of Figure \@ref(fig:fig-ancovadifftrend) shows the ideal situation for an analysis of covariate: the relationship between response and covariate is linear with strong correlation, with the same slope and overlapping support. Since the slopes are the same, we can compare the difference  in average (the vertical difference between slopes at any level of the covariate) because the latter is constant, so this depiction is useful. By contrast, the right-hand panel of Figure \@ref(fig:fig-ancovadifftrend) shows an interaction between the covariate and the experimental groups, different slopes: there, the effect of the experimental condition increases with the level of the covariate. One may also note that the lack of overlap in the support, the set of values taken by the covariate, for the two experimental conditions, makes comparison hazardous at best in the right-hand panel.

Figure \@ref(fig:fig-ancovaresid) shows that, due to the strong correlation, the variability of the measurements is smaller on the right-hand panel (corresponding to the analysis of covariance model) than for the centred response on the left-hand panel; note that the $y$-axes have different scales.


<div class="figure" style="text-align: center">
<img src="06-blocking_files/figure-html/fig-ancovaresid-1.png" alt="Response after subtracting mean (left) and after detrending (right)." width="85%" />
<p class="caption">(\#fig:fig-ancovaresid)Response after subtracting mean (left) and after detrending (right).</p>
</div>


We present two examples of analysis of covariance, showing how the inclusion of covariates helps disentangle differences between experimental conditions.

::: {.example #leechoi name="Inconsistency of product description and image in online retailing"}

@Lee.Choi:2019 measured the impact of discrepancies between descriptions and visual depiction of items in online retail. They performed an experiment in which participants were presented with descriptions of a product (a set of six toothbrushes) that was either consistent or inconsistent with the description. The authors postulated that a discrepancy could lead to lower appreciation score, measured using three Likert scales. They also suspected that the familiarity with the product brand should impact ratings, and controlled for the latter using another question.


One way to account for familiarity when comparing the mean is to use a linear regression with `familiarity` as another explanatory variable. The expected value of the product evaluation is
\begin{align}
\mathsf{E}(\texttt{prodeval}) = \beta_0 + \beta_1 \texttt{familiarity} + \beta_2 \texttt{consistency}, (\#eq:vS)
\end{align}
where $\texttt{familiarity}$ is the score from 1 to 7 and $\texttt{consistency}$ is a binary indicator equal to one if the output is inconsistent and zero otherwise. 
The coefficient $\beta_2$ thus measures the difference between product evaluation rating for consistent vs inconsistent displays, for the same familiarity score.







We can look at coefficient (standard error) estimates $\widehat{\beta}_2 = -0.64 (0.302)$.
No difference between groups would mean $\beta_2=0$ and we can build a test statistic by looking at the standardized regression coefficient $t = \widehat{\beta}_2/\mathsf{se}(\widehat{\beta}_2)$. The result output is $b = -0.64$, 95\% CI $[-1.24, -0.04]$, $t(93) = -2.12$, $p = .037$. We reject the null hypothesis of equal product evaluation for both display at level 5%: there is evidence that there is a small difference, with people giving on average a score that is 0.64 points smaller (on a scale of 1 to 9) when presented with conflicting descriptions and images.

We can compare the analysis of variance table obtained by fitting the model with and without $\texttt{familiarity}$. Table \@ref(tab:tbl-anovatabLC19S1) shows that the effect of consistency is small and not significant and a two-sample _t_-test shows no evidence of difference between the average familiarity score in both experimental conditions ($p$-value of .532). However, we can explain roughly one fifth of the residual variability by the familiarity with the brand (see the sum of squares in Table \@ref(tab:tbl-anovatabLC19S1)): removing the latter leads to a higher signal-to-noise ratio  for the impact of consistency, at the expense of a loss of one degree of freedom. Thus, it appears that the manipulation was successful.


<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:tbl-anovatabLC19S1)Analysis of variance tables for the models without $\texttt{familiarity}$.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> sumsq </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:left;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> consistency </td>
   <td style="text-align:right;"> 7.04 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 2.55 </td>
   <td style="text-align:left;"> .113 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Residuals </td>
   <td style="text-align:right;"> 259.18 </td>
   <td style="text-align:right;"> 94 </td>
   <td style="text-align:right;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
</tbody>
</table>

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:tbl-anovatabLC19S1)Analysis of variance tables for the models with $\texttt{familiarity}$.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> sumsq </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:left;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> familiarity </td>
   <td style="text-align:right;"> 55.9 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 25.60 </td>
   <td style="text-align:left;"> &lt; .001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> consistency </td>
   <td style="text-align:right;"> 9.8 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 4.49 </td>
   <td style="text-align:left;"> .037 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Residuals </td>
   <td style="text-align:right;"> 203.2 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
</tbody>
</table>



<div class="figure" style="text-align: center">
<img src="06-blocking_files/figure-html/fig-ANCOVA-demo-1.png" alt="Scatterplot of product evaluation as a function of the familiarity score, split by experimental manipulation." width="85%" />
<p class="caption">(\#fig:fig-ANCOVA-demo)Scatterplot of product evaluation as a function of the familiarity score, split by experimental manipulation.</p>
</div>

Figure \@ref(fig:fig-ANCOVA-demo) shows that people more familiar with the product or brand tend to have a more positive product evaluation, as postulated by the authors. The graph also shows two straight lines corresponding to the fit of a linear model with different intercept and slope for each display group: there is little material difference, one needs to assess formally whether a single linear relationship as the one postulated in eq.\@ref(eq:vS) can adequately characterize the relation in both groups. 

To this effect, we fit a linear model with different slopes in each group, and compare the fit of the latter with the analysis of covariance model that includes a single slope for both groups: we can then test if the slopes are the same, or alternatively if the difference between the slopes is zero. The _t_-statistic indicates no difference in slope ($p$-value of .379), thus the assumption is reasonable. Levene's test for homogeneity of variance indicates no discernible difference between groups. Thus, it appears there is a difference in perception of product quality due to the manipulation.




:::

::: { .example #vanStek name="Effect of scientific consensus on false beliefs"}

We consider Study 3 of @vanStekelenburg:2021, who studied changes in perception of people holding false beliefs or denying (to some extent) the scientific consensus by presenting them with news article showcasing information about various phenomena. The experimental manipulation consisted in presenting boosting, a form of training to help readers identify and establish whether scientifists were truly expert in the domain of interest, how strong was the consensus, etc.^[The article is interesting because lack of planning/changes led them to adapt the design from experiment 1 to 3 until they found something. Without preregistration, it is unlikely such findings would have been publishable.]

The third and final experiment of the paper focused on genetically modified organisms: it is a replication of Study 2, but with a control group (since there were no detectable difference between experimental conditions `Boost` and `BoostPlus`) and a larger sample size (because Study 2 was underpowered). 

The data include 854 observations with `prior`, the negative of the prior belief score of the participant, the `post` experiment score for the veracity of the claim. Both were measured using a visual scale ranging from -100  (I am 100% certain this is false) to 100  (I am 100% certain this is true), with 0 (I don’t know) in the middle. Only people with negative prior beliefs were recruited to the study. The three experimental conditions were `BoostPlus`, `consensus` and a `control` group. Note that the scores in the data have been negated, meaning that negative posterior scores indicate agreement with the consensus on GMO.



Preliminary checks suggest that, although the slopes for prior beliefs could plausibly be the same in each group and the data are properly randomized, there is evidence of unequal variance for the changes in score. As such, we fit a model with mean
\begin{align*}
\mathsf{E}(\texttt{post}) &= \begin{cases}
\beta_0 + \beta_1 \texttt{prior} + \alpha_1 &  \texttt{condition} = \texttt{BoostPlus}\\
\beta_0 + \beta_1 \texttt{prior} + \alpha_2 &\texttt{condition} = \texttt{consensus}\\
\beta_0 + \beta_1 \texttt{prior} + \alpha_3 &\texttt{condition} = \texttt{control}
\end{cases}
\end{align*}
with $\alpha_1 + \alpha_2 + \alpha_3=0$, using the sum-to-zero parametrization, and with different variance for each experimental condition, 
\begin{align*}
\mathsf{Va}(\texttt{post}) = \begin{cases}
\sigma^2_1, &  \texttt{condition} = \texttt{BoostPlus},\\
\sigma^2_2, &  \texttt{condition} = \texttt{consensus},\\
\sigma^2_3, & \texttt{condition} = \texttt{control}.
\end{cases}
\end{align*}
Because of the unequal variances, we cannot use multiple testing procedures reserved for analysis of variance and resort instead to Holm--Bonferroni to control the familywise error rate. We here look only at pairwise differences between conditions.^[In Study 2, the interest was comparing manipulation vs control and the Boost vs BoostPlus conditions, two orthogonal contrasts.]
 
 
<table class="kable_wrapper table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:tbl-anovatabSSVB)Analysis of variance tables for the model with (left) and without (right) $\texttt{prior}$ belief score.</caption>
<tbody>
  <tr>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:left;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> condition </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 42.5 </td>
   <td style="text-align:left;"> &lt; .001 </td>
  </tr>
</tbody>
</table>

 </td>
   <td> 

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:left;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> prior </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 289 </td>
   <td style="text-align:left;"> &lt; .001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> condition </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:left;"> &lt; .001 </td>
  </tr>
</tbody>
</table>

 </td>
  </tr>
</tbody>
</table>

Repeating the exercise of comparing the amount of evidence for comparison with and without inclusion of a covariate shows that the value of the test statistic is larger (Table \@ref(tab:tbl-anovatabSSVB)), indicative of stronger evidence with the analysis of covariance model: the conclusion would be unaffected with such large sample sizes. We of course care very little for the global $F$ test of equality of mean, as the previous study had shown large differences. What is more interesting here is quantifying the change between conditions.


<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:tbl-contraststabSSVB)Pairwise contrasts with $p$-values adjusted using Holm--Bonferroni for the ANOVA model (without $\texttt{prior}$ belief score).</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> contrast </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:left;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> consensus vs control </td>
   <td style="text-align:right;"> -12.0 </td>
   <td style="text-align:right;"> 4.0 </td>
   <td style="text-align:right;"> 558 </td>
   <td style="text-align:right;"> -3.01 </td>
   <td style="text-align:left;"> .003 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> consensus vs BoostPlus </td>
   <td style="text-align:right;"> 16.3 </td>
   <td style="text-align:right;"> 4.7 </td>
   <td style="text-align:right;"> 546 </td>
   <td style="text-align:right;"> 3.49 </td>
   <td style="text-align:left;"> .001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BoostPlus vs control </td>
   <td style="text-align:right;"> -28.3 </td>
   <td style="text-align:right;"> 4.4 </td>
   <td style="text-align:right;"> 506 </td>
   <td style="text-align:right;"> -6.49 </td>
   <td style="text-align:left;"> &lt; .001 </td>
  </tr>
</tbody>
</table>

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:tbl-contraststabSSVB)Pairwise contrasts with $p$-values adjusted using Holm--Bonferroni for the ANCOVA model (with $\texttt{prior}$ belief score).</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> contrast </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std.error </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:left;"> p.value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> consensus vs control </td>
   <td style="text-align:right;"> -11.8 </td>
   <td style="text-align:right;"> 3.3 </td>
   <td style="text-align:right;"> 543 </td>
   <td style="text-align:right;"> -3.54 </td>
   <td style="text-align:left;"> &lt; .001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> consensus vs BoostPlus </td>
   <td style="text-align:right;"> 17.5 </td>
   <td style="text-align:right;"> 4.3 </td>
   <td style="text-align:right;"> 524 </td>
   <td style="text-align:right;"> 4.11 </td>
   <td style="text-align:left;"> &lt; .001 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BoostPlus vs control </td>
   <td style="text-align:right;"> -29.3 </td>
   <td style="text-align:right;"> 3.9 </td>
   <td style="text-align:right;"> 459 </td>
   <td style="text-align:right;"> -7.45 </td>
   <td style="text-align:left;"> &lt; .001 </td>
  </tr>
</tbody>
</table>

Table \@ref(tab:tbl-contraststabSSVB) shows the pairwise contrasts, which measure two different things: the analysis of variance model compares the average in group, whereas the analysis of covariance (the linear model with `prior`) uses detrended values and focuses on the change in perception. Because the data are unbalanced and we estimate group mean and variance separately, the degrees of freedom change from one pairwise comparison to the next. Again, using the covariate `prior`, which is somewhat strongly correlated with `post` as seen in Figure \@ref(fig:fig-vanStekS3), helps decrease background noise.

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:tab-vanStekS3)Summary statistics of belief as a function of time of measurement and experimental condition.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> time </th>
   <th style="text-align:left;"> condition </th>
   <th style="text-align:right;"> mean </th>
   <th style="text-align:right;"> se </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> prior </td>
   <td style="text-align:left;"> BoostPlus </td>
   <td style="text-align:right;"> 57.65 </td>
   <td style="text-align:right;"> 1.69 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> prior </td>
   <td style="text-align:left;"> consensus </td>
   <td style="text-align:right;"> 56.32 </td>
   <td style="text-align:right;"> 1.67 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> prior </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 56.49 </td>
   <td style="text-align:right;"> 1.68 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> post </td>
   <td style="text-align:left;"> BoostPlus </td>
   <td style="text-align:right;"> 2.62 </td>
   <td style="text-align:right;"> 3.53 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> post </td>
   <td style="text-align:left;"> consensus </td>
   <td style="text-align:right;"> 18.93 </td>
   <td style="text-align:right;"> 3.06 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> post </td>
   <td style="text-align:left;"> control </td>
   <td style="text-align:right;"> 30.91 </td>
   <td style="text-align:right;"> 2.56 </td>
  </tr>
</tbody>
</table>


<div class="figure" style="text-align: center">
<img src="06-blocking_files/figure-html/fig-vanStekS3-1.png" alt="Difference between prior and post experiment beliefs on genetically engineered food." width="85%" />
<p class="caption">(\#fig:fig-vanStekS3)Difference between prior and post experiment beliefs on genetically engineered food.</p>
</div>


:::


:::pitfall
@vanStekelenburg:2021 split their data to do pairwise comparisons two at the time (thus taking roughly two-third of the data to perform a two sample _t_-test with each pair). Although it does not impact their conclusion, this approach is conceptually incorrect: if the variance was equal, we would want to use all observations to estimate it (so their approach would be suboptimal, since we would estimate the variance three times with smaller samples).

On the contrary, using a model that assumes equal variance when it is not the case leads to distortion: the variance we estimate will be some sort of average of the variability $\sigma_i$ and $\sigma_j$ in experimental condition $i$ and $j$, again potentially leading to distortions. With large samples, this may be unconsequential, but illustrates caveats of subsample analyses.


:::

:::pitfall

Figure \@ref(fig:fig-vanStekS3f1) shows the relationship between prior and posterior score. The data show clear difference between individuals: many start from completely disbelieving of genetically engineered food and change their mind (sometimes drastically), there are many people who do not change idea at all and have similar scores, and many who give a posterior score of zero. This heterogeneity in the data illustrates the danger of only looking at the summary statistics and comparing averages. It does not tell the whole picture! One could investigate whether the strength of religious or political beliefs, or how much participants trust scientists, could explain some of the observed differences.

<div class="figure" style="text-align: center">
<img src="06-blocking_files/figure-html/fig-vanStekS3f1-1.png" alt="Scatterplot of negated prior and posterior belief score." width="85%" />
<p class="caption">(\#fig:fig-vanStekS3f1)Scatterplot of negated prior and posterior belief score.</p>
</div>

:::

## Sample size consideration

We will distinguish between different 
<!-- Dean, Voss, Daguliic (2017), Section 10.2 -->

<!--
## Block designs with more one or more blocking factors

How to allocation observations optimally?
Do we need observations in each cells? Examples of designs

## Effect size for block designs

Removing the variability of the block.
Also for power calculations (partial)


-->



:::keyidea

**Summary**:

* Inclusion of blocking factor and continuous covariates may help filtering out unwanted variability.
* These are typically concomitant variables (measured alongside the response variable).
* These designs reduce the residual error, leading to an increase in power (more ability to detect differences in average between experimental conditions).
* We are only interested in differences due to experimental condition (marginal effects).
* In general, there should be no interaction between covariates/blocking factors and experimental conditions. 
* This hypothesis can be assessed by comparing the models with and without interaction, if there are enough units (e.g., equality of slope for ANCOVA).

:::



::: yourturn

- @Box:1978 write on page 103 the following moto:

> Block what you can and randomize what you cannot.

Explain the main benefit of blocking for confounding variables (when possible) over randomization.

:::
