# Hypothesis testing {#hypothesis-testing}

In most applied domains, empirical evidences drive the advancement of the field and data from well designed experiments contribute to the built up of science. In order to draw conclusions in favour or against a theory, researchers turn (often unwillingly) to statistics to back up their claims. This has led to the prevalence of the use of the null hypothesis statistical testing (NHST) framework. One important aspect of the reproducibility crisis is the misuse of $p$-values in journal articles: falsification of a null hypothesis is not enough to provide substantive findings for a theory.

  
Because introductory statistics course typically present hypothesis tests without giving much thoughts to the underlying construction principles of such procedures, users often have a reductive view of statistics as a catalogue of pre-determined procedures. To make a culinary analogy, users focus on learning recipes rather than trying to understand the basics of cookery. This chapter focuses on understanding of key ideas related to testing.


## Sources of variability

We are typically interested in some characteristic of the population, oftentimes the (conditional) theoretical average of a continuous response variable, denoted $\mu$. This quantity exists, but is unknown to us so the best we can do is estimate it using random samples that are drawn from the population. 

We call numerical summaries of the data **statistics**. Its important to distinguish between procedures/formulas and their numerical values. An **estimator** is a rule or formula used to calculate an estimate of some parameter or quantity of interest based on observed data (like a recipe for cake). Once we have observed data we can actually compute the sample mean, that is, we have an estimate --- an actual value (the cake).  In other words,

- an estimator is the procedure or formula telling us how to transform the sample data into a numerical summary. Its output is random: even if you repeat a recipe, you won't get the same exact output everytime.
- an estimate is the numerical value obtained once we apply the formula to observed data.


For example, the sample mean of a sample of size $n$ is $\overline{Y}=n^{-1}(Y_1 + \cdots + Y_n)$. Because the inputs of the function $\overline{Y}$ are random, the estimator $\overline{Y}$ is also random. To illustrate this point, Figure \@ref(fig:samplevar) shows five simple random samples of size $n=10$ drawn from an hypothetical population with mean $\mu$ and standard deviation $\sigma$, along with their sample mean $\overline{y}$.

<div class="figure" style="text-align: center">
<img src="02-hypothesis_testing_files/figure-html/samplevar-1.png" alt="Five samples of size $n=10$ drawn from a common population with mean $\mu$ (horizontal line). The colored segments show the sample means of each sample." width="85%" />
<p class="caption">(\#fig:samplevar)Five samples of size $n=10$ drawn from a common population with mean $\mu$ (horizontal line). The colored segments show the sample means of each sample.</p>
</div>

We can clearly see from Figure \@ref(fig:samplevar) that, even with a common value of $\mu$ for all models, the sample mean varies from one sample to the next as a result of the sampling variability. The astute eye will notice that the sample means are less dispersed around $\mu$ than the individual measurements. This is because the sample mean $\overline{Y}$ is based on many observations, so there is more information available.

Values of the sample mean don't tell the whole picture: we must also consider their variability. The sample variance $S_n$ is an estimator of the standard deviation $\sigma$, where \begin{align*}
S^2_n &= \frac{1}{n-1} \sum_{i=1}^n (X_i-\overline{X})^2.
\end{align*}
The square root of the variance of a statistic is termed **standard error**; it should not be confused with the standard deviation $\sigma$ of the population from which the sample observations $Y_1, \ldots$ are drawn. Both standard deviation and standard error are expressed in the same units as the measurements, so are easier to interpret than variance. Since the standard error is a function of the sample size, it is however good practice to report the estimated standard deviation in reports.

We have seen so far that 
In the next section, we outline how hypothesis testing helps us disentangle the signal from the noise.

## Hypothesis testing {#tests}

An hypothesis test is a binary decision rule used to evaluate the statistical evidence provided by a sample to make a decision regarding the underlying population. The main steps involved are:

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


In statistical tests we have two hypotheses: the null hypothesis ($\mathscr{H}_0$) and the alternative hypothesis ($\mathscr{H}_1$). Usually, the null hypothesis is a single numerical value (the 'status quo') and the alternative is what we're really interested in testing. A statistical hypothesis test allows us to decide whether or not our data provides enough evidence to reject $\mathscr{H}_0$ in favour of $\mathscr{H}_1$, subject to some pre-specified risk of error. Usually, hypothesis tests involve a parameter, say $\theta$, which characterizes the underlying distribution at the population level ans whose value is unknown. A two-sided hypothesis test regarding a parameter $\theta$ has the form
\begin{align*}
\mathscr{H}_0: \theta=\theta_0 \qquad \text{versus} \qquad \mathscr{H}_a:\theta \neq \theta_0.
\end{align*}
We are testing whether or not $\theta$ is precisely equal to the value $\theta_0$. 



### Test statistic

A test statistic $T$ is a function of the data that summarize the information contained in the sample for $\theta$. The form of the test statistic is chosen such that we know its underlying distribution under $\mathscr{H}_0$, that is, the potential values taken by $T$ and their relative probability if $\mathscr{H}_0$ is true. This allows us to determine what values of $T$ are likely if $\mathscr{H}_0$ is true. Many statistics we will consider are of the form^[This class of statistic, which includes $t$-tests, are Wald statistics.]
\begin{align*}
T = \frac{\widehat{\theta} - \theta_0}{\mathrm{se}(\widehat{\theta})}
\end{align*}
where $\widehat{\theta}$ is an estimator of $\theta$, $\theta_0$ is the postulated value of the parameter and  $\mathrm{se}(\widehat{\theta})$ is an estimator of the standard deviation of the test statistic $\widehat{\theta}$. For example, if we are interested in mean differences between treatment group and control group, denoted $\mu_1$ and $\mu_0$, then $\theta = \mu_0-\mu_1$ and  $\mathscr{H}_0: \mu_0 = \mu_1$ corresponds to $\mathscr{H}_0: \theta = 0$ for no difference. 

For example, to test whether the mean of a population is zero, we set
\begin{align*}
\mathscr{H}_0: \mu=0, \qquad  \mathscr{H}_a:\mu \neq 0,
\end{align*}
and the Wald statistic is
\begin{align*}
T &= \frac{\overline{X}-0}{S_n/\sqrt{n}}
\end{align*}
where $\overline{X}$ is the sample mean of $X_1, \ldots, X_n$.
The denominator is the standard error of the sample mean, $\mathsf{se}(\overline{Y}) = \sigma/\sqrt{n}$. Note that the precision of the sample mean increases proportionally to the square root of the sample size: the standard error gets halved if we double the number of observations, but only decreases by a factor 10 if we have 100 times more observations. Similar calculations hold for the two-sample $t$-test, whereby $\widehat{\theta} = \overline{Y}_1 - \overline{Y}_0$ for treatment group $T_1$ and control $T_0$. Assuming equal variance, the denominator is estimated using the pooled variance, whereas we recover the Welch test if we estimate the variance separately for each treatment.

### Null distribution and _p_-value

The _p_-value allows us to decide whether the observed value of the test statistic $T$ is plausible under $\mathscr{H}_0$. Specifically, the _p_-value is the probability that the test statistic is equal or more extreme to the estimate computed from the data, assuming $\mathscr{H}_0$ is true. Suppose that based on a random sample $X_1, \ldots, X_n$ we obtain a statistic whose value $T=t$. For a two-sided test $\mathscr{H}_0:\theta=\theta_0$ vs. $\mathscr{H}_a:\theta \neq \theta_0$, the _p_-value is $\mathsf{Pr}_0(|T| \geq |t|)$. If the distribution of $T$ is symmetric around zero, the _p_-value is
\begin{align*}
p = 2 \times \mathsf{Pr}_0(T \geq |t|).
\end{align*}

How do we determine the null distribution given that the true data generating mechanism is unknown to us? In simple cases, it might be possible to enumerate all possible outcomes and thus quantity the degree of outlyingness of our observed statistic. In more general settings, we can resort to simulations or to probability theory: the central limit theorem says that the tell us that the sample mean behaves like a normal random variable with mean $\mu$ and standard deviation $\sigma/\sqrt{n}$ for $n$ large enough. The central limit theorem has broader applications since it applies to any average, and we it can be use toderive benchmarks for most commonly used statistics in large samples. Most software use these approximations as proxy by default: the normal, Student's $t$, $\chi^2$ and $F$ distributions are the reference distributions that arise the most often. 



Consider the example of a two-sided test involving the population mean $\mathscr{H}_0:\mu=0$ against the alternative $\mathscr{H}_1:\mu \neq 0$. Assuming the random sample comes from a normal (population) $\mathsf{No}(\mu, \sigma^2)$, it can be shown that if $\mathscr{H}_0$ is true (that is, if $\mu=0$), the test statistic
\begin{align*}
T = \frac{\overline{X}}{S/\sqrt{n}}
\end{align*}
follows a Student-*t* distribution with $n-1$ degrees of freedom, denoted $\mathsf{St}_{n-1}$. This allows us to calculate the *p*-value (either from a table, or using some statistical software). The Student-*t* distribution is symmetric about zero, so the _p_-value is $P = 2\times\mathsf{Pr}(T_{n-1} > |t|)$, where $T \sim \mathsf{St}_{n-1}$.

### Conclusion


The *p*-value allows us to make a decision about the null hypothesis. If $\mathscr{H}_0$ is true, the *p*-value follows a uniform distribution. [Thus, if the *p*-value is small](https://xkcd.com/1478/), this means observing an outcome more extreme than $T=t$ is unlikely, and so we're inclined to think that $\mathscr{H}_0$ is not true. There's always some underlying risk that we're making a mistake when we make a decision. In statistic, there are [two type of errors](https://xkcd.com/2303/):


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

We consider data from @Rosen:1974, who look at sex role stereotypes and their impacts on promotion and opportunities for women candidates. The experiment took place in 1972 and the experimental units, which consisted of 95 male bank supervisors, were submitted to various memorandums and asked to provide ratings or decisions based on the information provided. Managers were presented different profiles which differed only in the sex of the individual.

We are interested in Experiment 1 related to promotion of employees: managers were requested to decide on whether or not to promote an employee to become branch manager based on recommendations, rating on potential for customer and employee relations. 

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

```

The null hypothesis of interest here that sex has no impact, so the probability of promotion is the same for men and women. Let $p_{\text{m}}$ and $p_{\text{w}}$ denote these respective probabilities; we can thus write mathematically the null hypothesis $\mathscr{H}_0: p_{\text{m}} = p_{\text{w}}$ against the alternative $\mathscr{H}_0: p_{\text{m}} \neq p_{\text{w}}$.

The test statistic typically employed for two by two contingency tables is a chi-square test, which compares the overall proportions of promoted to that in for each subgroup. The sample proportion for male is 32/50 = 64\%, compared to 19/49 or ~49\% for female --- note that these are sample averages if we set `promote=1` and `hold file=0`. While it seems that this difference of 16\% is large, it could be spurious: the standard error for the sample proportions is roughly 3.2\% for male and 3.4\% for female.



The subjects were asked to provide ratings on a six-point Likert scale, with (1) denoted extremely unfavorable and (6) extremely favorable.



The article concluded that

> Results confirmed the hypothesis that male administrators tend to discriminate against female employees in personnel decisions involving promotion, development, and supervision.

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
(Figure \@ref(fig:power3));
- variability: the less noisy your data, the easier it is to detect differences between the curves (big differences are easier to spot, as Figure \@ref(fig:power2) shows);
- the sample size: the more observation, the higher our ability to detect significative differences because the standard error decreases with sample size $n$ at a rate (typically) of $n^{-1/2}$. The null distribution also becomes more concentrated as the sample size increase. In experimental designs, power may be maximized by specifying different sample size in each group
- the choice of test statistic: for example, rank-based statistics discard information about the observed values of the response, focusing instead on their relative ranking. While the resulting tests are typically less powerful, they are more robust to model misspecification and outliers. 

To calculate the power of a test, we need to single out a specific alternative hypothesis. In very special case, analytic derivations are possible: for example, the one-sample *t*-test statistic $T=\sqrt{n}(\overline{X}_n-\mu_0)/S_n \sim \mathcal{T}_{n-1}$ for a normal sample follows a noncentral Student-$t$ distribution with noncentrality parameter $\Delta$ if the expectation of the population is $\Delta + \mu_0$. In general, such closed-form expressions are not easily obtained and we compute instead the power of a test through Monte Carlo methods. For a given alternative, we simulate repeatedly samples from the model, compute the test statistic for each of these new samples and the associated *p*-values based on the postulated null hypothesis. We can then calculate the proportion of tests that lead to a rejection of the null hypothesis at level $\alpha$, namely the percentage of *p*-values smaller than $\alpha$.



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

If we are only interested in the binary decision rule reject/fail to reject $\mathscr{H}_0$, the confidence interval is equivalent to a *p*-value since it leads to the same conclusion. Whereas the $1-\alpha$ confidence interval gives the set of all values for which the test statistic doesn't provide enough evidence to reject  $\mathscr{H}_0$ at level $\alpha$, the *p*-value gives the probability under the null of obtaning a result more extreme than the postulated value and so is more precise for this particular value. If the *p*-value is smaller than $\alpha$, our null value $\theta$ will be outside of the confidence interval and vice-versa.





In this example, we consider the difference between the average amount spent by Y members and those of previous generations: the mean difference in the samples is -16.49 dollars and thus millenials spend more. However, this in itself is not enough to conclude that the different is significative, nor can we say it is meaningful. The amount spent online varies from one individual to the next (and plausibly from month to month), and so different random samples would yield different mean differences.

The first step of our analysis is defining the parameters corresponding to quantities of interest and formulating the null and alternative hypothesis as a function of these parameters. We will consider a test for the difference in mean of the two populations, say $\mu_1$ for the expected amount spent by generation Y and $\mu_2$ for older generations, with respective standard errors $\sigma_1$ and $\sigma_2$. We next write down our hypothesis: the researcher is interested in whether millenials spend more, so this is the alternative hypothesis, $\mathscr{H}_a: \mu_1 > \mu_2$. The null consists of all other values $\mathscr{H}_0: \mu_1 \leq \mu_2$, but only $\mu_1=\mu_2$ matters for the purpose of testing (why?)

The second step is the choice of test statistic. We consider the @Welch:1947 statistic for a difference in mean between two samples,
\begin{align*}
T = \frac{\overline{X}_1 - \overline{X}_2}{\left(\frac{S_1^2}{n_1}+\frac{S_2^2}{n_2} \right)^{1/2}}, \end{align*}
where $\overline{X}_i$ is the sample mean, $S_i^2$ is the unbiased variance estimator and $n_i$ is the sample size for group $i$ ($i=1, 2$). If the mean difference between the two samples is zero, then $\overline{X}_1-\overline{X}_2$ has mean zero and the difference has variance $\sigma^2_1/n_1+\sigma^2_2/n_2$. For our sample, the value of statistic is $T=-2.76$ Since the value changes from one sample to the next, we need to determine if this value is compatible with the null hypothesis by comparing it to the null distribution of $T$ (when $\mathscr{H}_0$ is true and $\mu_1-\mu_2=0$). We perform the test at level $\alpha=0.05$.

The third step consists in obtaining a benchmark to determine if our result is extreme or unusual. To make comparisons easier, we standardize the statistic so its has mean zero and variance one under the null hypothesis $\mu_1=\mu_2$, so as to obtain a dimensionless measure whose behaviour we know for large sample. The (mathematical) derivation of the null distribution is beyond the scope of this course, and will be given in all cases. Asymptotically, $T$ follows a standard normal distribution $\mathsf{No}(0, 1)$, but there exists a better finite-sample approximation when $n_1$ or $n_2$ is small; we use @Satterthwaite:1946 and a Student-$t$ distribution as null distribution.

It only remains to compute the *p*-value. If the null distribution is well-specified and $\mathscr{H}_0$ is true, then the random variable $P$ is uniform on $[0, 1]$; we thus expect to obtain under the null something larger than 0.95 only 5\% of the time for our one-sided alternative since we consider under $\mathscr{H}_0$ the event $\mathsf{Pr}(T > t)$. The $p$-value is $1$ and, at level 5\%, we reject the null hypothesis to conclude that millenials spend significantly than previous generation for monthly online purchases, with an estimated average difference of -16.49.

