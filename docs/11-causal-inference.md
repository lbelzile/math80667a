# Causal inference


A pet peeve of statisticians is to state that correlation (or association) between two phenomena is not the same as causation. For example, weather forecasts of rain and the number of people carrying umbrellas in the streets are positively correlated, but the relationship is directed: if I intervene as an experimenter and force everyone around to carry umbrellas, it won't impact weather forecasts nor the weather itself.
The website [Spurious correlations](https://tylervigen.com/spurious-correlations) by Tyler Vigen shows multiple graphs of absurd relations, many of which are simply artefact of population growth.

<div class="figure" style="text-align: center">
<img src="figures/xkcd552_correlation.png" alt="xkcd comic [552 (Correlation) by Randall Munroe](https://xkcd.com/552/). Alt text: Correlation doesn't imply causation, but it does waggle its eyebrows suggestively and gesture furtively while mouthing 'look over there'. Cartoon reprinted under the [CC BY-NC 2.5 license](https://creativecommons.org/licenses/by-nc/2.5/)." width="60%" />
<p class="caption">(\#fig:xkcd2569)xkcd comic [552 (Correlation) by Randall Munroe](https://xkcd.com/552/). Alt text: Correlation doesn't imply causation, but it does waggle its eyebrows suggestively and gesture furtively while mouthing 'look over there'. Cartoon reprinted under the [CC BY-NC 2.5 license](https://creativecommons.org/licenses/by-nc/2.5/).</p>
</div>

Causal inference is concerned with inferring the effect of an action or manipulation (intervention, policy, or treatment) applied to an observational unit and identifying and quantifying the effect of one variable on other variables.  Such action may be conceptual: we can imagine for example looking at student's success (as measured by their grades) by comparing two policies: giving them timely feedback and encouragement, versus no feedback. In reality, only one of these two scenarios can be realized even if both can conceptually be envisioned as **potential outcomes**. The fundamental problem of causal inference is that while we would like to study the impact of every action on our response, we can only effectively measure it in one scenario^[In a within-subject design, a single ordering can be presented.]



In an experiment, we can manipulate assignment to treatment $a$ and randomize units to each value of the treatment to avoid undue effects from other variables. The potential outcomes applies in between-subject design because experimental units are assigned to a single treatment, whereas in within-subject designs a single ordering is presented. If we denote the outcome by $Y$, then we are effectively comparing $(Y \mid a)$ for different values of the action set $a$. We talk about causation when for treatment ($a=i$) and control ($a=0$), the distributions of $(Y \mid a=i)$ differs from that of $(Y \mid a=0)$. 

The most simple used measure of causation is the **average treatment effect**, which is the difference between the population averages of treated and control groups,
\begin{align*}
\textsf{ATE}_i = \mathsf{E}(Y \mid a=i) - \mathsf{E}(Y \mid a=0)
\end{align*}
In experimental designs, we can target the average treatment effect if our subjects comply with their treatment assignment and if we randomize the effect and use a random sample which is representative of the population.

In many fields, the unconditional effect is not interesting enough to warrant publication free of other explanatory variables. It may be that the effect of the treatment is not the same for everyone: for example, a study on gender discrimination may reveal different perceptions depending on the gender. We could look at conditional effects and potential interactions. We may also be interested in seeing how different mechanisms and pathways are impacted by treatment and how this affects the response. @Vanderweele:2015 provides an excellent non-technical overview of mediation and interaction.

Many statistical models commonly used, including regression models, cannot provide an answer to a problem that is philosophical or conceptual in nature.

<!--
TODO: write about conditional average treatment effect (CATE) and local average treatment effect. Discuss noncompliance and potential selection effects (selection on colliders)
-->

Causal inference requires a logical conceptual model of the interrelation between the variables. We will look at directed acyclic graphs to explain concepts of confounding, collision and mediation and how they can influence.

A directed acyclic graph (DAG) a graph with no cycle: each node represents a variable of interest and these are linked with directed edges indicating the nature of the relation (if $X$ causes $Y$, then $X \to Y$). Directed acyclic graphs are used to represent the data generating process that causes interdependencies, while abstracting from the statistical description of the model. This depiction of the conceptual model helps to formalize and identify the assumptions of the model. To identify a causal effect of a variable $X$ on some response $Y$, we need to isolate the effect from that of other potential causes.
Figure \@ref(fig:fig-daggity) shows an example of DAG in a real world study identifying pathways.

<!--https://bookdown.org/mike/data_analysis/causal-inference.html-->

<div class="figure" style="text-align: center">
<img src="figures/dagitty-model.png" alt="Directed acyclic graph of @McQuire:2020 reproduction by [Andrew Heiss](https://www.andrewheiss.com/), licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)." width="60%" />
<p class="caption">(\#fig:fig-daggity)Directed acyclic graph of @McQuire:2020 reproduction by [Andrew Heiss](https://www.andrewheiss.com/), licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/).</p>
</div>


At a theoretical level, the DAG will help identify which paths and relations to control through conditioning arguments to strip the relation to that of interest. Judea Pearl [e.g., @Pearl:2016] identifies three potential relations between triples of variables: 

- chains ($X \to Z\to Y$), 
- forks ($Z \leftarrow X \rightarrow Y$) and 
- reverse forks ($Z \rightarrow X \leftarrow Y$).

These are represented in Figure \@ref(fig:fig-causalrelations). In the graph, $X$ represents an explanatory variable, typically the experimental factor, $Y$ is the response and $Z$ is another variable whose role depends on the logical flow between variables (collider, confounder or mediator).

<div class="figure" style="text-align: center">
<img src="figures/causal_dag_aheiss.jpg" alt="Type of causal relations by Andrew Heiss, licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)." width="100%" />
<p class="caption">(\#fig:fig-causalrelations)Type of causal relations by Andrew Heiss, licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/).</p>
</div>

It is *essential* to determine via logic or otherwise (experiments can help!) the direction of the relationship, lest we run into trouble. Popular statistical tools such as linear regression model correlation, which is symmetric and so cannot help the direction of the arrows in the directed acyclic graph. Why does it matter what kind of relation exists? For one, the conclusions we will draw depend on the nature of the relation. For example, we could eliminate the effect of a confounding variable by controlling in a regression model or by stratifying for different values of the confounders in order to extract the causal estimate of $X$ on $Y$. However, the same strategy with a collider would backfire and we would get erroneous conclusions. A recent example of collider is @Kowal:2021, who reportedly found out couples with more children were more unhappy. As reported by Richard McElreath, controlling for mariage is incorrect since unhappy couples tend to divorce, but families with large number of children are less likely to divorce! This invalides the claim and findings of the paper.




The content of this chapter is divided as follows. First, we discuss the logical interrelation between variables using directed acyclic graphs and focus on relations between triples defining confounders, colliders and mediators. We then highlight the fundamental differences between experimental and observational studies. Another section will focus on the study of interactions between variables (also called moderation in humanities), when the effect depends on other variables and differs depending on characteristics. 

One of the most popular model in social sciences is the linear mediation model. We will present in details the basis for inference and highlight the assumptions of the model required for the results to have a causal interpretation and robustness of the results to model misspecification.

In a randomized experiment, we can check the average outcome of a manipulation by comparing groups: assuming random sampling, these conclusions can be broadly generalized to the population of interest from which the sample is drawn. However, it may be that the effect of the treatment depends on other variables: cultural differences, gender or education may change. In the statistical model, inclusion of interaction terms (typically product of the moderator variable with the factor encoding the experimental subcondition) will allow us to estimate those differences. 


<!-- Sequential ignorability assumption, SUTVA, -->
