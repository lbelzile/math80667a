# Effect sizes and power

In social studies, it is common to write a paper containing multiple studies on a similar topic. These may use different designs, with varying sample size. If the studies uses different questionnaires, or change the Likert scale, the results and the mean difference between groups are not directly comparable between experiments.

Another related task is replication of study, whereby researchers use the same material and setting and re-run an experiment with different data. For the replication to be somewhat successful (or at least reliable), one needs to determine beforehand how many participants should be recruited in the study. In order to do so, one needs to have a measure of effect size and set the desired power.

We could think for an example of comparing statistics or $p$-values, which are by construction standardized unitless measures, making them comparable across study.
Test statistics show how outlying observed differences between experimental conditions relative to a null hypothesis, typically that of no effect (equal mean in each subgroup). However, statistics are usually a function of both the sample size (the number of observations in each experimental condition) and the effect size (how large the standardized differences between groups are), making them unsuitable for describing differences.



<div class="figure" style="text-align: center">
<img src="07-power_effect_files/figure-html/fig-effectsize-1.png" alt="True sampling distribution for a two-sample $t$-test under the alternative (rightmost curve) and null distribution (leftmost curve) with small  (left panel) and large (right panel) sample sizes." width="90%" />
<p class="caption">(\#fig:fig-effectsize)True sampling distribution for a two-sample $t$-test under the alternative (rightmost curve) and null distribution (leftmost curve) with small  (left panel) and large (right panel) sample sizes.</p>
</div>


 Figure \@ref(fig:fig-effectsize) shows an example with the sampling distributions of the difference in mean under the null (curve centered at zero) and the true alternative (mean difference of two).  The area in white under the curve represents the power, which is larger with larger sample size and coincides with smaller average $p$-values for the testing procedure. 
 
 One could argue that, on the surface, every null hypothesis is wrong and that, with a sufficiently large number of observation, all observed differences eventually become "statistically significant". This has to do with the fact that we become more and more certain of the estimated means of each experimental sub-condition. Statistical significance of a testing procedure does not translate into practical relevance, which itself depends on the scientific question at hand.
For example, consider the development of a new drug for commercialization by Health Canada: what is the minimum difference between two treatments that would be large enough to justify commercialization of the new drug? If the effect is small but it leads to many lives saved, would it still be relevant? Such decision involve a trade-off between efficacy of new treatment relative to the status quo, the cost of the drug, the magnitude of the improvement, etc.


Effect size are summaries to inform about the standardized magnitude of these differences; they are used to combine results of multiple experiments using meta-analysis, or to calculate sample size requirements to replicate an effect in power studies.


## Effect sizes

There are two main classes of effect size: standardized mean differences and ratio (percentages) of explained variance. The latter are used in analysis of variance when there are multiple groups to compare.

Unfortunately, the literature on effect size is quite large. Researchers often fail to distinguish between estimand (unknown target) and the estimator that is being used, with frequent notational confusion arising due to conflicting standards and definitions. Terms are also overloaded: the same notation may be used to denote an effect size, but it will be calculated differently depending on whether the design is between-subject or within-subject (with repeated correlated measures per participant), or whether there are blocking factors.

### Standardized mean differences

To gather intuition, we begin with the task of comparing the means of two groups using a two-sample $t$-test, with the null hypothesis of equality in means or $\mathscr{H}_0: \mu_1 = \mu_2$. The test statistic is 
\begin{align*}
T =  \frac{\widehat{\mu}_2 - \widehat{\mu}_1}{\widehat{\sigma}} \left(\frac{1}{n_1}+\frac{1}{n_2}\right)^{-1/2}
\end{align*}
where $\widehat{\sigma}$ is the pooled sample size estimator. The first term, $\widehat{d}_s = (\widehat{\mu}_2 - \widehat{\mu}_1)/\widehat{\sigma}$, is termed Cohen's $d$ [@Cohen:1988] and it measures the standardized difference between groups, a form of signal-to-noise ratio. As the sample size gets larger and larger, the sample mean and pooled sample variance become closer and closer to the true population values $\mu_1$, $\mu_2$ and $\sigma$; at the same time, the statistic $T$ becomes bigger as $n$ becomes larger because of the second term.^[If we consider a balanced sample, $n_1 = n_2 = n/2$ we can rewrite the statistic as $T = \sqrt{n} \widehat{d}_s/2$ and the statement that $T$ increases with $n$ on average becomes more obvious.] 

The difference $d=(\mu_1-\mu_2)/\sigma$ has an obvious interpretation: a distance of $a$ indicates that the means of the two groups are $a$ standard deviation apart. Cohen's $d$ is sometimes loosely categorized in terms of weak ($d = 0.2$), medium ($d=0.5$) and large ($d=0.8$) effect size; these, much like arbitrary $p$-value cutoffs, are rules of thumbs. Alongside $d$, there are many commonly reported metrics that are simple transformations of $d$ describing the observed difference. This interactive  [applet](https://rpsychologist.com/cohend/) by Kristoffer Magnusson [@magnussonCohend] shows the visual impact of changing the value of $d$ along.
There are different estimators of $d$ depending on whether or not the pooled variance estimator is used. Cohen's $d$, is upward biased, meaning it gives values that are on average larger than the truth. Hedge's $g$ [@Hedges:1981] offers a bias-correction and should always be preferred as an estimator.

For these different estimators, it is possible to obtain (asymmetric) confidence intervals or tolerance intervals.[By using the pivot method [@Steiger:2004] and relating the effect size to the noncentrality parameter of the null distribution, whether $\mathsf{St}$, $\mathsf{F}$ or $\chi^2$.]


::: {.example #LiuRimMinMin2022E1effect name="The Surprise of Reaching Out"}





We consider a two-sample $t$-test for the study of @Liu.Rim.Min.Min:2022 discussed in Example \@ref(exm:LiuRimMinMin2022E1). The difference in average response index is 0.371, indicating that the responder have a higher score. The $p$-value is 0.041, showing a small effect. 

If we consider the standardized difference $d$, the group means are -0.289 standard deviations apart based on Hedge's $g$, with an associated 95% confidence interval of [-0.567, -0.011]: thus, the difference found is small (using @Cohen:1988's convention) and there is a large uncertainty surrounding it. 

There is a 42% probability that an observation drawn at random from the responder condition will exceed the mean of the initiator group (probability of superiority) and 41.9% of the responder observations will exceed the mean of the initiator.


```r
data(LRMM22_S1, package = "hecedsm")
ttest <- t.test(
  appreciation ~ role, 
  data = LRMM22_S1,
  var.equal = TRUE)
effect <- effectsize::hedges_g(
  appreciation ~ role, 
  data = LRMM22_S1, 
  pooled_sd = TRUE)
effectsize::d_to_cles(effect)
```

:::






## Power


To calculate the power of a test, we need to single out a specific alternative hypothesis. In very special case, analytic derivations are possible. For a given alternative, we 

- simulate repeatedly samples from the model from the hypothetical alternative world
- we compute the test statistic for each of these new samples
- we transform these to the associated *p*-values based on the postulated null hypothesis.

At the end, we calculate the proportion of tests that lead to a rejection of the null hypothesis at level $\alpha$, namely the percentage of *p*-values smaller than $\alpha$.

