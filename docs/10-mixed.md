# Introduction to mixed models

This chapter considers tools for models with repeated measures from a modern perspective, using random effects for modelling. This class of model, called hierarchical models, multilevel models or mixed models in simple scenarios, give us more flexibility to account for complex scenarios in which there may be different sources of variability.

For example, consider a large-scale replication study about teaching methods. We may have multiple labs partaking in a research program and each has unique characteristics. Because of these, we can expect that measurements collected within a lab will be correlated. At the same time, we can have repeated mesures for participants in the study. One can view this setup as a hierarchy, with within-subject factor within subject within lab. In such settings, the old-school approach to analysis of variance becomes difficult, if not impossible; it doesn't easily account for the heterogeneity in the lab sample size and does not let us estimate the variability within labs.

We begin our journey with the same setup as for repeated measures ANOVA by considering one-way within-subject ANOVA model. We assign each participant (subject) in the study to all of the experimental treatments, in random order. If we have one experimental factor $A$ with $n_a$ levels, the model is
\begin{align*}\underset{\text{response}\vphantom{l}}{Y_{ij}} = \underset{\text{global mean}}{\mu_{\vphantom{j}}} + \underset{\text{mean difference}}{\alpha_j} + \underset{\text{random effect for subject}}{S_{i\vphantom{j}}} + \underset{\text{error}\vphantom{l}}{\varepsilon_{ij}}.
\end{align*}
In a random effect model, we assume that the subject effect $S_i$ is a random variable; we take $S_i \sim \mathsf{No}(0, \sigma^2_s)$ and the latter is assumed to be independent of the noise $\varepsilon_{ij} \sim \mathsf{No}(0, \sigma^2_e)$. The model parameters that we need to estimate are the global mean $\mu$, the mean differences $\alpha_1, \ldots, \alpha_{n_a}$, the subject-specific variability $\sigma^2_s$ and the residual variability $\sigma^2_e$, with the sum-to-zero constraint $\alpha_1 + \cdots + \alpha_{n_a}=0$.

Inclusion of random effects introduces positive correlation between measurements: specifically, the correlation between two observations from the same subject will be $\rho=\sigma^2_s/(\sigma^2_s+\sigma^2_e)$ and zero otherwise. This correlation structure is termed compound symmetry, since the correlation between measurements, $\rho$, is the same regardless of the order of the observations. If there are multiple random effects, the dependence structure will be more complicated.

In the repeated measure models, we need to first reduce measurements to a single average per within-subject factor, then fit the model by including the subject as a blocking factor. We are therefore considering subjects as fixed effects by including them as blocking factors, and estimate the mean effect for each subject: the value of $\sigma^2_s$ is estimated from the mean squared error of the subject term, but this empirical estimate can be negative. By contrast, the mixed model machinery will directly estimate the variance term, which will be constrained to be strictly positive.

## Fixed vs random effects


Mixed models include, by definition, both **random** and **fixed** effects. Fixed effects are model parameters corresponding to overall average or difference in means for the experimental conditions. These are the terms for which we want to perform hypothesis tests and compute contrasts. So far, we have only considered models with fixed effects. 

Random effects, on the other hand, assumes that the treatments are random samples from a population of interest. If we gathered another sample, we would be looking at a new set of treatments. Random effects model the variability arising from the sampling of that population and focuses on variance and correlation parameters. Addition of random effects does not impact the population mean, but induces variability and correlation within subject. There is no consensual definition, but @Gelman:2005 lists a handful:

> When a sample exhausts the population, the corresponding variable is fixed; when the sample is a small (i.e., negligible) part of the population the corresponding variable is random [Green and Tukey (1960)].

> Effects are fixed if they are interesting in themselves or random if there is interest in the underlying population (e.g., Searle, Casella and McCulloch [(1992), Section 1.4])

In terms of estimation, fixed effect terms are mean parameters, while all random effects will be obtained from variance and correlation parameters. In the repeated measure approach with fixed effects and blocking, we would estimate the average for each subject despite the fact that this quantity is of no interest. Estimating a mean with only a handful of measurements is a risky business and the estimated effects are sensitive to outliers. 

Random effects would proceed to directly estimate the variability arising from different subjects. We can still get predictions for the subject-specific effect, but this prediction will be shrunk toward the global mean for that particular treatment category. As we gather more data about the subjects, the predictions will become closer to the fixed effect estimates when the number of observations per subject or group increases, but these prediction can deviate from mean estimates in the case where there are few measurements per subject.


@Oehlert:2010 identifies the following step to perform a mixed model

1. Identify sources of variation
2. Identify whether factors are crossed are nested
3. Determine whether factors should be fixed or random
4. Figure out which interactions can exist and whether they can be fitted.

To fit the model, identifiers of subjects must be declared as factors (categorical variables).

We say to factors are nested ($A$ within $B$) when one can only coexist within the levels of the other: this has implications, for we cannot have interaction between the two. In between-subject experiments, factors are crossed, meaning we can assign an experimental unit or a subject to each factor combination and thus interactions can occur.  For example, subjects are nested in between-level factors.

The next step will be in determining whether we have enough observations to support the inclusion of a random term. In a pure within-subject design, we could not include an interaction between subject and the within-factor unless we have multiple replications for each subject, as is the case here. We can therefore include both subject identifier and experimental factor, as well as their interaction. Note that in `lme4` package, the random effects are specified inside parenthesis.

:::{ .example name="Happy fakes, remixed"}

We consider again the experiment of Amirabdolahian and Ali-Adeeb (2021) on smiling fakes and the emotion, this time from a pure mixed model perspective. This means we can simply keep all observations and model them accordingly.

<div class="figure" style="text-align: center">
<img src="10-mixed_files/figure-html/fig-aafulldat-1.png" alt="Jittered scatterplot of individual measurements per participant and stimulus type." width="85%" />
<p class="caption">(\#fig:fig-aafulldat)Jittered scatterplot of individual measurements per participant and stimulus type.</p>
</div>

Figure \@ref(fig:fig-aafulldat) shows the raw measurements, including what are notable outliers that may be due to data acquisition problems or instrumental manipulations. Since the experiment was performed in a non-controlled setting (pandemic) with different apparatus and everyone acting as their own technician, it is unsurprising that the signal-to-noise ratio is quite small. We will exclude here (rather arbitrarily) measurements below a latency of minus 40.


```r
library(lmerTest) 
# fit and tests for mixed models
options(contrasts = c("contr.sum", "contr.poly"))
mixedmod <- lmer(
  latency ~ stimulus + 
    (1 | id) + # random effect for subject
    (1 | id:stimulus), 
  # random effect for interaction 
  data = hecedsm::AA21 |> #remove outliers
    dplyr::filter(latency > -40))
# Output parameter estimates
print(mixedmod)
#> Linear mixed model fit by REML ['lmerModLmerTest']
#> Formula: latency ~ stimulus + (1 | id) + (1 | id:stimulus)
#>    Data: dplyr::filter(hecedsm::AA21, latency > -40)
#> REML criterion at convergence: 8008
#> Random effects:
#>  Groups      Name        Std.Dev.
#>  id:stimulus (Intercept) 0.737   
#>  id          (Intercept) 2.268   
#>  Residual                6.223   
#> Number of obs: 1227, groups:  id:stimulus, 36; id, 12
#> Fixed Effects:
#> (Intercept)    stimulus1    stimulus2  
#>     -10.537       -0.253       -0.139
```

We see that there is quite a bit of heterogeneity between participants and per stimulus participant pair, albeit less so for the interaction. All estimated variance terms are rather large.

We can also look globally at the statistical evidence for the 


```
#> Type III Analysis of Variance Table with Satterthwaite's method
#>          Sum Sq Mean Sq NumDF DenDF F value Pr(>F)
#> stimulus   65.6    32.8     2  23.3    0.85   0.44
```

The global $F$ test of significance for stimulus is based on an approximation; the denominator degrees of freedom for the approximate $F$ statistic are based on Satterthwaite's method, which provides a correction. There is again no evidence of differences between experimental conditions. This is rather unsurprising if we look at the raw data in Figure \@ref(fig:fig-aafulldat).

:::

:::{ .example name="Verbalization and memorization"}
We consider a replication study of @Elliot:2021,
which studied verbalization and verbalization of kids aged 5, 6, 7 and 10. The replication was performed in 17 different school labs, adapting a protocol of @Flavell:1966, with an overall sample of 977 child partaking in the experiment.

Each participant was assigned to three tasks (`timing`): `delayed` recall with 15 seconds wait, or `immediate`, and finally  a naming task (`point-and-name`). The `taskorder` variable records the order in which these were presented: the order of `delayed` and `immediate` was counterbalanced across individuals, with the naming task always occurring last. The response variable is the number of words correctly recalled out of five. The experimenters also recorded the frequency at which students spontaneously verbalized during the task (except the naming task, where they were instructed to do so).

The timing is a within-subject factor, whereas task order and age are between-subject factors: we are particularly interested in the speech frequency and the improvement over time (pairwise differences and trend).

To fit the linear mixed model with a random effect for both children `id` and `lab`: since children are nested in lab, we must specify the random effects via `(1 | id:lab) + (1 | lab)` if `id` are not unique.

We modify the data to keep only 5 and 6 years old students, since most older kids verbalized during the task and we would have large disbalance (14 ten years old out of 235, and 19 out of 269 seven years old). We also exclude the point-and-name task, since verbalization was part of the instruction. This leaves us with $1419$ observations and we can check that there are indeed enough children in each condition to get estimates.


```r
data(MULTI21_D2, package = "hecedsm")
MULTI21_D2_sub <- MULTI21_D2 |>
  dplyr::filter(
    age %in% c("5yo", "6yo"),
    timing != "point-and-name") |>
  dplyr::mutate(
    verbalization = factor(frequency != "never",
                           labels = c("no", "yes")),
    age = factor(age)) # drop unused age levels
xtabs(~ age + verbalization, data = MULTI21_D2_sub)
#>      verbalization
#> age    no yes
#>   5yo 106 334
#>   6yo  56 450
```

Given that we have multiple students of every age group, we can include two-way and three-way interactions in the $2^3$ design. We also include random effects for the student and the lab.


```r
library(lmerTest)
library(emmeans)
hmod <- lmer(
  mcorrect ~ age*timing*verbalization + (1 | id:lab) + (1 | lab), 
  data = MULTI21_D2_sub)
# Parameter estimates
#summary(hmod)
```

We focus here on selected part of the output from `summary()` giving the estimated variance terms.


```r
#> Random effects:
#>  Groups   Name        Variance Std.Dev.
#>  id:lab   (Intercept) 0.3587   0.599   
#>  lab      (Intercept) 0.0625   0.250   
#>  Residual             0.6823   0.826   
#> Number of obs: 946, groups:  id:lab, 473; lab, 17
```


We can interpret the results as follows: the total variance is the sum of the  `id`, `lab` and `residual` variances components give us an all but negligible effect of lab with 7 percent of the total variance, versus 40.5 percent for the children-specific variability. Since there are only 17 labs, and most of the individual specific variability is at the children level, the random effect for lab doesn't add much to the correlation.


```r
anova(hmod, ddf = "Kenward-Roger")
#> Type III Analysis of Variance Table with Kenward-Roger's method
#>                          Sum Sq Mean Sq NumDF DenDF F value Pr(>F)    
#> age                       20.50   20.50     1   459   30.05  7e-08 ***
#> timing                     3.25    3.25     1   469    4.76   0.03 *  
#> verbalization             13.61   13.61     1   459   19.94  1e-05 ***
#> age:timing                 0.24    0.24     1   469    0.36   0.55    
#> age:verbalization          0.08    0.08     1   462    0.12   0.72    
#> timing:verbalization       2.64    2.64     1   469    3.88   0.05 *  
#> age:timing:verbalization   0.27    0.27     1   469    0.40   0.53    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# Check estimated marginal means for age
emm <- emmeans(hmod, specs = "age")
emm
#>  age emmean     SE   df lower.CL upper.CL
#>  5yo   1.85 0.0914 35.8     1.67     2.04
#>  6yo   2.44 0.1053 60.9     2.23     2.65
#> 
#> Results are averaged over the levels of: timing, verbalization 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95
# Pairwise differences
pairdiff <- emm |> pairs()
pairdiff
#>  contrast  estimate    SE  df t.ratio p.value
#>  5yo - 6yo    -0.59 0.108 459  -5.480  <.0001
#> 
#> Results are averaged over the levels of: timing, verbalization 
#> Degrees-of-freedom method: kenward-roger
```


The type III ANOVA table shows that there is no evidence of interaction between task order, age and verbalization (no three-interaction) and a very small difference for timing and verbalization. Thus, we could compute the estimated marginal means for age with an estimated correct number of words of 1.854 (95% confidence interval of [1.669, 2.04]) words out of 5 for the 5 years olds and 2.445 (95% CI [2.234, 2.655]) words for six years old. Note that, despite the very large number children in the experiment, the degrees of freedom from the Kenward--Roger method are much fewer, respectively 35.827 and 60.944 for five and six years old.

The $t$-test for the pairwise difference of the marginal effect is 0.59 words with standard error 0.108. Judging from the output, the degrees of freedom calculation for the pairwise $t$-test are erroneous --- they seem to be some average between the number of entries for the five years old (440) and six years old (506), but this fails to account for the fact that each kid is featured twice. Given the large magnitude of the ratio, this still amounts to strong result provided the standard error is correct.

We can easily see the limited interaction and strong main effects from the interaction plot in Figure \@ref(fig:fig-interactionrecall). The confidence intervals are of different width because of the sample inbalance.

<div class="figure" style="text-align: center">
<img src="10-mixed_files/figure-html/fig-interactionrecall-1.png" alt="Interaction plot for the recall task for younger children." width="85%" />
<p class="caption">(\#fig:fig-interactionrecall)Interaction plot for the recall task for younger children.</p>
</div>

:::
