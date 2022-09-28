# Complete factorial designs

We next consider experiments and designs in which there are multiple factors being manipulated by the experimenter simultaneously. 

Before jumping into the statistical analysis, let us discuss briefly some examples that will be covered in the sequel.

:::{ .example name="Replication of 'Precision of the anchor influences the amount of adjustment'"}


We consider data from a replication by Chandler (2016) of Study 4a of Janiszewski and Uy (2008). Both studies measured the amount of adjustment when presented with vague or precise range of value for objects, with potential encouragement for adjusting more the value.

@Chandler:2016 described the effect in the replication report:

> Janiszewski and Uy (2008) conceptualized people’s attempt to adjust following presentation of an anchor as movement along a subjective representation scale by a certain number of units. Precise numbers (e.g. $9.99) imply a finer-resolution scale than round numbers (e.g. $10). Consequently, adjustment along a subjectively finer resolution scale will result in less objective adjustment than adjustment by the same number of units along a subjectively coarse resolution scale.

The experiment is a 2 by 2 factorial design (two-way ANOVA) with `anchor` (either round or precise) and `magnitude` (`0` for small, `1` for big adjustment) as experimental factors. A total of 120 students were recruited and randomly assigned to one of the four experimental sub-condition, for a total of 30 observations per subgroup (`anchor`, `magnitude`). The response variable is `majust`, the mean adjustment for the price estimate of the item.

:::



:::{.example name="Psychological ownership of borrowed money"}

Supplemental Study 5 from @Sharma.Tully.Cryder:2021 checks the psychological perception of borrowing money depending on the label. The authors conducted a 2 by 2 between-subject comparison (two-way ANOVA) varying the type of debt (whether the money was advertised as credit or loan) and the type of purchase the latter would be used for (discretionary spending or need). The response is the average of the likelihood and interest in the product, both measured using a 9 point Likert scale from 1 to 9.


:::

:::{.example name="Spatial orientation shrinks and expands psychological distance"}

@Maglio.Polman:2014 measured the subjective distance on travel based on the direction of travel. They conducted an experiment in the Toronto subway green line, asking commuters from Bay station to answer the question "How far away does the [name] station feel to you?" using a 7 point Likert scale ranging from very close (1) to very far (7). The stations name were one of Spadina, St. George, Bloor-Yonge and Sherbourne (from West to East)

:::





```r
data(C16, package = "hecedsm")
```


### Efficiency of multiway analysis of variance.


Consider the setting of @Sharma.Tully.Cryder:2021 and suppose we want to check the impact of debt and collect a certain number of observations in each group. If we suspected the label had an influence, we could run a one-way analysis of variance for each spending type separately. We could do likewise if we wanted instead to focus on whether the spending was discretionary in nature or not, for each label. Combining the two factors allows us to halve the number of groups/samples we collect in this simple setting: this highlights the efficiency of running an experiment modifying all of these instances at once, over a series of one-way analysis of variance. This concept extends to higher dimension when we manipulate two or more factors. Factorial designs allow us to study the impact of multiple variables simultaneously with **fewer overall observations**. The drawback is that as we increase the number of factors, the total number of subgroups increases: with a complete design^[By complete design, it is meant that we gather observations for each subcategory.] and with factors $A$, $B$, $C$, etc. with $a$, $b$, $c$, $\ldots$ levels, we have a total of $a\times b \times c \times \cdots$ combinations and the number of observations needed to efficiently measure the group means increases quickly. This is the **curse of dimensionality**: the larger the number of experimental treatments manipulated together, the larger the sample size needed. A more efficient approach, which we will cover in later section, relies on calculating repeated measures from the same experimental units, for example by giving multiple tasks (randomly ordered) to participants.

Intrinsically, the multiway factorial design model description does not change relative to a one-way design: the analysis of variance still describes the sample mean for the response in each subgroup. With

The first test to carry out is for the interaction: if the effect of one factor depends on the level of the other, as shown in \@ref(fig:interaction), then we need to compare the label of debt type separately for each type of purchase and vice-versa using so called **simple effects**. If the interaction on the contrary isn't significant, then we could pool observations instead and average across either of the two factors, resulting in the marginal comparisons with the main effects.

Fitting the model including the interaction between factors ensures that we keep the additivity assumption and that our conclusions aren't misleading: the price to pay is additional mean parameters to be estimated, which isn't an issue if you collect enough data, but can be critical when data collection is extremely costly and only a few runs are allowed.

@Sharma.Tully.Cryder:2021 first proceeded with the test for the interaction. Since there are one global average and two main effect (additional difference in average for both factors `debttype` and `purchase`), the interaction involves one degree of freedom since we go from a model with three parameters describing the mean to one that has a different average for each of the four subgroups.


```r
# Analysing Supplementary Study 5
# of Sharma, Tully, and Cryder (2021)
data(STC21_SS5, package = "hecedsm")
mod <- aov(likelihood ~ purchase*debttype, 
           data = STC21_SS5)
# Analysis of variance reveals 
# non-significant interaction
# of purchase and type
car::Anova(mod, type = 3)
#> Anova Table (Type III tests)
#> 
#> Response: likelihood
#>                   Sum Sq   Df F value  Pr(>F)    
#> (Intercept)         7974    1 1040.96 < 2e-16 ***
#> purchase             283    1   36.91 1.6e-09 ***
#> debttype              88    1   11.55  0.0007 ***
#> purchase:debttype     14    1    1.79  0.1817    
#> Residuals          11467 1497                    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# Main effect
# Marginal effect
emmeans::emmeans(mod, 
                 specs = "debttype",
                 contr = "pairwise")
#> $emmeans
#>  debttype emmean    SE   df lower.CL upper.CL
#>  credit     5.12 0.101 1497     4.93     5.32
#>  loan       4.63 0.101 1497     4.43     4.83
#> 
#> Results are averaged over the levels of: purchase 
#> Confidence level used: 0.95 
#> 
#> $contrasts
#>  contrast      estimate    SE   df t.ratio p.value
#>  credit - loan    0.496 0.143 1497   3.470  0.0005
#> 
#> Results are averaged over the levels of: purchase
  
# Pairwise comparisons within levels of purchase
# Simple effect
emmeans::emmeans(mod, 
                 specs = c("purchase", "debttype"),
                 by = "purchase",
                 contr = "pairwise")
#> $emmeans
#> purchase = discretionary:
#>  debttype emmean    SE   df lower.CL upper.CL
#>  credit     4.51 0.140 1497     4.24     4.78
#>  loan       3.82 0.146 1497     3.54     4.11
#> 
#> purchase = need:
#>  debttype emmean    SE   df lower.CL upper.CL
#>  credit     5.74 0.146 1497     5.45     6.02
#>  loan       5.43 0.140 1497     5.16     5.71
#> 
#> Confidence level used: 0.95 
#> 
#> $contrasts
#> purchase = discretionary:
#>  contrast      estimate    SE   df t.ratio p.value
#>  credit - loan    0.687 0.202 1497   3.400  0.0007
#> 
#> purchase = need:
#>  contrast      estimate    SE   df t.ratio p.value
#>  credit - loan    0.305 0.202 1497   1.510  0.1318
```

In the analysis of variance table, we only focus on the last line with the sum of squares for `purchase:debttype`. The $F$ statistic is 1.785; using the $\mathsf{F}$ (1, 1497) distribution as benchmark, we obtain a $p$-value of 0.18 so there is no evidence the effect of purchase depends on debt type.

We can thus pool data and look at the effect of debt type (`loan` or `credit`) overall by combining the results for all purchase types, one of the planned comparison reported in the Supplementary material. To do this in **R** with the `emmeans` package, we use the `emmeans` function and we quote the factor of interest (i.e., the one we want to keep) in `specs`. By default, this will compute the estimate marginal means: the `contr = "pairwise"` indicates that we want the difference between the two, which gives us the contrasts.

To get the simple effects, we give both variables in `specs` as factors for which to compute subgroup means, then set additionally the `by` command to specify which variable we want separate results for. We get the difference in average between `credit` and `loan` labels for each purchase type along with the $t$ statistics for the marginal contrast and the $p$-value. The simple effects suggest that the label has an impact on perception only for discretionary expenses rather than needed ones, which runs counter-intuitively with the lack of interaction.



:::keyidea

**Summary**:

* Complete factorial designs consist of experiments in which we manipulate multiple experimental factors at once and collect observations for each subgroup.
* Factorial designs are more efficient than running repeatedly one-way analysis of variance with the same sample size per group.
* Interactions occur when the effect of a variable depends on the levels of the others.
* Interaction plots (group average per group) can help capture this difference, but beware of overinterpretation in small samples
* If there is an interaction, we consider differences and contrasts for each level of the other factor (**simple effects**)
* If there is no interaction, we can pool observations and look at **main effects**
* A multiway analysis of variance can be treated as a one-way analysis of variance by collapsing categories; however, only specific contrasts will be of interest.
* The number of observations increases quickly with the dimension as we increase the number of factors considered.


:::
