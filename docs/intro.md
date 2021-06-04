# Motivation {#motivation}

In most applied domains, empirical evidences drive the advancement of the field and hypothesis testing is ubiquitous in research. In order to draw conclusions in favour or against a theory, researchers turn (often unwillingly) to statistics to back up their claims. This has led to the prevalence of the use of the null hypothesis statistical testing (NHST) framework and the prevalence of $p$-values in journal articles, despite the fact that falsification of a null hypothesis is not enough to provide substantive findings for a theory.

Because introductory statistics course often present standardized testing procedures as recipes to be blindly followed, without giving much thoughts to the underlying construction principles, users often have a reductive view of statistics as a catalogue of pre-determined procedures. To make a culinary analogy, users focus on learning recipes rather than trying to understand the basics of cookery.

Richard McElreath in the [first chapter](http://xcelab.net/rmpubs/sr2/statisticalrethinking2_chapters1and2.pdf) of his book [@McElreath:2020] draws a parallel between statistical tests and golems (i.e., robots): a robot

> doesn't discern when the context is inapropriate for its answers. It just knows its own procedure [...] It just does as it's told.

## Models

The starting point of statistical inference is modelling, a process by which researchers construct idealized and simplified mathematical representations of a phenomenon. David R. Cox provides some insight on this construction [@Chatfield:1995]:

  > The very word model implies simplification and idealization. The idea that complex physical, biological or sociological systems can be exactly described by a few formulae is patently absurd. The construction of idealized representations that **capture important stable aspects of such systems** is, however, a vital part of general scientific analysis and statistical models, especially substantive ones, do not seem essentially different from other kinds of model.


It is important to remain aware of the limitations of the tools we will cover: most common research questions cannot be answered by them, and we do not make any claim about the widespread applicability.  Researchers wishing to adventure beyond the range of what we cover here and perform innovative research should contact experts and consult with statisticians **before** data collection to better inform on how best to proceed for what they have in mind so as to avoid the risk of making misleading and false claims based on incorrect analysis or data collection.



## Reproducibility crisis {#reproducibility-crisis}

Plainly stated, most research findings are wrong. There is a range of reasons for this.

How can reproducible research enhance your work? For one thing, this workflow facilitates the publication of negative research, forces researchers to think ahead of time (and receive feedback). Reproducible research and data availability also leads to additional citations and increased credibility as a scientist.

Among the good practices I recommend you adopt,

- version control systems (e.g., Git) that track changes to files and records.
- archival of raw data in a proper format and with accompanying documentation.
- pre-registration of experiments and use of logbook.

<div class="figure" style="text-align: center">
<img src="figures/reproducibility.png" alt="Tweet showing widespread problems related to unintentional changes to data because of the use of software." width="85%" />
<p class="caption">(\#fig:reprotweetexcelgenes)Tweet showing widespread problems related to unintentional changes to data because of the use of software.</p>
</div>

The benefits of this workflow may not seem obvious at first glance, so let me expand.

Version control keeps records of changes to your file and can help you retrieve former versions if you make mistakes at some point.
Archival of data helps to avoid unintentional and irreversible manipulations of the original data, examples of which can have large scale consequences as illustrated in Figure \@ref(fig:reprotweetexcelgenes) [@Ziemann:2016]. Sometimes, sensible data cannot be shared "as is" because of confidentiality issues, but whenever possible should be made available with a licence and a DOI to allow people to reuse and cite and credit your work.

Much like in a chemistry lab, keeping a logbook and documenting your progress helps your collaborators, reviewers and your future self understand and understand decisions which may seem unclear and arbitrary in the future, even if they were the result of a careful thought process at the time you made them.

Given the pervasiveness of the garden of forking paths, pre-registration helps you prevents harking and increases the credibility of your work because it enhances **reproducibility**, guaranteeing that an external person with the same data and enough indications about the procedure (for example, by providing the code and indications about software versions, etc.) can obtain consistent results that match those of your paper. Pre-registration doesn't mean that you must stick with the plan exactly, merely requiring people to explain what did not go as planned.

Operating in an open-science environment should be seen as an opportunity to make better science, offer more opportunities to increase your impact and increase the publication of work regardless of whether the results turn out to be negative. Selective reporting is a plague because .

@Barnett:2019 study the selective reporting of confidence intervals, which are sometimes advocated in place of $p$-values even if they result in similar decisions. They used data mining techniques to extract confidence intervals from abstracts of nearly one million publication in Medline. These can be transformed into a a $z$-score @vanZwet:2021, which should be normally distributed if there was no evidence of selective reported \ref().

and embraced because it is the right thing to do and it increases the quality of research produced, with collateral benefits because it forces researchers to validate their methodology before, to double-check their data and their analysis and to adopt good practice.

A related scientific matter is that of **replicability**, which is the process by which new data are collected to test the same hypothesis, potentially using different methodology.



## Planning of experiments  {#planning-experiments}

We outline the various steps a research must undertake in an experimental setting, along with flags to indicate crucual ones.
