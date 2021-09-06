# Hypothesis testing {#hypothesis-testing}

In most applied domains, empirical evidences drive the advancement of the field and data from well designed experiments contribute to the built up of science. In order to draw conclusions in favour or against a theory, researchers turn (often unwillingly) to statistics to back up their claims. This has led to the prevalence of the use of the null hypothesis statistical testing (NHST) framework. One important aspect of the reproducibility crisis is the misuse of $p$-values in journal articles: falsification of a null hypothesis is not enough to provide substantive findings for a theory.

  
Because introductory statistics course typically present hypothesis tests without giving much thoughts to the underlying construction principles of such procedures, users often have a reductive view of statistics as a catalogue of pre-determined procedures. To make a culinary analogy, users focus on learning recipes rather than trying to understand the basics of cookery. This chapter focuses on understanding of key ideas related to testing.


## Sampling variability

We are typically interested in some characteristic of the population, oftentimes the (conditional) theoretical average of a continuous response variable, denoted $\mu$. This quantity exists, but is unknown to us so the best we can do is estimate it using random samples that are drawn from the population. 

We call numerical summaries of the data **statistics**. Its important to distinguish between procedures/formulas and their numerical values. An **estimator** is a rule or formula used to calculate an estimate of some parameter or quantity of interest based on observed data (like a recipe for cake). Once we have observed data we can actually compute the sample mean, that is, we have an estimate --- an actual value (the cake).  In other words,

- an estimator is the procedure or formula telling us how to transform the sample data into a numerical summary. Its output is random: even if you repeat a recipe, you won't get the same exact output everytime.
- an estimate is the numerical value obtained once we apply the formula to observed data.


For example, the sample mean of a sample of size $n$ is the sum of its elements divided by the sample size, $\overline{Y}=n^{-1}(Y_1 + \cdots + Y_n)$. Because the inputs of the function $\overline{Y}$ are random, the estimator $\overline{Y}$ is also random. To illustrate this point, Figure \@ref(fig:samplevar) shows five simple random samples of size $n=10$ drawn from an hypothetical population with mean $\mu$ and standard deviation $\sigma$, along with their sample mean $\overline{y}$. Thus, sampling variability implies that the sample means of the subgroups will always differ even if the share the same characteristics. You can view sampling variability as noise: our goal is to extract the signal (typically differences in means) but accounting for spurious results due to the background noise.

<div class="figure" style="text-align: center">
<img src="02-hypothesis_testing_files/figure-html/samplevar-1.png" alt="Five samples of size $n=10$ drawn from a common population with mean $\mu$ (horizontal line). The colored segments show the sample means of each sample." width="85%" />
<p class="caption">(\#fig:samplevar)Five samples of size $n=10$ drawn from a common population with mean $\mu$ (horizontal line). The colored segments show the sample means of each sample.</p>
</div>

We can clearly see from Figure \@ref(fig:samplevar) that, even if each sample is drawn from the same population, the sample mean varies from one sample to the next as a result of the sampling variability. The astute eye will however notice that the sample means are less dispersed around $\mu$ than the individual measurements. This is because the sample mean $\overline{Y}$ is based on multiple observations, so there is more information available. This is a fundamental principle of statistics: information accumulated as you get more information, so estimation becomes less noisy.

Since values of the sample mean don't tell the whole picture, we may also consider their variability. The sample variance $S_n$ is an estimator of the standard deviation $\sigma$, where \begin{align*}
S^2_n &= \frac{1}{n-1} \sum_{i=1}^n (X_i-\overline{X})^2.
\end{align*} 
The square root of the variance of a statistic is termed **standard error**; it should not be confused with the standard deviation $\sigma$ of the population from which the sample observations $Y_1, \ldots$ are drawn. Both standard deviation and standard error are expressed in the same units as the measurements, so are easier to interpret than variance. Since the standard error is a function of the sample size, it is however good practice to report the estimated standard deviation in reports.

::: { .example name="Sample proportion and uniform draws"}

To illustrate the concept of sampling variability, we follow the lead of [Matthew Crump](https://www.crumplab.com/statistics/foundations-for-inference.html) and consider samples from a uniform distribution on $\{1, 2, \ldots, 10\}$ each number in this interval is equally likely to be sampled. 
<div class="figure" style="text-align: center">
<img src="02-hypothesis_testing_files/figure-html/unifsamp1-1.png" alt="Histograms for 10 random samples of size $n=20$ from a discrete uniform distribution." width="85%" />
<p class="caption">(\#fig:unifsamp1)Histograms for 10 random samples of size $n=20$ from a discrete uniform distribution.</p>
</div>

Even if they are drawn from the same population, the 10 samples in Figure \@ref(fig:unifsamp1) look quite different. The only thing at play here is the sample variability: since there are $n=20$ observations in total, there should be on average 10% of the observations in each of the 10 bins, but some bins are empty and others have too many counts. This fluctuation is due to randomness, or chance. 

How can we thus detect whether what we see is compatible with the model we think generated the data? The key is to collect more observations: the bar height is the sample proportion, an average of 0/1 values with ones indicating that the observation is in the bin and zero otherwise.

Consider now what happens as we increase the sample size: the top panel of Figure \@ref(fig:uniformsamp2) shows uniform samples for increasing samples size. The histogram looks more and more like the true underlying distribution (flat) as the sample size increases and it's nearly indistinguishable from the theoretical one (straight line) when $n=10 000$. Here, the variability decreases by a tenfold every time the sample size increases by a factor 100. The bottom panel, on the other hand, isn't from a uniform distribution and larger samples come closer to the population distribution. We couldn't have spotted this difference in the first two plots, since the sampling variability is too important; there, the lack of data in some bins could have been attributed to chance. This is in line with most practical applications, in which the limited sample size restricts our capacity to disentangle real differences from sampling variability. We must embrace this uncertainty:  in the next section, we outline how hypothesis testing helps us disentangle the signal from the noise.

<div class="figure" style="text-align: center">
<img src="02-hypothesis_testing_files/figure-html/uniformsamp2-1.png" alt="Histograms of data from a uniform distribution (top) and non-uniform (bottom) with increasing sample sizes of 10, 100, 1000 and 10 000 (from left to right)." width="85%" />
<p class="caption">(\#fig:uniformsamp2)Histograms of data from a uniform distribution (top) and non-uniform (bottom) with increasing sample sizes of 10, 100, 1000 and 10 000 (from left to right).</p>
</div>


:::




## Hypothesis testing {#tests}

An hypothesis test is a binary decision rule (yes/no) used to evaluate the statistical evidence provided by a sample to make a decision regarding the underlying population. The main steps involved are:

- define the model parameters
- formulate the alternative and null hypothesis
- choose and calculate the test statistic
- obtain the null distribution describing the behaviour of the test statistic under $\mathscr{H}_0$
- calculate the _p_-value
- conclude (reject or fail to reject $\mathscr{H}_0$) in the context of the problem.

A good analogy for hypothesis tests is a trial for murder on which you are appointed juror.

- The judge lets you choose between two mutually exclusive outcome, guilty or not guilty, based on the evidence presented in court.
- The presumption of innocence applies and evidences are judged under this optic: are evidence remotely plausible if the person was innocent?  The burden of the proof lies with the prosecution to avoid as much as possible judicial errors. The null hypothesis $\mathscr{H}_0$ is *not guilty*, whereas the alternative $\mathscr{H}_a$ is *guilty*. If there is a reasonable doubt, the verdict of the trial will be not guilty.
- The test statistic (and the choice of test) represents the summary of the proof. The more overwhelming the evidence, the higher the chance the accused will be declared guilty. The prosecutor chooses the proof so as to best outline this: the choice of evidence (statistic) ultimately will maximize the evidence, which parallels the power of the test.
- The null distribution is the benchmark against which to judge the evidence (jurisprudence). Given the proof, what are the odds assuming the person is innocent? Since this is possibly different for every test, it is common to report instead a _p_-value, which gives the level of evidence on a uniform scale which is most easily interpreted.
- The final step is the verdict, a binary decision with outcomes: guilty or not guilty. For an hypothesis test performed at level $\alpha$, one would reject (guilty) if the _p_-value is less than $\alpha$. Even if we declare the person not guilty, this doesn't mean the defendant is innocent and vice-versa.


### Hypothesis

In statistical tests we have two hypotheses: the null hypothesis ($\mathscr{H}_0$) and the alternative hypothesis ($\mathscr{H}_1$). Usually, the null hypothesis (the 'status quo') is a single numerical value. The alternative is what we're really interested in testing. In \@ref(fig:samplevar), we could consider whether all five groups have the same mean $\mathscr{H}_0: \mu_1 = \mu_2 = \cdots = \mu_5$ against the alternative that at least two of them are different. These two outcomes are mutually exclusive and cover all possible cases. A statistical hypothesis test allows us to decide whether or not our data provides enough evidence to reject $\mathscr{H}_0$ in favor of $\mathscr{H}_1$, subject to some pre-specified risk of error: while we know that the differences are just due to sampling variability in \@ref(fig:samplevar) because the data is fake, in practice we need to assess the evidence using a numerical summary. 

### Test statistic

A test statistic $T$ is a function of the data which takes the data as input and outputs a summary of the information contained in the sample for a characteristic of interest, say the population mean. The form of the test statistic is chosen such that we know how it behaves if the null hypothesis is true (e.g., no difference in the overall means of the different groups). In order to assess whether the numerical value for $T$ is unusual, we need to know what are the potential values taken by $T$ and their relative probability if $\mathscr{H}_0$ is true. This allows us to determine what values of $T$ are likely if $\mathscr{H}_0$ is true. Many statistics we will consider are of the form^[This class of statistic, which includes $t$-tests, are Wald statistics.]
\begin{align*}
T = \frac{\text{estimated effect}- \text{postulated effect}}{\text{estimated effect variability}} = \frac{\widehat{\theta} - \theta_0}{\mathrm{se}(\widehat{\theta})}
\end{align*}
where $\widehat{\theta}$ is an estimator of $\theta$, $\theta_0$ is the postulated value of the parameter and  $\mathrm{se}(\widehat{\theta})$ is the standard error of the test statistic $\widehat{\theta}$, which is a measure of its variability. This quantity is designed so that if there is no difference, $T$ has approximately mean zero and variance one. This standardization makes comparison easier.

For example, if we are interested in mean differences between treatment group and control group, denoted $\mu_1$ and $\mu_0$, then $\theta = \mu_0-\mu_1$ and  $\mathscr{H}_0: \mu_0 = \mu_1$ corresponds to $\mathscr{H}_0: \theta = 0$ for no difference. The numerator would thus consist of the difference in sample means and the denominator the standard error of that quantity, calculated using a software.



For example, to test whether the mean of a population is zero, we set
\begin{align*}
\mathscr{H}_0: \mu=0, \qquad  \mathscr{H}_a:\mu \neq 0,
\end{align*}
and the usual $t$-statistic is
\begin{align}
T &= \frac{\overline{X}-0}{S_n/\sqrt{n}}
(\#eq:ttest)
\end{align}
where $\overline{X}$ is the sample mean of $X_1, \ldots, X_n$ and the denominator of \@ref(eq:ttest) is the standard error of the sample mean, $\mathsf{se}(\overline{Y}) = \sigma/\sqrt{n}$. The precision of the sample mean increases proportionally to the square root of the sample size: the standard error gets halved if we double the number of observations, but only decreases by a factor 10 if we have 100 times more observations. Similar calculations hold for the two-sample $t$-test, whereby $\widehat{\theta} = \overline{Y}_1 - \overline{Y}_0$ for treatment group $T_1$ and control $T_0$. Assuming equal variance, the denominator is estimated using the pooled variance.


### Null distribution and _p_-value

The _p_-value allows us to decide whether the observed value of the test statistic $T$ is plausible under $\mathscr{H}_0$. Specifically, the _p_-value is the probability that the test statistic is equal or more extreme to the estimate computed from the data, assuming $\mathscr{H}_0$ is true. Suppose that based on a random sample $X_1, \ldots, X_n$ we obtain a statistic whose value $T=t$. For a two-sided test $\mathscr{H}_0:\theta=\theta_0$ vs. $\mathscr{H}_a:\theta \neq \theta_0$, the _p_-value is $\mathsf{Pr}_0(|T| \geq |t|)$. If the distribution of $T$ is symmetric around zero, the _p_-value is
\begin{align*}
p = 2 \times \mathsf{Pr}_0(T \geq |t|).
\end{align*}

How do we determine the null distribution given that the true data generating mechanism is unknown to us? In simple cases, it might be possible to enumerate all possible outcomes and thus quantity the degree of outlyingness of our observed statistic. In more general settings, we can resort to simulations or to probability theory: the central limit theorem says that the tell us that the sample mean behaves like a normal random variable with mean $\mu$ and standard deviation $\sigma/\sqrt{n}$ for $n$ large enough. The central limit theorem has broader applications since it applies to any average, and we it can be use to derive benchmarks for most commonly used statistics in large samples. Most software use these approximations as proxy by default: the normal, Student's $t$, $\chi^2$ and $F$ distributions are the reference distributions that arise the most often. 


<div class="figure" style="text-align: center">
<img src="02-hypothesis_testing_files/figure-html/power-plots-1.png" alt="Density of _p_-values under the null hypothesis (left) and under an alternative with a signal-to-noise ratio of 0.5 (right). The probability of rejection $\mathscr{H}_0$ is 0.1, the area under the curve between zero and $\alpha=0.1$. Under the null, the density is uniform (flat rectangle of height 1) and all values in the unit interval are equally likely. Under the alternative, the _p_-values cluster towards zero and the probability of rejecting the null hypothesis increases together with the signal-to-noise (approximately 0.22 for the alternative)." width="85%" />
<p class="caption">(\#fig:power-plots)Density of _p_-values under the null hypothesis (left) and under an alternative with a signal-to-noise ratio of 0.5 (right). The probability of rejection $\mathscr{H}_0$ is 0.1, the area under the curve between zero and $\alpha=0.1$. Under the null, the density is uniform (flat rectangle of height 1) and all values in the unit interval are equally likely. Under the alternative, the _p_-values cluster towards zero and the probability of rejecting the null hypothesis increases together with the signal-to-noise (approximately 0.22 for the alternative).</p>
</div>


There are generally three ways of obtaining null distributions for assessing the degree of evidence against the null hypothesis

- exact calculations
- large sample theory (aka 'asymptotics' in statistical lingo)
- simulation

While desirable, the first method is only applicable in simple cases (such as counting the probability of getting two six if you throw two fair die). The second method is most commonly used due to its generality and ease of use (particularly in older times where computing power was scarce), but fares poorly with small sample sizes (where 'too small' is context and test-dependent). The last approach can be used to approximate the null distribution in many scenarios, but adds a layer of randomness and the extra computations costs sometimes are not worth it. 

### Conclusion




The *p*-value allows us to make a decision about the null hypothesis. If $\mathscr{H}_0$ is true, the *p*-value follows a uniform distribution, as shown in Figure \@ref(fig:power-plots). [Thus, if the *p*-value is small](https://xkcd.com/1478/), this means observing an outcome more extreme than $T=t$ is unlikely, and so we're inclined to think that $\mathscr{H}_0$ is not true. There's always some underlying risk that we're making a mistake when we make a decision. In statistic, there are [two type of errors](https://xkcd.com/2303/):


- type I error: we reject $\mathscr{H}_0$ when $\mathscr{H}_0$ is true,
- type II error: we fail to reject $\mathscr{H}_0$ when $\mathscr{H}_0$.

The two hypothesis are not judged equally: we seek to avoid error of type I (judicial errors, corresponding to condamning an innocent). To prevent this, we fix a the level of the test, $\alpha$, which captures our tolerance to the risk of commiting a type I error: the higher the level of the test $\alpha$, the more often we will reject the null hypothesis when the latter is true. The value of $\alpha \in (0, 1)$ is the probability of rejecting $\mathscr{H}_0$ when $\mathscr{H}_0$ is in fact true,
\begin{align*}
\alpha = \mathsf{Pr}_0\left(\text{ reject } \mathscr{H}_0\right).
\end{align*}
The level $\alpha$ is fixed beforehand, typically $1$\%, $5$\% or $10$\%. Keep in mind that the probability of type I error is $\alpha$ only if the null model for $\mathscr{H}_0$ is correct (sic) and correspond to the data generating mechanism.


The focus on type I error is best understood by thinking about costs of moving away from the status quo: a new website design or branding will be costly to implement, so you want to make sure there are enough evidence that the proposal is the better alternative and will lead to increased traffic or revenues.


| **Decision** \\ **true model** | $\mathscr{H}_0$ | $\mathscr{H}_a$ |
| :-- | :-: | :-: |
| fail to reject $\mathscr{H}_0$ | $\checkmark$ | type II error |
| reject $\mathscr{H}_0$ |type I error | $\checkmark$|

To make a decision, we compare our *p*-value $P$ with the level of the test $\alpha$:

- if $P < \alpha$, we reject $\mathscr{H}_0$;
- if $P \geq \alpha$, we fail to reject $\mathscr{H}_0$.

Do not mix up level of the test (probability fixed beforehand by the researcher) and the *p*-value. If you do a test at level 5\%, the probability of type I error is by definition $\alpha$ and does not depend on the *p*-value. The latter is conditional probability of observing a more extreme statistic given the null distribution $\mathscr{H}_0$ is true.


::: { .example name="Gender inequality and permutation tests"}

We consider data from @Rosen:1974, who look at sex role stereotypes and their impacts on promotion and opportunities for women candidates. The experiment took place in 1972 and the experimental units, which consisted of 95 male bank supervisors, were submitted to various memorandums and asked to provide ratings or decisions based on the information provided. 

We are interested in Experiment 1 related to promotion of employees: managers were requested to decide on whether or not to promote an employee to become branch manager based on recommendations and ratings on potential for customer and employee relations. The authors intervention focused on the description of the nature (complexity) of the manager's job (either simple or complex) and the sex of the candidate (male or female): all files were similar otherwise.

The authors played with two factors: nature (complexity) of the manager's job (either simple or complex) and the sex of the candidate (male or female): all files were similar otherwise.

We consider for simplicity only sex as a factor and aggregate over job for the $n=93$ replies. Table \@ref(tab:rosen-table1) shows the counts for each possibility.

<table>
<caption>(\#tab:rosen-table1)Promotion recommandation to branch manager based on sex of the applicant.</caption>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> male </th>
   <th style="text-align:right;"> female </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> promote </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hold file </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 30 </td>
  </tr>
</tbody>
</table>


The null hypothesis of interest here that sex has no impact, so the probability of promotion is the same for men and women. Let $p_{\text{m}}$ and $p_{\text{w}}$ denote these respective probabilities; we can thus write mathematically the null hypothesis as $\mathscr{H}_0: p_{\text{m}} = p_{\text{w}}$ against the alternative $\mathscr{H}_a: p_{\text{m}} \neq p_{\text{w}}$.

The test statistic typically employed for two by two contingency tables is a chi-square test^[If you have taken advanced modelling courses, this is a score test obtained by fitting a Poisson regression with `sex` and `action` as covariates; the null hypothesis corresponding to lack of interaction term between the two.], which compares the overall proportions of promoted to that in for each subgroup. The sample proportion for male is 32/42 = ~76\%, compared to 19/49 or ~49\% for female --- note that these are sample averages if we set `promote=1` and `hold file=0`. While it seems that this difference of 16\% is large, it could be spurious: the standard error for the sample proportions is roughly 3.2\% for male and 3.4\% for female. 

If there was no discrimination based on sex, we would expect the proportion of people promoted to be the same overall; this is 51/93 =0.55 for the pooled sample. We could simply do a test for the mean difference, but rely instead on the chi-square test, which compares the expected counts (based on equal promotion rates) to the observed counts, suitably standardized. If the discrepancy is large between expected and observed, than this casts doubt on the validity of the null hypothesis.


```r
## Create a 2x2 matrix (contingency table) with the counts
dat_exper1 <- matrix(c(32L, 12L, 19L, 30L), ncol = 2, nrow = 2, byrow = TRUE)
# Calculate the statistic on data
obs_stat <- chisq.test(x = dat_exper1, correct = FALSE)
# Tidy output to get a tibble
test_res <- broom::tidy(obs_stat)
```

<table>
<caption>(\#tab:print-tab-example-chisq-test-rosen)Chi-square test for experiment 1 of Rosen and Jerdee (1974)</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> statistic </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:right;"> parameter </th>
   <th style="text-align:left;"> method </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 10.8 </td>
   <td style="text-align:right;"> 0.001 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> Pearson's Chi-squared test </td>
  </tr>
</tbody>
</table>


If the counts of each cell are large, the null distribution of the chi-square test is well approximated by a $\chi^2$ distribution. The output of the test includes the value of the statistic, the degrees of freedom of the $\chi^2$ approximation and the _p_-value, which gives the probability that a random draw from a $\chi^2_1$ distribution is larger than the observed test statistic **assuming the null hypothesis is true**. The _p_-value is very small, 0.001, which means such a result is quite unlikely to happen by chance if there was no sex-discrimination.


There are alternative test statistics that could be used, among which the odds ratio. The odds of an event is the ratio of the number of success over failure: in our example, this would be the number of promoted over held files. The odds of promotion for male is 32/12, whereas that of female is 19/30. The odds ratio for male versus female is thus $\mathsf{OR}=$ (32/12) / (19/30)= 4.21. Under the null hypothesis, $\mathscr{H}_0: \mathsf{OR}=$ 1 (same probability of being promoted) (why?)

Fisher's test assumes that the row and sum totals are fixed (that is, the number of promoted/withheld files and male/female are fixed at the design stage) and uses this to derive the exact probability of observing this particular configuration if the proportion of success was the same. The test statistic for Fisher's exact test, obtained by running `fisher.test(dat_exper1)`, is different but so is the null distribution^[The null distribution for Fisher's exact test is hypergeometric. This fact is well known in combinatorics, also known as the art of counting marbles.]. On the contrary, the _p_-value is very close to the one reported for the $\chi^2$ test in Table \@ref(tab:print-tab-example-chisq-test-rosen).


<table>
<caption>(\#tab:print-tab-example-fisher-test-rosen)Fisher's exact test for experiment 1 of Rosen and Jerdee (1974)</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> p.value </th>
   <th style="text-align:left;"> method </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 4.1 </td>
   <td style="text-align:right;"> 0.0016 </td>
   <td style="text-align:left;"> Fisher's Exact Test for Count Data </td>
  </tr>
</tbody>
</table>

Yet another alternative to obtain a benchmark to assess the outlyingness of the observed odds ratio is to use simulations. Consider a database containing the raw data with 93 rows, one for each manager, with for each an indicator of `action` and the `sex` of the hypothetical employee presented in the task.



<table>
<caption>(\#tab:dat-long-test-rosen-print)First five rows of the database in long format for experiment 1 of Rosen and Jerdee.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> action </th>
   <th style="text-align:left;"> sex </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> hold file </td>
   <td style="text-align:left;"> female </td>
  </tr>
  <tr>
   <td style="text-align:left;"> promote </td>
   <td style="text-align:left;"> female </td>
  </tr>
  <tr>
   <td style="text-align:left;"> promote </td>
   <td style="text-align:left;"> male </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hold file </td>
   <td style="text-align:left;"> female </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hold file </td>
   <td style="text-align:left;"> female </td>
  </tr>
</tbody>
</table>

Under the null hypothesis, sex has no incidence on the action of the manager. This means we could get an idea of the "what-if" world by shuffling the sex labels repeatedly. Thus, we could obtain a benchmark by repeating the following steps multiple times:

1. permute the labels for `sex`,
2. recreate a contingency table by aggregating counts, 
3. calculate the odds ratio for the simulated table.


```r
library(infer)
# Calculate the odds ratio for the sample
obs_stat <- dat_exper1_long %>%
  specify(response = action, explanatory = sex, success = "promote") %>%
  calculate(stat = "odds ratio", order = c("male", "female"))
# Approximate the null distribution using a permutation test  
set.seed(2021) # set random seed
null_dist <- dat_exper1_long %>%
    specify(response = action, explanatory = sex, success = "promote") %>%
    hypothesize(null = "independence") %>% # sex doesn't impact decision
    generate(reps = 9999, type = "permute") %>% # shuffle sex
    calculate(stat = "odds ratio", order = c("male", "female")) 
# Visualize the null distribution
ggplot(data = null_dist, # a tibble with a single variable, 'stat'
       mapping = aes(x = stat)) + # map 'stat' to the x-axis
  geom_bar() + # bar plot b/c data are discrete (few combinations)
  labs(x = "odds ratio") + # give meaningful label
  geom_vline(data = obs_stat, # add vertical line
             mapping = aes(xintercept = stat), # position on x-axis of line
             color = "red") # color
# Obtain the p-value
null_dist %>%
  get_p_value(obs_stat = obs_stat, direction = "two-sided")
#> # A tibble: 1 × 1
#>   p_value
#>     <dbl>
#> 1 0.00240
```

<div class="figure" style="text-align: center">
<img src="02-hypothesis_testing_files/figure-html/infer-odds-ratio-permutation-1.png" alt="Histogram of the simulated null distribution obtained using a permutation test; the vertical red line indicates the sample odds ratio." width="85%" />
<p class="caption">(\#fig:infer-odds-ratio-permutation)Histogram of the simulated null distribution obtained using a permutation test; the vertical red line indicates the sample odds ratio.</p>
</div>

Reassuringly, we again get roughly the same _p_-value. The histogram in \@ref(fig:infer-odds-ratio-permutation) shows the distribution of 

The article concluded (in light of the above and further experiments)

> Results confirmed the hypothesis that male administrators tend to discriminate against female employees in personnel decisions involving promotion, development, and supervision.

:::

:::pitfall

In the first experiment, managers were also asked to rank applications on their potential for both employee and customer relations using a Likert scale of six items ranging from (1) extremely unfavorable to (6) extremely favorable. However, only the averages are reported in Table 1 along with [@Rosen:1974]

> Mean rating for the male candidate was 4.73 compared to a mean rating of 4.25 for the female candidate ($F=4.76, \text{df} = 1/80, p < .05$)

In itself, this information isn't sufficient: we don't know the test used, and more importantly the degrees of freedom (80) are much too few compared to the number of observations, implying non-response that isn't discussed elsewhere.

Partial or selective reporting of statistical procedures hinders reproducibility. There are many improvements that would have possible in the presentation, including explicitly stating which test statistic is employed (the $\chi^2$ value seemingly doesn't correspond to the chi-square test or is incorrectly reported), providing the sample size, means variance estimates, the null distribution and its parameters, if any. Without these, we are left to speculate.

:::

### Power

There are two sides to an hypothesis test: either we want to show it is not unreasonable to assume the null hypothesis, or else we want to show beyond reasonable doubt that a difference or effect is significative: for example, one could wish to demonstrate that a new website design (alternative hypothesis) leads to a significant increase in sales relative to the status quo. Our ability to detect these improvements and make discoveries depends on the power of the test: the larger the power, the greater our ability to reject $\mathscr{H}_0$ when the latter is false. The power summarizes the level of evidence for various combination of parameters (effect size, variability, sample size).

Failing to reject $\mathscr{H}_0$ when $\mathscr{H}_a$ is true (not guilty verdict of a criminal) corresponds to the definition of type II error, the probability of which is $1-\gamma$, say. The **power of a test** is the probability of **correctly** rejecting $\mathscr{H}_0$ when $\mathscr{H}_0$ is false, i.e.,
\begin{align*}
\gamma = \mathsf{Pr}_a(\text{reject} \mathscr{H}_0)
\end{align*}
Depending on the alternative models, it is more or less easy to detect that the null hypothesis is false and reject in favor of an alternative.
Power is thus a measure of our ability to detect real effects.

<div class="figure" style="text-align: center">
<img src="02-hypothesis_testing_files/figure-html/power1-1.png" alt="Comparison between null distribution (full curve) and a specific alternative for a *t*-test (dashed line). The power corresponds to the area under the curve of the density of the alternative distribution which is in the rejection area (in white)." width="85%" />
<p class="caption">(\#fig:power1)Comparison between null distribution (full curve) and a specific alternative for a *t*-test (dashed line). The power corresponds to the area under the curve of the density of the alternative distribution which is in the rejection area (in white).</p>
</div>

<div class="figure" style="text-align: center">
<img src="02-hypothesis_testing_files/figure-html/power2-1.png" alt="Increase in power due to an increase in the mean difference between the null and alternative hypothesis. Power is the area in the rejection region (in white) under the alternative distribution (dashed): the latter is more shifted to the right relative to the null distribution (full line)." width="85%" />
<p class="caption">(\#fig:power2)Increase in power due to an increase in the mean difference between the null and alternative hypothesis. Power is the area in the rejection region (in white) under the alternative distribution (dashed): the latter is more shifted to the right relative to the null distribution (full line).</p>
</div>

<div class="figure" style="text-align: center">
<img src="02-hypothesis_testing_files/figure-html/power3-1.png" alt="Increase of power due to an increase in the sample size or a decrease of standard deviation of the population: the null distribution (full line) is more concentrated. Power is given by the area (white) under the curve of the alternative distribution (dashed). In general, the null distribution changes with the sample size." width="85%" />
<p class="caption">(\#fig:power3)Increase of power due to an increase in the sample size or a decrease of standard deviation of the population: the null distribution (full line) is more concentrated. Power is given by the area (white) under the curve of the alternative distribution (dashed). In general, the null distribution changes with the sample size.</p>
</div>

We want to choose an experimental design and a test statistic that leads to high power, so that $\gamma$ is as close as possible to one. Minimally, the power of the test should be $\alpha$ because we reject the null hypothesis $\alpha$ fraction of the time even when $\mathscr{H}_0$ is true. Power depends on many criteria, notably

- the effect size: the bigger the difference between the postulated value for $\theta_0$ under $\mathscr{H}_0$ and the observed behaviour, the easier it is to departures from $\theta_0$.
(Figure \@ref(fig:power3)); it's easier to spot an elephant in a room than a mouse.
- variability: the less noisy your data, the easier it is to detect differences between the curves (big differences are easier to spot, as Figure \@ref(fig:power2) shows);
- the sample size: the more observation, the higher our ability to detect significative differences because the standard error decreases with sample size $n$ at a rate (typically) of $n^{-1/2}$. The null distribution also becomes more concentrated as the sample size increase. In experimental designs, power may be maximized by specifying different sample size in each group
- the choice of test statistic: for example, rank-based statistics discard information about the observed values of the response, focusing instead on their relative ranking. While the resulting tests are typically less powerful, they are more robust to model misspecification and outliers. 

To calculate the power of a test, we need to single out a specific alternative hypothesis. In very special case, analytic derivations are possible. For a given alternative, we 

- simulate repeatedly samples from the model from the hypothetical alternative world
- we compute the test statistic for each of these new samples
- we transform these to the associated *p*-values based on the postulated null hypothesis.

At the end, we calculate the proportion of tests that lead to a rejection of the null hypothesis at level $\alpha$, namely the percentage of *p*-values smaller than $\alpha$.



### Confidence interval



A **confidence interval** is an alternative way to present the conclusions of an hypothesis test performed at significance level $\alpha$. It is often combined with a point estimator $\hat{\theta}$ to give an indication of the variability of the estimation procedure. Wald-based  $(1-\alpha)$ confidence intervals for a parameter  $\theta$ are of the form
\begin{align*}
\widehat{\theta} \pm \mathfrak{q}_{\alpha/2} \; \mathrm{se}(\widehat{\theta})
\end{align*}
where $\mathfrak{q}_{\alpha/2}$ is the $1-\alpha/2$ quantile of the null distribution of the Wald statistic
\begin{align*}
T =\frac{\widehat{\theta}-\theta}{\mathrm{se}(\widehat{\theta})},
\end{align*}
and where $\theta$ represents the postulated value for the fixed, but unknown value of the parameter. The bounds of the confidence intervals are random variables, since both estimators of the parameter and its standard error, $\widehat{\theta}$ and $\mathrm{se}(\widehat{\theta})$, are random variables: their values will vary from one sample to the next.


For example, for a random sample $X_1, \ldots, X_n$ from a normal distribution $\mathsf{No}(\mu, \sigma)$, the ($1-\alpha$) confidence interval for the population mean $\mu$ is
\begin{align*}
\overline{X} \pm t_{n-1, \alpha/2} \frac{S}{\sqrt{n}}
\end{align*}
where $t_{n-1,\alpha/2}$ is the $1-\alpha/2$ quantile of a Student-$t$ distribution with $n-1$ degrees of freedom.

Before the interval is calculated, there is a $1-\alpha$ probability that $\theta$ is contained in the **random** interval $(\widehat{\theta} - \mathfrak{q}_{\alpha/2} \; \mathrm{se}(\widehat{\theta}), \widehat{\theta} + \mathfrak{q}_{\alpha/2} \; \mathrm{se}(\widehat{\theta}))$, where $\widehat{\theta}$ denotes the estimator. Once we obtain a sample and calculate the confidence interval, there is no more notion of probability: the true value of the parameter $\theta$ is either in the confidence interval or not. We can interpret confidence interval's as follows: if we were to repeat the experiment multiple times, and calculate a $1-\alpha$ confidence interval each time, then roughly $1-\alpha$ of the calculated confidence intervals would contain the true value of $\theta$ in repeated samples (in the same way, if you flip a coin, there is roughly a 50-50 chance of getting heads or tails, but any outcome will be either). Our confidence is in the *procedure* we use to calculate confidence intervals and not in the actual values we obtain from a sample.



<div class="figure" style="text-align: center">
<img src="02-hypothesis_testing_files/figure-html/intconf-1.png" alt="95\% confidence intervals for the mean of a standard normal population $\mathsf{No}(0,1)$, with 100 random samples. On average, 5\% of these intervals fail to include the true mean value of zero (in red)." width="85%" />
<p class="caption">(\#fig:intconf)95\% confidence intervals for the mean of a standard normal population $\mathsf{No}(0,1)$, with 100 random samples. On average, 5\% of these intervals fail to include the true mean value of zero (in red).</p>
</div>

If we are only interested in the binary decision rule reject/fail to reject $\mathscr{H}_0$, the confidence interval is equivalent to a *p*-value since it leads to the same conclusion. Whereas the $1-\alpha$ confidence interval gives the set of all values for which the test statistic doesn't provide enough evidence to reject  $\mathscr{H}_0$ at level $\alpha$, the *p*-value gives the probability under the null of obtaining a result more extreme than the postulated value and so is more precise for this particular value. If the *p*-value is smaller than $\alpha$, our null value $\theta$ will be outside of the confidence interval and vice-versa.