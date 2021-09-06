
# Introduction {#introduction}

:::keyidea

**Learning objectives**:

* Learning the terminology associated to experiments.
* Assessing the generalizability of a study based on the consideration of the sample characteristics, sampling scheme and population.
* Distinguishing between observational and experimental studies
* Describing in your own words the four pillars of experimental designs.
* Understanding the rationale behind the requirements for good experimental studies and how it translates into model assumptions.

:::

The field of causal inference is concerned with inferring the effect of a treatment variable (sometimes called independent variable) on a response variable (dependent variable). In general, however [@Cox:1958]

> effects under investigation tend to be masked by fluctuations outside the experimenter's control.

The purpose of experiments is to arrange data collection so as to be capable of disentangling the differences due to treatment from those due to the (often large) intrinsic variation of the measurements. We typically expect differences between treatments (and thus the effect) to be *comparatively stable* relative to the measurement variation. 

## Terminology


In its simplest form, an **experimental design** is a comparison of two or more treatments (experimental conditions):

- The subjects (or **experimental units**) in the different groups of treatment have similar characteristics and are treated exactly the same way in the experimentation except for the treatment they are receiving. Formally, an experimental unit is the smallest division such that any two units may receive different treatments.
- The **observational unit** is the smallest level (time point, individual) at which measurement are recorded.
- The **experimental treatments** or conditions (also called **factor**, or independent variable), are *manipulated and controlled* by the researcher. Oftentimes, there is a **control** or baseline treatment relative to which we measure improvement (e.g., a placebo for drugs).
- Additional explanatories that are intrinsic to the experimental (sub-)units are termed **blocking factors**. Controlling for these allows to reduce the variability of measurements, typically leading to improved inferences.
- After the different treatments have been administered to subjects participating in a study, the researcher measures one or more outcomes (also called responses or dependent variables) on each subject. 
- Observed differences in the outcome variable between the experimental conditions (treatments) is called the treatment effect (or **effect size**). 

::: {.example #experimentdefinitions name="Pedagogical experience"}
Suppose we want to study the effectiveness of different pedagogical approaches to learning. Evidence-based pedagogical researchs point out that active learning leads to higher retention of information. To corroborate this research hypothesis, we can design an experiment in which different sections of a course are assigned to different teaching methods. In this example, each student in a class group receives the same teaching assignment, so the experimental units are the sections and the observations units are the individual students. 

The treatment is the teaching method (traditional teaching versus flipped classroom). 

Potential blocking factors for this experiment include the strength of individuals, which reflects their prior exposure to the topic, knowledge, maturity, etc. This could be measured using a preliminary exam before assignment of students to class groups is completed. Additional factors worth controlling for include timing of the classroom (morning, afternoon, evening classes) and instructors.
:::

:::yourturn

The marketing department wants to know the value of its brand by determining how much more customers are willing to pay for their product relative to the cheaper generic product offered by the store. Economic theory suggests a substitution effect: while customers may prefer the brand  product, they will switch to the generic version if the price tag is too high. To check this theory, one could design an experiment.

As a researcher, how would you conduct this study? Identify a specific product. For the latter, define

- an adequate response variable
- the experimental and observational units
- potential confounding variables that would need to be accounted for.
:::

## Review of basic concepts


### Variables

The choice of statistical model and test depends on the underlying type of the data collected. There are many choices: quantitative (discrete or continuous) if the variables are numeric, or qualitative (binary, nominal, ordinal) if they can be described using an adjective; I prefer the term categorical, which is more evocative. The choice of graphical representation for data is contingent on variable type. Specifically,

- a **variable** represents a characteristic of the population, for example the sex of an individual, the price of an item, etc.
- an **observation** is a set of measures (variables) collected under identical conditions for an individual or at a given time.



<div class="figure" style="text-align: center">
<img src="figures/continuous_discrete.png" alt="Artwork by Allison Horst of continuous (left) and discrete variables (right)." width="85%" />
<p class="caption">(\#fig:variablesquanti)Artwork by Allison Horst of continuous (left) and discrete variables (right).</p>
</div>

Most of the models we will deal with are so-called regression models, in which the mean of a quantitative variable is a function of other variables, termed explanatories. There are two types of numerical variables

- a discrete variable takes a countable number of values, prime examples being binary variables or count variables.
- a continuous variable can take (in theory) an infinite possible number of values, even when measurements are rounded or measured with a limited precision (time, width, mass). In many case, we could also consider discrete variables as continuous if they take enough values (e.g., money).

Categorical variables take only a finite of values. They are regrouped in two groups, nominal if there is no ordering between levels (sex, colour, country of origin) or ordinal if they are ordered (Likert scale, salary scale) and this ordering should be reflected in graphs or tables. We will bundle every categorical variable using  arbitrary encoding for the levels: for modelling, these variables taking $K$ possible values (or levels) must be transformed into a set of $K-1$ binary variables $T_1, \ldots, T_K$, each of which corresponds to the logical group $k$ (yes = 1, no = 0), the omitted level corresponding to a baseline when all of the $K-1$ indicators are zero. Failing to declare categorical variables in your software is a common mistake, especially when these are saved in the database using integers (1,2, $\ldots$) rather than as text (Monday, Tuesday, $\ldots$).

<div class="figure" style="text-align: center">
<img src="figures/nominal_ordinal_binary.png" alt="Artwork by Allison Horst with examples of categorical variables: nominal (left), ordinal (middle) and binary (right)." width="85%" />
<p class="caption">(\#fig:variablescateg)Artwork by Allison Horst with examples of categorical variables: nominal (left), ordinal (middle) and binary (right).</p>
</div>


### Population and samples {#population-sample}


Only for well-designed sampling schemes does results generalize beyond the group observed. It is thus of paramount importance to define the objective and the population of interest should we want to make conclusions.


Generally, we will seek to estimate characteristics of a population using only a sample (a sub-group of the population of smaller size). The **population of interest** is a collection of individuals which the study targets. For example, the Labour Force Survey (LFS) is a monthly study conducted by Statistics Canada, who define the target population as "all members of the selected household who are 15 years old and older, whether they work or not." Asking every Canadian meeting this definition would be costly and the process would be long: the characteristic of interest (employment) is also a snapshot in time and can vary when the person leaves a job, enters the job market or become unemployed. In this example, collecting a census would be impossible and too costly.

In general, we therefore consider only **samples** to gather the information we seek to obtain. The purpose of **statistical inference** is to draw conclusions about the population, but using only a share of the latter and accounting for sources of variability. The pollster George Gallup made this great analogy between sample and population:

> One spoonful can reflect the taste of the whole pot, if the soup is well-stirred

A **sample** is a sub-group of individuals drawn at random from the population. We won't focus on data collection, but keep in mind the following information: for a sample to be good, it must be representative of the population under study.

::: {.yourturn name="Confounding"}
The [Parcours  AGIR](https://www.hec.ca/etudiants/mon-programme/baa/cohorte-agir/index.html) at HEC Montréal is a pilot project for Bachelor in Administration students that was initiated to study the impact of flipped classroom and active learning on performance.

Do you think we can draw conclusions about the efficacy of this teaching method by comparing the results of the students with those of the rest of the bachelor program? List potential issues with this approach addressing the internal and external validity, generalizability, effect of lurking variables, etc.
:::

Because the individuals are selected at **random** to be part of the sample, the measurement of the characteristic of interest will also be random and change from one sample to the next. While larger samples typically carry more information, sample size is not a guarantee of quality, as the following example demonstrates.

::: {.example #Galluppoll name="Polling for the 1936 USA Presidential Election"}

*The Literary Digest* surveyed 10 millions people by mail to know voting preferences for the 1936 USA Presidential Election. A sizeable share, 2.4 millions answered, giving Alf Landon (57\%) over incumbent President Franklin D. Roosevelt (43\%). The latter nevertheless won in a landslide election with 62\% of votes cast, a 19\% forecast error. [Biased sampling and differential non-response are mostly responsible for the error:](https://www.jstor.org/stable/2749114) the sampling frame was built using ``phone number directories, drivers' registrations, club memberships, etc.'', all of which skewed the sample towards rich upper class white people more susceptible to vote for the GOP.

In contrast, Gallup correctly predicted the outcome by polling (only) 50K inhabitants. [Read the full story here.](https://medium.com/@ozanozbey/how-not-to-sample-11579793dac)

:::


::: outsidethebox

What are the considerations that could guide you in determining the population of interest for your study?

:::


### Sampling

Because sampling is costly, we can only collect limited information about the variable of interest, drawing from the population through a sampling frame (phone books, population register, etc.) Good sampling frames can be purchased from sampling firms.

In general, *randomization* is necessary in order to obtain a **representative** sample^[Note this randomization is different from the one in assigning treatments to experimental units!], one that match the characteristics of the population. Failing to randomize leads to introduction of bias and generally the conclusions drawn from a study won't be generalizable. 

Even when observational units are selected at random to participate, there may be **bias** introduced due to non-response. In the 1950s, conducting surveys was relatively easier because most people were listed in telephone books; nowadays, sampling firms rely on a mix of interactive voice response and live callers, with sampling frames mixing landlines, cellphones and online panels together with (heavy) weighting to correct for non-response. Sampling is a difficult problem with which we engage only cursorily, but readers are urged to exercise scrutiny when reading papers.

::: outsidethebox

Reflect on the choice of platform used to collect answers and think about how it could influence the composition of the sample returned or affect non-response in a systematic way.

:::

Before examining problems related to sampling, we review the main random sampling methods. The simplest is simple random sampling, whereby $n$ units are drawn completely at random (uniformly) from the $N$ elements of the sampling frame. The second most common scheme is stratified sampling, whereby a certain numbers of units are drawn uniformly from strata, namely subgroups (e.g., gender). Finally, cluster sampling consists in sampling only from some of these subgroups. 

::: { .example name="Illustration of sampling schemes"}
Suppose we wish to look at student satisfaction regarding the material taught in an introductory statistics course offered to multiple sections. The population consists of all students enrolled in the course in a given semester and this list provides the sampling frame. We can define strata to consist of class group. A simple random sample would be obtaining by sampling randomly abstracting from class groups, a stratified sample by drawing randomly a number from each class group and a cluster sampling by drawing all students from selected class groups. Cluster sampling is only mostly useful if all groups are similar and if the costs associated to sampling from multiple strata are expensive. 



<div class="figure" style="text-align: center">
<img src="01-introduction_files/figure-html/sampling-1.png" alt="Illustration of three sampling schemes from nine stratum: simple random sampling (left), stratified sampling (middle) and cluster sampling (right). In the middle, the grouping corresponds to stratum (e.g., age groups) whereas the right contains cluster (e.g., villages)" width="85%" />
<p class="caption">(\#fig:sampling)Illustration of three sampling schemes from nine stratum: simple random sampling (left), stratified sampling (middle) and cluster sampling (right). In the middle, the grouping corresponds to stratum (e.g., age groups) whereas the right contains cluster (e.g., villages)</p>
</div>

Stratified sampling is typically superior if we care about having similar proportions of sampled in each group and is useful for reweighting: in \@ref(fig:sampling), the true proportion of sampled is 1/3, with the simple random sampling having a range of [0.22, 0.39] among the strata, compared to [0.32, 0.34] for the stratified sample.

:::

::: outsidethebox

The credibility of a study relies in large part on the quality of the data collection. Why is it customary to report descriptive statistics of the sample and a description of the population?

:::

There are other instances of sampling, most of which are non-random and to be avoided whenever possible. These include convenience samples, consisting of observational units that are easy to access or include (e.g., friends, students from a university, passerby in the street). Much like for anecdotal reports, these observational units need not be representative of the whole population and it is very difficult to understand how they relate to the latter.

In recent years, there has been a proliferation of studies employing data obtained from web experimentation plateforms such as Amazon's Mechanical Turk (MTurk), to the point that the Journal of Management commissioned a review [@Aguinis:2021]. These samples are subject to self-selection bias and should be read with skepticism. I would reserve these tools for paired samples (e.g., asking people to perform multiple tasks presented in random order) for which the composition of the population is relatively unimportant. To make sure your sample matches the target population, you can use statistical tests and informal comparison and compare the repartition of individuals with the composition obtained from the census. 


### Study type



There are two categories of studies: observational and experimental. The main difference between the two is that researchers that collect the data for observational studies do intervene in treatment assignment and how the data are created, whereas the assignment mechanism is fully determined by the experimenter in the latter case.
For example, an economist studying the impact of interest rates on the price of housing can only look at historical records of sales. Similarly, surveys studying the labour market are also observational: people cannot influence the type of job performed by employees or their social benefits to see what could have happened. Observational studies can lead to detection of association, but only an experiment in which the researcher controls the allocation mechanism through randomization can lead to *directly* establish existence of a causal relationship. Because everything else is the same in a well controlled experiment, any treatment effect should be in principle caused by the factor. 

The preceding paragraph shouldn't be taken to mean that one cannot get meaningful conclusions from observational studies. Rather, I wish to highlight that controlling for the non-random allocation and potential confounding is much more complicated, requires practitioners to make stronger (and sometimes unverifiable) assumptions and requires using a different toolbox (including, but not limited to differences in differences, propensity score weighting, instrumental variables).

<div class="figure" style="text-align: center">
<img src="figures/random_sample_assignment.png" alt="Two by two classification matrix for experiments based on sampling and study type. Material from Mine Çetinkaya-Rundel and OpenIntro distributed under the CC BY-SA license." width="85%" />
<p class="caption">(\#fig:openintrograph)Two by two classification matrix for experiments based on sampling and study type. Material from Mine Çetinkaya-Rundel and OpenIntro distributed under the CC BY-SA license.</p>
</div>

Figure \@ref(fig:openintrograph) summarizes the two preceding sections. Random allocation of both observational units and assignment to treatment leads to ideal studies, but may be impossible due to ethical considerations.

## Examples of experimental designs


One of the earliest example of statistical experiment is in agricultural field trial:  in fact, experiments have been ongoing since 1841 at the Rothamsted Experimental Station, where R. A. Fisher worked for 14 years and developed much of the early theory; @Yates:1964 details his contribution to the field of design of experiments.

Section 1.4 of @Berger:2018 lists various applications of experimental designs in a variety of fields.

::: {.example #experimentalexample1 name="Modern experiments and A/B testing"}
Most modern experiments happen online, with tech companies running thousands of experiments on an ongoing basis in order to discover improvement to their interfaces that lead to increased profits. An [Harvard Business Review article](https://hbr.org/2017/09/the-surprising-power-of-online-experiments) [@HBR2017] details how small tweaks to the display of advertisements in the Microsoft Bing search engine landing page lead to a whooping 12\% increase in revenues. Such randomized control trials, termed A/B experiments, involve splitting incoming traffic into separate groups; each group will see different views of the webpage that differ only ever slightly. The experimenters then compare traffic and click revenues. At large scale, even small effects can have major financial consequences and can be learned despite the large variability in customer behaviour.
:::



### Evidence-based policies

Experimental design revolves in large part in understanding how best to allocate our resources and choosing the most effective treatment of the lot. There are multiple examples of randomized control experiments used for policy making. Examples include

- Tennessee's Student Teacher Achievement Ratio (STAR) project [@STAR2008]: this study looked at the effect of student to teacher ratio and conclude that smaller class sizes lead to better outcomes.

> Four-year longitudinal class-size study funded by the Tennessee General Assembly and conducted by the State Department of Education. Over 7,000 students in 79 schools were randomly assigned into one of 3 interventions: small class (13 to 17 students per teacher), regular class (22 to 25 students per teacher), and regular-with-aide class (22 to 25 students with a full-time teacher's aide). Classroom teachers were also randomly assigned to the classes they would teach. The interventions were initiated as the students entered school in kindergarten and continued through third grade.

- RAND's Health Insurance Experiment [@RANDHIE]: this study concluded that that cost sharing reduced "inappropriate or unnecessary" medical care (overutilization), but also lead to to areduction in "appropriate or needed" medical care.

> The HIE was a large-scale, randomized experiment conducted between 1971 and 1982. For the study, RAND recruited 2,750 families encompassing more than 7,700 individuals, all of whom were under the age of 65. They were chosen from six sites across the United States to provide a regional and urban/rural balance. Participants were randomly assigned to one of five types of health insurance plans created specifically for the experiment. There were four basic types of fee-for-service plans: One type offered free care; the other three types involved varying levels of cost sharing — 25 percent, 50 percent, or 95 percent coinsurance (the percentage of medical charges that the consumer must pay). The fifth type of health insurance plan was a nonprofit, HMO-style group cooperative. Those assigned to the HMO received their care free of charge. For poorer families in plans that involved cost sharing, the amount of cost sharing was income-adjusted to one of three levels: 5, 10, or 15 percent of income. Out-of-pocket spending was capped at these percentages of income or at $1,000 annually (roughly $3,000 annually if adjusted from 1977 to 2005 levels), whichever was lower. 

> Families participated in the experiment for 3–5 years. The upper age limit for adults at the time of enrollment was 61, so that no participants would become eligible for Medicare before the experiment ended. To assess participant service use, costs, and quality of care, RAND served as the families’ insurer and processed their claims. To assess participant health, RAND administered surveys at the beginning and end of the experiment and also conducted comprehensive physical exams. Sixty percent of participants were randomly chosen to receive exams at the beginning of the study, and all received physicals at the end. The random use of physicals at the beginning was intended to control for possible health effects that might be stimulated by the physical exam alone, independent of further participation in the experiment.

- [Oregon Health Insurance Experiment](https://www.povertyactionlab.org/evaluation/oregon-health-insurance-experiment-united-states) [@Baicker2013]: this study is described at length in [Section 9.5 of Telling stories with data by Rohan Alexander](https://www.tellingstorieswithdata.com/hunt-data.html#case-study---the-oregon-health-insurance-experiment) [@Alexander2021].


## Planning of experiments  {#planning-experiments}

There are four pillars in experimental designs;

1. **Control**: in an experiment, the allocation to treatment is controlled by the experimenter, allowing direct comparisons between groups.
2. **Randomization**: to prevent lurking variables and confounders from impacting the conclusions, observational units are randomly allocated to treatment groups so that any estimate of the effect has a causal interpretation.
3. **Replication**: having multiple observations for each treatment allocation is necessary to both estimate the variability of the measurements and increase the precision of the average measurement.
4. **Blocking**: a technique that allows experimenters to control the variability between experimental units by dividing them into blocks so that those in the same blocks are similar. This allows us to separate the variability due to differences between levels of the blocking variable from the overall variability, leading to precision gains.

Underlying the design of experiments is use of techniques that eliminate as much as possible the variability and detecting cause and effects with the least amount of resources by allocating them wisely. 

## Requirements for good experiments

Section 1.2 of @Cox:1958 describes the various requirements that are necessary for experiments to be useful. These are

1. absence of systematic error
2. precision
3. range of validity
4. simplicity

We review each in turn.

### Absence of systematic error

This point requires careful planning and listing potential confounding variables that could affect the response.

:::{ .example title="Systematic error"}
Suppose we wish to consider the differences in student performance between two instructors. If the first teaches only morning classes, while the second only teaches in the evening, it will be impossible to disentangle the effect of timing with that of instructor performance. Such comparisons should only be undertaken if there is compelling prior evidence that timing does not impact the outcome of interest.

:::

The first point raised by Cox is thus that we

> ensure that experimental units receiving one treatment differ in no systematic way from those receiving another treatment.

This point also motivates use of **double-blind** procedures (where both experimenters and participants are unaware of the treatment allocation) and use of placebo in control groups (to avoid psychological effects, etc. associated with receiving treatment or lack thereof participants).

Randomization is at the core of achieving this goal, and ensuring measurements are independent of one another also comes out as corollary.

### Variability 

The second point listed by @Cox:1958 is that of the variability of estimator. Much of the precision can be captured by the signal to noise ratio, in which the effect size is divided by its standard error. The latter is a function of 
(a) the accuracy of the experimental work and measurements apparatus and the intrinsic variability of the phenomenon under study, (b) the number of experimental and observational units, i.e., the sample size and (c) the choice of design and statistical procedures. 

Point (a) typically cannot be influenced by the experimenter outside of choosing the response variable to obtain more reliable measurements. Point (c) related to the method of analysis, is oftentimes standard unless there are robustness considerations. Point (b) is at the core of the planning, notably in choosing the number of units to use and the allocation of treatment to the different (sub)-units.

### Generalizability

Most studies are done with an objective of generalizing the findings beyond the particular units analyzed. The range of validity thus crucially depends with the choice of population from which a sample is drawn and the particular sampling scheme. Non-random sampling severely limits the extrapolation of the results to more general settings. This leads Cox to advocate having

> not just empirical  knowledge about what the treatment differences are, but also some understanding of the reasons for the differences.

Even if we believe a factor to have no effect, it may be wise to introduce it in the experiment to check this assumption: if it is not a source of variability, it shouldn't impact the findings and at the same time would provide some more robustness.

If we look at a continuous treatment, than it is probably only safe to draw conclusions within the range of doses administered. Comic in \@ref(fig:xkcd605) is absurd, but makes this point.

<div class="figure" style="text-align: center">
<img src="figures/xkcd605_extrapolating.png" alt="xkcd comic [645 (Extrapolating) by Randall Munroe](https://xkcd.com/645/). Alt text: By the third trimester, there will be thousands of babies inside you." width="50%" />
<p class="caption">(\#fig:xkcd605)xkcd comic [645 (Extrapolating) by Randall Munroe](https://xkcd.com/645/). Alt text: By the third trimester, there will be thousands of babies inside you.</p>
</div>


::: { .example name="Generalizability"}
Replication studies done in university often draw participants from students enrolled in the institutions. The findings are thus not necessarily robust if extrapolated to the whole population if there are characteristics for which they have strong (familiarity to technology, acquaintance with administrative system, political views, etc). These samples are often **convenience samples**.
:::


::: { .example name="Spratt-Archer barley in Ireland"}
Example 1.9 in @Cox:1958 mentions recollections of ``Student'' on Spratt-Archer barley, a new variety of barley that performed well in experiments and which the Irish Department of Agriculture encouraged to have introduced elsewhere. Fuelled by a district skepticism with the new variety, the Department ran an experiment comparing the yield of the Spratt-Archer barley with that of the native race. Their findings surprised the experimenters: the native barley grew more quickly and was more resistant to weeds, leading to higher yields. It was concluded that the initial experiments were misleading because Spratt-Archer barley was experimented in well-farmed areas. 
:::

### Simplicity

The fourth requirement is one of simplicity of design, which almost invariably leads to simplicity of the statistical analysis. Randomized control-trials are often viewed as the golden rule for determining efficacy of policies or treatments because the set of assumptions they make is pretty minimalist due to randomization. Most  researchers in management are not necessarily comfortable with advanced statistical techniques and this also minimizes the burden. \@ref(fig:xkcd2400) shows an [hypothetical graph](https://www.zq1.de/~bernhard/images/share/mRNA-1273-trial.png) on the efficacy of the Moderna MRNA vaccine for Covid: if the difference is clearly visible in a suitable experimental setting, then conclusions are easily drawn.


Randomization justifies the use of the statistical tools we will use under very weak assumptions, if units measurements are independent from one another. Drawing conclusions from observational studies, in contrast to experimental designs requires making often unrealistic or unverifiable assumptions and the choice of techniques required to handle the lack of randomness is often beyond the toolbox of applied researchers.

<div class="figure" style="text-align: center">
<img src="figures/xkcd2400_statistics.png" alt="xkcd comic [2400 (Statistics) by Randall Munroe](https://xkcd.com/2400/). Alt text: We reject the null hypothesis based on the 'hot damn, check out this chart' test." width="40%" />
<p class="caption">(\#fig:xkcd2400)xkcd comic [2400 (Statistics) by Randall Munroe](https://xkcd.com/2400/). Alt text: We reject the null hypothesis based on the 'hot damn, check out this chart' test.</p>
</div>



::: yourturn

- Define the following terms in your own word: experimental unit, factor, effect size
- What is the main benefit of experimental studies over observational studies?
- List the four pillars of experimental design and briefly describe them.

:::