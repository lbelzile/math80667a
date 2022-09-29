# Contrasts and multiple testing {#contrasts-multiple-testing}

The analysis of variance model tests the (global) null hypothesis that the average of all groups is equal. In an experimental context, this implies one or more of the manipulation has a different effect from the others on the mean response. Oftentimes, this isn't interesting in itself: we could be interested in comparing different options relative to a *status quo*, or determine whether specific combinations work better than separately. The scientific question of interest that warranted the experiment may lead to a specific set of hypotheses, which can be formulated by researchers as comparisons between means of different subgroups.

## Contrasts

We can normally express these as **contrasts**. As [Dr. Lukas Meier](https://stat.ethz.ch/~meier) puts it, if the global $F$-test for equality of means is equivalent to a dimly lit room, contrasts are akin to spotlight that let one focus on particular aspects of differences in treatments.

More formally speaking, a contrast is a linear combination of averages: in plain English, this means we assign a weight to each group average and add them up. We can then build a $t$ statistic as usual by standardizing the resulting weighted sum of the group means. 


If $c_i$ denotes the weight of group average $\mu_i$ $(i=1, \ldots, K)$, then we can write the contrast as $C = c_1 \mu_1 + \cdots + c_K \mu_K$ with the null hypothesis $\mathscr{H}_0: C=a$ for a two-sided alternative, for $a$ a numeric value like 0. The sample estimate of the linear contrast is obtained by replacing the unknown population average $\mu_i$ by the sample average of that group, $\widehat{\mu}_i = \overline{y}_{i}$. We can easily obtain the standard error of the linear combination $C$.^[Should you need the formula, the standard error assuming sample size of $n_1, \ldots, n_K$ and a common variance $\sigma^2$ is $\sqrt{\mathsf{Va}(\widehat{C})}$, where $$\mathsf{Va}(\widehat{C}) = \widehat{\sigma}^2\left(\frac{c_1^2}{n_1} + \cdots + \frac{c_K^2}{n_K}\right).$$]





Contrasts encode research question of interest, taking the form $\mathscr{H}_0: c_1 \mu_1 + \cdots + c_K\mu_K = a$, where the numerical value $a$ is typically zero. 


### Orthogonal contrasts

Sometimes, linear contrasts encode disjoint bits of information about the sample: for example, one contrast that compares groups the first two groups versus one that compares the third and fourth is in effect using data from two disjoint samples, as contrasts will be based on sample averages. Whenever the contrasts vectors are orthogonal, the tests will be uncorrelated as they contain independent bits of information from the population.^[The constraint $c_1 + \cdots + c_K=0$ ensures that linear contrasts are orthogonal to the mean, which has weight $c_i=n_i/n$ and for balanced samples $c_i =1/n$.] Mathematically, if we let $c_{i}$ and $c^{*}_{i}$ denote weights attached to the mean of group $i$ comprising $n_i$ observations, contrasts are orthogonal if $c_{1}c^{*}_{1}/n_1 + \cdots + c_{K}c^{*}_K/n_K = 0$; if the sample is balanced with the same number of observations in each group, $n/K = n_1 =\cdots = n_K$^[This is the dot product of the two contrast vectors]. If we have $K$ groups, there are $K-1$ contrasts for pairwise differences, the last one being captured by the sample mean for the overall effect.If we care only about difference between groups (as opposed to the overall effect of all treatments), we impose a sum-to-zero constraint on the weights so $c_1 + \cdots + c_K=0$. This ensures^[The sample mean for a balanced sample amounts to equi-weighted average of the groups, i.e., a contrast with weight vector $(1, 1, \ldots, 1)$. Thus, any contrast whose elements sum to zero is orthogonal to the global mean. End of the mathematical digression.] Keep in mind that, although independent tests are nice mathematically, contrasts should encode the hypothesis of interest to the researchers: we choose contrasts because they are meaningful, not because they are orthogonal.



:::{ .example name="Contrasts for encouragement on teaching"}

The `arithmetic` data example considered five different treatment groups with 9 individuals in each. Two of them were control groups, one received praise, another was reproved and the last was ignored.

Suppose that researchers were interested in assessing whether the experimental manipulation had an effect, and whether the impact of positive and negative feedback is the same on students.^[These would be formulated *at registration time*, but for the sake of the argument we proceed as if they were.]

Suppose we have five groups in the order (control 1, control 2, praised, reproved, ignored). 
We can express these hypothesis as

- $\mathscr{H}_{01}$: $\mu_{\text{praise}} = \mu_{\text{reproved}}$
- $\mathscr{H}_{02}$: 
\begin{align*}
\frac{1}{2}(\mu_{\text{control}_1}+\mu_{\text{control}_2}) = \frac{1}{3}\mu_{\text{praised}} + \frac{1}{3}\mu_{\text{reproved}} + \frac{1}{3}\mu_{\text{ignored}}
\end{align*}

Note that, for the hypothesis of control vs experimental manipulation, we look at average of the different groups associated with each item. Using the ordering, the weights of the contrast vector are $(1/2, 1/2, -1/3, -1/3, -1/3)$ and $(0, 0, 1, -1, 0)$. There are many equivalent formulation: we could multiply the weights by any number (different from zero) and we would get the same test statistic, as the latter is standardized.



```r
library(emmeans)
data(arithmetic, package = "hecedsm")
linmod <- aov(score ~ group, data = arithmetic)
linmod_emm <- emmeans(linmod, specs = 'group')
contrast_specif <- list(
  controlvsmanip = c(0.5, 0.5, -1/3, -1/3, -1/3),
  praisedvsreproved = c(0, 0, 1, -1, 0)
)
contrasts_res <- 
  contrast(object = linmod_emm, 
                    method = contrast_specif)
# Obtain confidence intervals instead of p-values
confint(contrasts_res)
```

<table class="table" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> contrast </th>
   <th style="text-align:right;"> estimate </th>
   <th style="text-align:right;"> std. error </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> lower conf. limit </th>
   <th style="text-align:right;"> upper conf. limit </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> control vs manip </td>
   <td style="text-align:right;"> -3.33 </td>
   <td style="text-align:right;"> 1.05 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> -5.45 </td>
   <td style="text-align:right;"> -1.22 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> praised vs reproved </td>
   <td style="text-align:right;"> 4.00 </td>
   <td style="text-align:right;"> 1.62 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 0.72 </td>
   <td style="text-align:right;"> 7.28 </td>
  </tr>
</tbody>
</table>

:::

:::{ .example name="Teaching to read"}


We consider data from @Baumann:1992. The abstract of the paper provides a brief description of the study

> This study investigated the effectiveness of explicit instruction in think aloud as a means to promote elementary students' comprehension monitoring abilities. Sixty-six fourth-grade students were randomly assigned to one of three experimental groups: (a) a Think-Aloud (TA) group, in which students were taught various comprehension monitoring strategies for reading stories (e.g., self-questioning, prediction, retelling, rereading) through the medium of thinking aloud; (b) a Directed reading-Thinking Activity (DRTA) group, in which students were taught a predict-verify strategy for reading and responding to stories; or (c) a Directed reading Activity (DRA) group, an instructed control, in which students engaged in a noninteractive, guided reading of stories. 



```r
library(emmeans) #load package
data(BSJ92, package = "hecedsm")
mod_post <- aov(posttest1 ~ group, data = BSJ92)
emmeans_post <- emmeans(object = mod_post, 
                        specs = "group")
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:print-pairwise-baumann)Estimated group averages with standard errors and 95% confidence intervals for post-test 1.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Terms </th>
   <th style="text-align:right;"> Marginal mean </th>
   <th style="text-align:right;"> Standard error </th>
   <th style="text-align:right;"> Degrees of freedom </th>
   <th style="text-align:right;"> Lower limit (CI) </th>
   <th style="text-align:right;"> Upper limit (CI) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> DR </td>
   <td style="text-align:right;"> 6.68 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 5.32 </td>
   <td style="text-align:right;"> 8.04 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> DRTA </td>
   <td style="text-align:right;"> 9.77 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 8.41 </td>
   <td style="text-align:right;"> 11.13 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TA </td>
   <td style="text-align:right;"> 7.77 </td>
   <td style="text-align:right;"> 0.68 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 6.41 </td>
   <td style="text-align:right;"> 9.13 </td>
  </tr>
</tbody>
</table>

We can see that `DRTA` has the highest average, followed by `TA` and directed reading (`DR`).
The purpose of @Baumann:1992 was to make a particular comparison between treatment groups. 
From the abstract:

> The primary quantitative analyses involved two planned orthogonal contrasts—effect of instruction (TA + DRTA vs. 2 x DRA) and intensity of instruction (TA vs. DRTA)—for three whole-sample dependent measures: (a) an error detection test, (b) a comprehension monitoring questionnaire, and (c) a modified cloze test.

The hypothesis of @Baumann:1992 is $\mathscr{H}_0: \mu_{\mathrm{TA}} + \mu_{\mathrm{DRTA}} = 2 \mu_{\mathrm{DRA}}$ 
or, rewritten slightly,
$$\begin{align*}
\mathscr{H}_0: - 2 \mu_{\mathrm{DR}} + \mu_{\mathrm{DRTA}} + \mu_{\mathrm{TA}} = 0.
\end{align*}$$
with weights $(-2, 1, 1)$; the order of the levels for the treatment are 
($\mathrm{DRA}$, $\mathrm{DRTA}$, $\mathrm{TA}$) and it must match that of the coefficients.
An equivalent formulation is $(2, -1, -1)$ or $(1, -1/2, -1/2)$: in either case, the estimated differences will be different
(up to a constant multiple or a sign change).
The vector of weights for $\mathscr{H}_0:  \mu_{\mathrm{TA}} = \mu_{\mathrm{DRTA}}$ 
is ($0$, $-1$, $1$): the zero appears because the first component, $\mathrm{DRA}$ doesn't appear.
The two contrasts are orthogonal since
$(-2 \times 0) + (1 \times -1) + (1 \times 1) = 0$. 


```r
# Identify the order of the level of the variables
with(BSJ92, levels(group))
#> [1] "DR"   "DRTA" "TA"
# DR, DRTA, TA (alphabetical)
contrasts_list <- list(
  "C1: DRTA+TA vs 2DR" = c(-2, 1, 1), 
  # Contrasts: linear combination of means, coefficients sum to zero
  # 2xDR = DRTA + TA => -2*DR + 1*DRTA + 1*TA = 0 and -2+1+1 = 0
  "C1: average (DRTA+TA) vs DR" = c(-1, 0.5, 0.5), 
  #same thing, but halved so in terms of average
  "C2: DRTA vs TA" = c(0, 1, -1),
  "C2: TA vs DRTA" = c(0, -1, 1) 
  # same, but sign flipped
)
contrasts_post <- 
  contrast(object = emmeans_post,
           method = contrasts_list)
contrasts_summary_post <- summary(contrasts_post)
```
<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:print-contrasts)Estimated contrasts for post-test 1.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Contrast </th>
   <th style="text-align:right;"> Estimate </th>
   <th style="text-align:right;"> Standard error </th>
   <th style="text-align:right;"> Degrees of freedom </th>
   <th style="text-align:right;"> t statistic </th>
   <th style="text-align:right;"> p-value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> C1: DRTA+TA vs 2DR </td>
   <td style="text-align:right;"> 4.18 </td>
   <td style="text-align:right;"> 1.67 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 2.51 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C1: average (DRTA+TA) vs DR </td>
   <td style="text-align:right;"> 2.09 </td>
   <td style="text-align:right;"> 0.83 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 2.51 </td>
   <td style="text-align:right;"> 0.01 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C2: DRTA vs TA </td>
   <td style="text-align:right;"> 2.00 </td>
   <td style="text-align:right;"> 0.96 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 2.08 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> C2: TA vs DRTA </td>
   <td style="text-align:right;"> -2.00 </td>
   <td style="text-align:right;"> 0.96 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> -2.08 </td>
   <td style="text-align:right;"> 0.04 </td>
  </tr>
</tbody>
</table>

We can look at these differences; since `DRTA` versus `TA` is a pairwise difference, we could have obtained the $t$-statistic directly from the pairwise contrasts
using `pairs(emmeans_post)`. Note that the two different ways of writing the comparison between `DR` and the average of the other two methods yield different point estimates, but same inference (meaning the same $p$-values). For contrast $C_{1b}$, we get half the estimate (but the standard error is also halved) and likewise for the second contrasts we get an estimate of $\mu_{\mathrm{DRTA}} - \mu_{\mathrm{TA}}$ in the first case ($C_2$) and $\mu_{\mathrm{TA}} - \mu_{\mathrm{DRTA}}$: the difference in group averages is the same up to sign.

What is the conclusion of our analysis of contrasts? 
It looks like the methods involving teaching aloud have a strong impact on reading comprehension relative to only directed reading. The evidence is not as strong
when we compare the method that combines directed reading-thinking activity and thinking aloud.

:::

## Multiple testing

Beyond looking at the global null, we will be interested in a set of contrast statistics and typically this number can be large-ish. There is however a catch in starting to test multiple hypothesis at once.


If you do a **single** hypothesis test and the testing procedure is well calibrated (meaning that the model model assumptions hold), there is a probability of $\alpha$ of making a type I error if the null is true, meaning when there is no difference between averages in the underlying population. The problem of the above approach is that the more you look, the higher the chance of finding something: with 20 independent tests, we expect that, on average, one of them will yield a $p$-value less than 5\%. This, coupled with the tendency in the many fields to dichotomise the result of every test depending on whether $p \leq \alpha$ (statistically significant at level $\alpha$ or not leads to selective reporting of findings. 

Not all tests are of interest, even if standard software will report all possible pairwise comparisons. However, the number of tests performed in the course of an analysis can be very large. Dr. Yoav Benjamini investigated the number of tests performed in each study of the Psychology replication project [@OSC:2015]: this number ranged from 4 to 700, with an average of 72 per study. It is natural to ask then how many are spurious findings that correspond to type I errors. The paramount (absurd) illustration is the xkcd cartoon of Figure \@ref(fig:xkcdsignificant).


Not all tests are of interest, even if standard software will report all possible pairwise comparisons. If there are $K$ groups to compare and any comparison is of interest, than we could performs $\binom{K}{2}$ pairwise comparisons with $\mathscr{H}_{0}: \mu_i = \mu_j$ for $i \neq j$. For $K=3$, there are three such comparisons, 10 pairwise comparisons if $K=5$ and 45 pairwise comparisons if $K=10$. Thus, some 'discoveries' are bound to be spurious.

The number of tests performed in the course of an analysis can be very large. Y. Benjamini investigated the number of tests performed in each study of the Psychology replication project [@Nosek:2015]: this number ranged from 4 to 700, with an average of 72 --- most studies did not account for the fact they were performing multiple tests or selected the model. It is natural to ask then how many results are spurious findings that correspond to type I errors. The paramount (absurd) illustration is the cartoon presented in Figure \@ref(fig:xkcdsignificant): note how there is little scientific backing for the theory (thus such test shouldn't be of interest to begin with) and likewise the selective reporting made of the conclusions, despite nuanced conclusions.

We can also assess mathematically the problem. Assume for simplicity that all tests are independent^[This is the case if tests are based on different data, or if the contrasts considered are orthogonal under normality.] and that each test is conducted at level $\alpha$. The probability of making at least one type I error, say $\alpha^{\star}$, is^[The second line holds with independent observations, the second follows from the use of Boole's inequality and does not require independent tests.]
\begin{align}\alpha^{\star} &= 1 – \text{probability of making no type I error} \\\ &= 1- (1-\alpha)^m\\
& \leq m\alpha
  (\#eq:bonferroni)
\end{align}

With $\alpha = 5$% and $m=4$ tests, $\alpha^{\star} \approx 0.185$ whereas for $m=72$ tests, $\alpha^{\star} \approx 0.975$: this means we are almost guaranteed even when nothing is going on to find "statistically significant" yet meaningless results.

<div class="figure" style="text-align: center">
<img src="figures/xkcd882_significant.png" alt="xkcd 882: Significant. The alt text is 'So, uh, we did the green study again and got no link. It was probably a--' 'RESEARCH CONFLICTED ON GREEN JELLY BEAN/ACNE LINK; MORE STUDY RECOMMENDED!'" width="85%" />
<p class="caption">(\#fig:xkcdsignificant)xkcd 882: Significant. The alt text is 'So, uh, we did the green study again and got no link. It was probably a--' 'RESEARCH CONFLICTED ON GREEN JELLY BEAN/ACNE LINK; MORE STUDY RECOMMENDED!'</p>
</div>

It is sensible to try and reduce or bound the number of false positive or control the probability of getting spurious findings. We consider a **family** of $m$ null hypothesis $\mathscr{H}_{01}, \ldots, \mathscr{H}_{0m}$ tested. The family is simply a collection of $m$ hypothesis tests: the exact set depends on the context, but this comprises all hypothesis that are scientifically relevant and could be reported. These comparisons are called **pre-planned comparisons**: they should be chosen before the experiment takes place and pre-registered to avoid data dredging and selective reporting. The number of planned comparisons should be kept small relative to the number of parameters: for a one-way ANOVA, a general rule of thumb is to make no more comparisons than the number of groups, $K$.

Suppose that we perform $m$ hypothesis tests in a study and define binary indicators
\begin{align}
R_i &= \begin{cases} 1 & \text{if we reject the null hypothesis }  \mathscr{H}_{0i} \\
0 & \text{if we fail to reject } \mathscr{H}_{0i}
\end{cases}\\
V_i &=\begin{cases} 1 & \text{type I error for } \mathscr{H}_{0i}\quad  (R_i=1 \text{ and  }\mathscr{H}_{0i} \text{ is true}) \\ 0 & \text{otherwise}.
\end{cases}
\end{align}
With this notation,  $R=R_1 + \cdots + R_m$ simply encodes the total number of rejections ($0 \leq R \leq m$), and $V = V_1 + \cdots + V_m$ is the number of null hypothesis rejected by mistake ($0 \leq V \leq R$). 

The **familywise error rate** is the probability of making at least one type I error per family, 
\begin{align*}
\mathsf{FWER} = \Pr(V \geq 1).
\end{align*}
To control the familywise error rate, one must be more stringent in rejecting the null and perform each test with a smaller level $\alpha$ so that the overall or simultaneous probability is less than $\mathsf{FWER}$.

### Bonferroni's procedure

The easiest way (and one of the least powerful option) is to directly use the inequality in eq. \@ref(eq:bonferroni). If each test is performed at level $\alpha/m$, than the family-wise error is controlled at level $\alpha$.



The Bonferroni adjustment also controls the **per-family error rate**, which is the expected (theoretical average) number of false positive $\mathsf{PFER} = \mathsf{E}(V)$. The latter is a more stringent criterion than the familywise error rate because $\Pr(V \geq 1) \leq \mathsf{E}(V)$: the familywise error rate does not make a distinction between having one or multiple type I errors.^[By definition, the expected number of false positive (PFER) is $\mathsf{E}(V) = \sum_{i=1}^m i \Pr(V=i) \geq \sum_{i=1}^m \Pr(V=i) = \Pr(V \geq 1)$, so larger than the probability of making at least type 1 error. Thus, any procedure that controls the per-family error rate (e.g., Bonferroni) also automatically bounds the familywise error rate.] 

Why is Bonferroni's procedure popular? It is conceptually easy to understand and simple, and it applies to any design and regardless of the dependence between the tests. However, the number of tests to adjust for, $m$, must be prespecified and the procedure leads to low power when the size of the family is large. Moreover, if our sole objective is to control for the familywise error rate, then there are other procedures that are always better in the sense that they still control the $\mathsf{FWER}$ while leading to increased capacity of detection when the null is false.

If the raw (i.e., unadjusted) $p$-values are reported, we reject hypothesis $\mathscr{H}_{0i}$ if $m \times p_i \ge \alpha$: operationally, we multiply each $p$-value by $m$ and reject if the result exceeds $\alpha$.


### Holm-Bonferroni's procedure

The idea of Holm's procedure is to use a sharper inequality bound and amounts to performing tests at different levels, with more stringent for smaller $p$-values.

Order the $p$-values of the family of $m$ tests from smallest to largest
$p_{(1)} \leq \cdots \leq p_{(m)}$ and test sequentially the hypotheses. Coupling Holm's method with Bonferroni's procedure, we compare $p_{(1)}$ to $\alpha_{(1)} = \alpha/m$, $p_{(2)}$ to $\alpha_{(2)}=\alpha/(m-1)$, etc. 

If all of the $p$-values are less than their respective levels, than we still reject each null hypothesis. Otherwise, we reject all the tests whose $p$-values exceeds the smallest nonsignificant one. If $p_{(j)} \geq \alpha_{(j)}$ but $p_{(i)} \leq \alpha_{(i)}$ for $i=1, \ldots, j-1$ (all smaller $p$-values), we reject the associated hypothesis $\mathscr{H}_{0(1)}, \ldots, \mathscr{H}_{0(j-1)}$ but fail to reject $\mathscr{H}_{0(j)}, \ldots, \mathscr{H}_{0(m)}$.

This procedure doesn't control the per-family error rate, but is uniformly more powerful and thus leads to increased detection than Bonferroni's method.

To see this, consider a family of $m=3$ $p$-values with values $0.01$, $0.04$ and $0.02$. Bonferroni's adjustment would lead us to reject the second and third hypotheses at level $\alpha=0.05$, but not Holm-Bonferroni.

**To be continued**...
