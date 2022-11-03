# Repeated measures and multivariate models

So far, all experiments we have considered can be classified as between-subject designs, meaning that each experimental unit was assigned to a single experimental (sub)-condition. In many instances, it may be possible to randomly assign multiple conditions to each experimental unit. For example, an individual coming to a lab to perform tasks in a virtual reality environment may be assigned to all treatments, the latter being presented in random order to avoid confounding. There is an obvious benefit to doing so, as the participants can act as their own control group, leading to greater comparability among treatment conditions. 


For example, consider a study performed at Tech3Lab that looks at the reaction time for people texting or talking on a cellphone while walking. We may wish to determine whether disengagement is slower for people texting, yet we may also postulate that some elderly people have slower reflexes.


In a between-subjects design, subjects are **nested** within experimental condition, as a subject can only be assigned a single treatment. In a within-subjects designs, experimental factors and subjects are **crossed**: it is possible to observed all combination of subject and experimental conditions.


By including multiple conditions, we can filter out effect due to subject, much like with blocking: this leads to increased precision of effect sizes and increased power (as we will see, hypothesis tests are based on within-subject variability). Together, this translates into the need to gather fewer observations or participants to detect a given effect in the population and thus experiments are cheaper to run.

There are of course drawbacks to gathering repeated measures from individuals. Because subjects are confronted with multiple tasks, there may be carryover effects (when one task influences the response of the subsequent ones, for example becoming more fluent as manipulations go on), period effects (practice of fatigue, e.g., leading to a decrease in acuity), permanent changes in the subject condition after a treatment or attrition (loss of subjects over time).

To minimize potential biases, there are multiple strategies one can use. While can randomize the order of treatment conditions among subjects to reduce confounding, or use a balanced crossover design and include the period and carryover effect in the statistical model via control variables so as to better isolate the treatment effect. The experimenter should also allow enough time between treatment conditions to reduce or eliminate period or carryover effects and plan tasks accordingly.

There are multiple approaches to handling repeated measures. The first option is to take averages over experimental condition per subject and treat them as additional blocking factors, but it may be necessary to adjust the resulting statistics. The second approach consists in fitting a multivariate model for the response and explicitly account for the correlation. Multivariate analysis of variance (MANOVA) leads to procedures that are analogous to univariate analysis of variance, but we now need to estimate correlation and variance parameters for each measurement separately and there are multiple potential statistics that can be defined for testing effects. While we can benefit from the correlation and find differences that wouldn't be detected from univariate models, the additional parameters to estimate lead to a loss of power. Finally, the most popular method nowadays for handling repeated measures is to fit a mixed model, with random effects accounting to subject-specific characteristics. By doing so, we assume that the levels of a factor (here the subject identifiers) form a random sample from a large population. These models can be difficult to fit and one needs to take great care in specifying the model. 



### Data format {-}

With repeated measures, it is sometimes convenient to store measurements associated to each experimental condition in different columns of a data frame or spreadsheet, with lines containing participants identifiers. Such data are said to be in **wide format**, since there are multiple measurements in each row. While this format is suitable for multivariate models, many statistical routines will instead expect data to be in **long format**, for which there is a single measurement per line. Figure \@ref(fig:fig-longvswide) illustrates the difference between the two formats.


<div class="figure" style="text-align: center">
<img src="figures/original-dfs-tidy.png" alt="Long versus wide-format for data tables (illustration by Garrick Aden-Buie)." width="85%" />
<p class="caption">(\#fig:fig-longvswide)Long versus wide-format for data tables (illustration by Garrick Aden-Buie).</p>
</div>

Ideally, a data base in long format with repeated measures would also include a column giving the order in which the treatments were assigned to participants. This is necessary in order to test whether there are fatigue or crossover effects, for example by plotting the residuals after accounting for treatment subject by subject, ordered over time. We could also perform formal tests by including time trends in the model and checking whether the slope is significant. 


Overall, the biggest difference with within-subject designs is that observations are correlated whereas we assumed measurements were independent until now. This needs to be explicitly accounted for, as correlation has an important impact on testing as discussed Subsection \@ref(independence): failing to account for correlation leads to $p$-values that are much too low. To see why, think about a stupid setting under which we duplicate every observation in the database: the estimated marginal means will be the same, but the variance will be halved despite the fact there is no additional information. Intuitively, correlation reduces the amount of information provided by each individual: if we have repeated measures from participants, we expect the effective sample size to be anywhere between the total number of subjects and the total number of observations.

## Repeated measures

We introduce the concept of repeated measure and within-subject ANOVA with an example.

:::{ .example name="Happy fakes"}
We consider an experiment conducted in a graduate course at HEC, *Information Technologies and Neuroscience*, in which PhD students gathered electroencephalography (EEG) data. The project focused on human perception of deepfake image created by a generative adversarial network: Amirabdolahian and Ali-Adeeb (2021) expected the attitude towards real and computer generated image of people smiling to change.

The response variable is the amplitude of a brain signal measured at 170 ms after the participant has been exposed to different faces. Repeated measures were collected on 9 participants given in the database `AA21`, who were expected to look at 120 faces. Not all participants completed the full trial, as can be checked by looking at the cross-tabs of the counts


```
#>         id
#> stimulus  1  2  3  4  5  6  7  8  9 10 11 12
#>     real 30 32 34 32 38 29 36 36 40 30 39 33
#>     GAN1 32 31 40 33 38 29 39 31 39 28 35 34
#>     GAN2 31 33 37 34 38 29 34 36 40 33 35 32
```

The experimental manipulation is encoded in the `stimuli`, with levels control (`real`) for real facial images, whereas the others were generated using a generative adversarial network (GAN) with be slightly smiling (`GAN1`) or extremely smiling (`GAN2`); the latter looks more fake. While the presentation order was randomized, the order of presentation of the faces within each type is recorded using the `epoch` variable: this allows us to measure the fatigue effect.

Since our research question is whether images generated from generative adversarial networks trigger different reactions, we will be looking at pairwise differences with the control.

<div class="figure" style="text-align: center">
<img src="figures/face_real.png" alt="Example of faces presented in Amirabdolahian and Ali-Adeeb (2021): real, slightly modified and extremely modified (from left to right)." width="25%" /><img src="figures/face_GAN_S.png" alt="Example of faces presented in Amirabdolahian and Ali-Adeeb (2021): real, slightly modified and extremely modified (from left to right)." width="25%" /><img src="figures/face_GAN_E.jpg" alt="Example of faces presented in Amirabdolahian and Ali-Adeeb (2021): real, slightly modified and extremely modified (from left to right)." width="25%" />
<p class="caption">(\#fig:fig-GANfaces)Example of faces presented in Amirabdolahian and Ali-Adeeb (2021): real, slightly modified and extremely modified (from left to right).</p>
</div>

We could begin by grouping the data and computing the average for each experimental condition `stimulus` per participant and set `id` as blocking factor. The analysis of variance table obtained from `aov` would be correct, but fails to account for correlation. 

The one-way analysis of variance with $n_s$ subjects, each of which was exposed to the $n_a$ experimental conditions, can be written 
$$\begin{align*}\underset{\text{response}\vphantom{l}}{Y_{ij}} = \underset{\text{global mean}}{\mu_{\vphantom{j}}} + \underset{\text{mean difference}}{\alpha_j} + \underset{\text{subject difference}}{s_{i\vphantom{j}}} + \underset{\text{error}\vphantom{l}}{\varepsilon_{ij}}\end{align*}$$


```r
# Compute mean for each subject + 
# experimental condition subgroup
AA21_m <- AA21 |>
  dplyr::group_by(id, stimulus) |>
  dplyr::summarize(latency = mean(latency))
# Use aov for balanced sample
fixedmod <- aov(
  latency ~ stimulus + Error(id/stimulus), 
  data = AA21_m)
# Print ANOVA table
summary(fixedmod)
#> 
#> Error: id
#>           Df Sum Sq Mean Sq F value Pr(>F)
#> Residuals 11    188    17.1               
#> 
#> Error: id:stimulus
#>           Df Sum Sq Mean Sq F value Pr(>F)
#> stimulus   2    1.9    0.97     0.5   0.62
#> Residuals 22   43.0    1.96
```

Since the design is balanced after averaging, we can use `aov` in **R**: we need to specify the subject identifier within `Error` term. This approach has a drawback, as variance components can be negative if the variability due to subject is negligible. While `aov` is fast, it only works for simple balanced designs. 


:::

## Contrasts 

With balanced data, the estimated marginal means coincide with the row averages. If we have a single replication or the average for each subject/condition, we could create a new column with the contrast and then fit a model with an intercept-only (global mean) to check whether the latter is zero. With 12 participants, we should thus expect our test statistic to have 11 degrees of freedom, since one unit is spent on estimating the mean parameter and we have 12 participants.

Unfortunately, the `emmeans` package analysis for object fitted using `aov` will be incorrect: this can be seen by passing a contrast vector and inspecting the degrees of freedom. The `afex` package includes functionalities that are tailored for within-subject and between-subjects and has an interface with `emmeans`.








The `afex` package has different functions for computing the within-subjects design and the `aov_ez` specification, which allow people to list within and between-subjects factor separately with subject identifiers may be easier to understand. It also has an argument, `fun_aggregate`, to automatically average replications.


```
#> $emmeans
#>  stimulus emmean    SE df lower.CL upper.CL
#>  real      -10.8 0.942 11    -12.8    -8.70
#>  GAN1      -10.8 0.651 11    -12.3    -9.40
#>  GAN2      -10.3 0.662 11    -11.8    -8.85
#> 
#> Confidence level used: 0.95 
#> 
#> $contrasts
#>  contrast    estimate    SE df t.ratio p.value
#>  real vs GAN   -0.202 0.552 11  -0.366  0.7210
#> $emmeans
#>  stimulus emmean    SE   df lower.CL upper.CL
#>  real      -10.8 0.763 16.2    -12.4    -9.15
#>  GAN1      -10.8 0.763 16.2    -12.4    -9.21
#>  GAN2      -10.3 0.763 16.2    -11.9    -8.69
#> 
#> Warning: EMMs are biased unless design is perfectly balanced 
#> Confidence level used: 0.95 
#> 
#> $contrasts
#>  contrast    estimate    SE df t.ratio p.value
#>  real vs GAN   -0.202 0.494 22  -0.409  0.6870
```

## Model assumptions

The validity of the $F$ statistic null distribution relies on the model having the correct structure.

In repeated-measure analysis of variance, we assume again that each variance has the same variance. We equally require the correlation between measurements of the same subject to be the same, an assumption that corresponds to the so-called compound symmetry model.^[Note that, with two measurements, there is a single correlation parameter to estimate and this assumption is irrelevant.]

What if the measurements have unequal variance or different correlations? We could fit a fully multivariate model that accounts for the 
While this is automatic with two measurements (as there is a single correlation), we can check this by comparing the fit of a model with an unstructured covariance (difference variances for each  and correlations for each pair of variable)

Since we care only about differences in treatment, can get away with a weaker assumption than compound symmetry (equicorrelation) by relying instead on *sphericity*, which holds if the variance of the difference between treatment is constant.

The most popular approach to handling correlation in tests is a two-stage approach: first, check for sphericity (using, e.g., Mauchly's test of sphericity). If the null hypothesis of sphericity is rejected, one can use a correction for the $F$ statistic by modifying the parameters of the Fisher $\mathsf{F}$ null distribution used as benchmark.


An idea due to Box is to correct the degrees of freedom of the $\mathsf{F}(\nu_1, \nu_2)$ distribution by multiplying them by a common factor $\epsilon<1$ and use $\mathsf{F}(\epsilon\nu_1, \epsilon\nu_2)$. Since the $F$ statistic is a ratio of variances, the $\epsilon$ term would cancel. Using the scaled $\mathsf{F}$ distribution leads to larger $p$-values, thus accounting for the correlation.

There are three widely used corrections: Greenhouse--Geisser, Huynh--Feldt and Box correction, which divides by $\nu_1$ both degrees of freedom and gives a very conservative option. The Huynh--Feldt method is reported to be more powerful so should be preferred, but the estimated value of $\epsilon$ can be larger than 1.

Using the `afex` functions, we get the result for Mauchly's test of sphericity and the $p$ values from using either correction method


```
#> 
#> Univariate Type III Repeated-Measures ANOVA Assuming Sphericity
#> 
#>             Sum Sq num Df Error SS den Df F value  Pr(>F)    
#> (Intercept)   4073      1      188     11   238.6 8.4e-09 ***
#> stimulus         2      2       43     22     0.5    0.62    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> 
#> Mauchly Tests for Sphericity
#> 
#>          Test statistic p-value
#> stimulus          0.678   0.143
#> 
#> 
#> Greenhouse-Geisser and Huynh-Feldt Corrections
#>  for Departure from Sphericity
#> 
#>          GG eps Pr(>F[GG])
#> stimulus  0.757       0.57
#> 
#>          HF eps Pr(>F[HF])
#> stimulus  0.851      0.587
```




```
#> Analysis of Variance Table
#> 
#> 
#> Contrasts orthogonal to
#> ~1
#> 
#> Greenhouse-Geisser epsilon: 0.7565
#> Huynh-Feldt epsilon:        0.8515
#> 
#>             Df   F num Df den Df Pr(>F) G-G Pr H-F Pr
#> (Intercept)  1 0.5      2     22  0.615  0.567  0.587
#> Residuals   11
#>  contrast         estimate    SE df t.ratio p.value
#>  c(1, -0.5, -0.5)   -0.202 0.552 11  -0.366  0.7210
```
