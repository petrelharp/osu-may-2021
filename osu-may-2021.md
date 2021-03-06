---
title: "Pushing the boundaries of population genomic computation with the tree sequence"
author: "Peter Ralph"
date: "Center for Genome Research and Biocomputing <br/> Oregon State // 26 May 2021"
---


# Outline

## Outline of the talk

1. What do we need simulations for?
2. The tree sequence
3. Applications


*slides:* [github.com/petrelharp/osu-may-2021](https://petrelharp.github.io/osu-may-2021/osu-may-2021.slides.html)


# Simulation-based inference

## Some questions

1. What forces contribute to the variation in genetic diversity
    along the genome? *(explaining variation in diversity)*

2. Which locations along the genome have been the recent targets
    of positive natural selection? *(identifying sweeps)*

3. Where did this individual come from?
    *(inferring location)*

4. How do organisms disperse across the landscape? *(dispersal maps)*


## Inverse problems

![](figs/modeling_reality.png)

## Inverse problems

![](figs/modeling_model_parameters.png)

## Inverse problems

![](figs/modeling_model_parameters_inverse.png)

## Inverse problems

![](figs/modeling_parameters_inverse_computer.png)

## Simulation-based inference

::: {.centered}
![](figs/modeling_parameters_inverse_computer.png){width=60%}
:::


- bespoke confirmatory simulations
- optimization of one or two parameters
    <!-- *(if between-simulation noise is small)* -->
- machine learning predictors (e.g., random forests)
- Approximate Bayesian Computation (ABC)
- deep learning


# What do we need

<!--
## Ok, then: selection.

:::: {.columns}
:::::::: {.column width=50%}


To test theories and fit models, we need *simulations* with realistic

1. population sizes,
2. ecology,
2. genomes,
3. selective pressures,
4. histories, and
5. geography.


::::
:::::::: {.column width=50%}

![map of mimulus](figs/aurantiacus/just_map.png)

::::
::::::::

-->

## Wish list:

::: {.smallish}

::: {.columns}
::::::: {.column}

Whole genomes,
thousands of samples, \
from millions of individuals.

**Demography:**

- life history 
- separate sexes
- selfing
- polyploidy
- species interactions

**Geography:**

- discrete populations
- continuous landscapes
- barriers

**History:**

- ancient samples
- range shifts

:::
::::::: {.column}

**Natural selection:**

- selective sweeps
- introgressing alleles
- background selection
- quantitative traits
- incompatibilities
- local adaptation

**Genomes:**

- recombination rate variation
- gene conversion
- infinite-sites mutation
- nucleotide models
- context-dependence
- mobile elements
- inversions
- copy number variation

:::
:::::::

:::



## {data-background-image="figs/oregon_geological_map.png"}

## Enter SLiM


::: {.columns}
::::::: {.column width=50%}


by Ben Haller and Philipp Messer

- a forwards simulator
- arbitary life cycles
- continuous geography and local interactions
- quantitative traits
- anything is possible

:::: {.caption}
![Ben Haller](figs/ben-haller.jpg)
*Ben Haller*
::::

:::
::::::: {.column width=50%}

![SLiM GUI](figs/slim-gui.png)

[messerlab.org/SLiM](https://messerlab.org/SLiM/)

:::
:::::::



## {data-background-image="figs/slim_screenshot.png" data-background-position=center data-background-size=100%}

##

::: {.smallish}

::: {.columns}
::::::: {.column}

- <s>Whole genomes,</s>*
- <s>thousands of samples, </s>
- <s>from millions of individuals.</s>*

**Demography:**

- <s>life history</s>
- <s>separate sexes</s>*
- <s>selfing</s>
- polyploidy*
- species interactions **(coming soon!)**

**Geography:**

- <s>discrete populations</s>
- <s>continuous landscapes</s>
- <s>barriers</s>*

**History:**

- <s>ancient samples</s>
- <s>range shifts</s>

:::
::::::: {.column}

**Natural selection:**

- <s>selective sweeps</s>
- <s>introgressing alleles</s>
- <s>background selection</s>
- <s>quantitative traits</s>*
- <s>incompatibilities</s>*
- <s>local adaptation</s>*

**Genomes:**

- <s>recombination rate variation</s>
- <s>gene conversion</s>
- <s>infinite-sites mutation</s>
- <s>nucleotide models</s>
- <s>context-dependence</s>*
- mobile elements*
- inversions*
- copy number variation

:::
:::::::

:::

## 

- <s>Whole genomes,</s>*

. . .

Idea: if we record *how everyone is related to everyone else*,

. . .

we can put down neutral mutations
*after the simulation is over*
instead of carrying them along.

. . .

Since neutral mutations don't affect demography,

this is *equivalent* to having kept track of them throughout.



<!-- Tree sequences -->

# The tree sequence


## History is a sequence of trees

For a set of sampled chromosomes,
at each position along the genome there is a genealogical tree
that says how they are related.

. . .

![Trees along a chromosome](figs/example.svg)


----------------------

The **succinct tree sequence**

::: {.floatright}
is a way to succinctly describe this, er, sequence of trees

*and* the resulting genome sequences.

:::: {.caption}
[Kelleher, Etheridge, & McVean](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004842) 
::::
:::

. . .

::: {.columns}
:::::: {.column width=50%}

![tskit logo](figs/tskit_logo.png){width=80%}

:::
:::::: {.column width=50%}

::: {.floatright}
![jerome kelleher](figs/jerome.jpeg){width=50%}

:::: {.caption}
jerome kelleher
::::

:::

:::
::::::



## Example: three samples; two trees; two variant sites

![Example tree sequence](figs/example_tree_sequence.png)


## Nodes and edges

Edges 

:   Who inherits from who.

    Records: interval (left, right); parent node; child node.

Nodes 

:   The ancestors those happen in.

    Records: time ago (of birth); ID (implicit).

-------------------

![Building a tree sequence](nodes_edges_walkthrough/nodes_edges_walkthrough.0.png)

-------------------


![Building a tree sequence](nodes_edges_walkthrough/nodes_edges_walkthrough.1.png)

-------------------


![Building a tree sequence](nodes_edges_walkthrough/nodes_edges_walkthrough.2.png)

-------------------


![Building a tree sequence](nodes_edges_walkthrough/nodes_edges_walkthrough.3.png)

-------------------


![Building a tree sequence](nodes_edges_walkthrough/nodes_edges_walkthrough.4.png)

-------------------


![Building a tree sequence](nodes_edges_walkthrough/nodes_edges_walkthrough.5.png)

-------------------

![Building a tree sequence](nodes_edges_walkthrough/nodes_edges_walkthrough.6.png)


## Sites and mutations

Mutations

:   When state changes along the tree.

    Records: site it occured at; node it occurred in; derived state.

Sites 

:   Where mutations fall on the genome.

    Records: genomic position; ancestral (root) state; ID (implicit).


------------------

![Adding mutations](sites_muts_walkthrough/sites_muts_walkthrough.0.png)

------------------

![Adding mutations](sites_muts_walkthrough/sites_muts_walkthrough.1.png)

------------------

![Adding mutations](sites_muts_walkthrough/sites_muts_walkthrough.2.png)

------------------

![Adding mutations](sites_muts_walkthrough/sites_muts_walkthrough.3.png)

------------------

![Adding mutations](sites_muts_walkthrough/sites_muts_walkthrough.4.png)

------------------

**The result:**
an encoding of the genomes *and* all the genealogical trees.

::: {.centered}
![Example tree sequence](figs/example_tree_sequence.png)
:::


# How's it work?


## File sizes

::: {.centered}
![file sizes](figs/tsinfer_sizes.png){width=90%}
:::

::: {.caption}
100Mb chromosomes;
from [Kelleher et al 2018, *Inferring whole-genome histories in large population datasets*](https://www.nature.com/articles/s41588-019-0483-y), Nature Genetics
:::

<!-- Estimated sizes of files required to store the genetic variation data for a
simulated human-like chromosome (100 megabases) for up to 10 billion haploid
(5 billion diploid) samples. Simulations were run for 10 1 up to 10 7 haplotypes
using msprime [Kelleher et al., 2016], and the sizes of the resulting files plotted
(points). -->


---------------

![genotypes](figs/ts_ex/tree_sequence_genotypes.png)

---------------

![genotypes and a tree](figs/ts_ex/tree_sequence_genotype_and_tree.png)

---------------

![genotypes and the next tree](figs/ts_ex/tree_sequence_next_genotype_and_tree.png)



## For $N$ samples genotyped at $M$ sites

::: {.columns}
::::::: {.column width=50%}


*Genotype matrix*:

$N \times M$ things.


:::
::::::: {.column width=50%}

*Tree sequence:*

- $2N-2$ edges for the first tree
- $\sim 4$ edges per each of $T$ trees
- $M$ mutations

$O(N + T + M)$ things

:::
:::::::

![genotypes and a tree](figs/ts_ex/tree_sequence_genotype_and_tree.png){width=60%}

## Fast genotype statistics, too!

::: {.centered}
![efficiency of treestat computation](figs/treestats/benchmarks_without_copy_longer_genome.png){width=70%}
:::

::: {.caption}
from Ralph, Thornton and Kelleher 2019, [Efficiently summarizing relationships in large samples](https://doi.org/10.1534/genetics.120.303253)
:::


# Application to genomic simulations

## The main idea

If we *record the tree sequence*
that relates everyone to everyone else,

after the simulation is over we can put neutral mutations down on the trees.

. . .

Since neutral mutations don't affect demography,

this is *equivalent* to having kept track of them throughout.

. . .

:::: {.columns}
:::::::: {.column width=50%}

:::: {.caption}
From 
Kelleher, Thornton, Ashander, and Ralph 2018,
[Efficient pedigree recording for fast population genetics simulation](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1006581).

and Haller, Galloway, Kelleher, Messer, and Ralph 2018,
[*Tree???sequence recording in SLiM opens new horizons for forward???time simulation of whole genomes*](https://onlinelibrary.wiley.com/doi/abs/10.1111/1755-0998.12968)
:::

::::
:::::::: {.column width=50%}

::: {.floatright}
![jared galloway](figs/jared.jpeg){width=35%}
![jaime ashander](figs/jaime.jpg){width=30%}
![ben haller](figs/ben-haller.jpg){width=30%}
:::

::::
::::::::

------------

This means recording the entire genetic history of **everyone** in the population, **ever**.

.  . .

It is *not* clear this is a good idea.

. . .

But, with a few tricks...



## A 100x speedup!

::: {.columns}
:::::: {.column width=40%}

::: {.centered}
![SLiM logo](figs/slim_logo.png){width=100%}
:::

:::
:::::: {.column width=60%}

::: {.floatright}
![](figs/slim_timing_no_msprime.png){width=100%}
:::

:::
::::::


## What else can you do with tree sequences?

> - recorded pedigree and migration history
> - true ancestry assignment
> - *recapitation*: fast, post-hoc initialization with coalescent simulation 
> - fast, convenient computation


---------------------

**For example:**

- genome as human chr7 ($1.54 \times 10^8$bp)
- $\approx$ 10,000 diploids
- 500,000 overlapping generations
- continuous, square habitat
- selected mutations at rate $10^{-10}$
- neutral mutations added afterwards

*Runtime:* 8 hours


# Example 1: landscapes of diversity

![Langley et al 2012](figs/from_the_literature/langley-et-al-2012-chr3-pi-and-rho.png)


## Diversity correlates with recombination rate

:::: {.columns}
:::::::: {.column width=80%}


![Corbett-Detig et al](figs/from_the_literature/corbett-detig-divergence-recomb-all-species.png){width=85%}

::::
:::::::: {.column width=20%}


*Hudson 1994; Cutter & Payseur 2013; Corbett-Detig et al 2015*

::::
::::::::

## The *Mimulus aurantiacus* species complex

::: {.centered}
![](figs/aurantiacus/phylogeny.png)
:::

---------------------

:::: {.columns}
:::::::: {.column width=80%}

![](figs/aurantiacus/rising_landscapes/divergence_by_node_aura_LG3.png)

::::
:::::::: {.column width=20%}

![](figs/aurantiacus/labeled_phylogeny_aura.png){width="250%"}

::::
::::::::


## Simulations

::: {.columns}
::::::: {.column width="70%"}

- $N=10,000$ diploids
- burn-in for $10N$ generations
- population split, with either:
    
    * neutral
    * background selection
    * selection against introgressed alleles
    * positive selection
    * local adaptation

:::
::::::: {.column width="30%"}

:::: {.flushright}
![](figs/murillo.jpeg)

::::: {.caption}
Murillo Rodrigues
:::::
::::

:::
:::::::


------------------

<!--
Fig 7. Genomic landscapes simulated under different divergence histories.
Each row of plots shows patterns of within- and between-population variation (??, dxy, and FST) across the chromosome (500-kb windows) at 5 time points (N generations, where N = 10,000) during one of the scenarios The selection parameter (Ns, where s = Ns/N), proportion of deleterious (???) and positive mutations (+), and number of migrants per generation (Nm; 0 unless stated) for these simulations are as follows: (i) neutral divergence (no selection), (ii) BGS (???Ns = 100; ???prop = 0.1), (iii) BDMI (???Ns = 100, ???prop = 0.05, Nm = 0.1), (iv) positive selection (+Ns = 100, +prop = 0.001), (v) BGS and positive selection (???Ns = 100, ???prop = 0.1; +Ns = 100, +prop = 0.005), and (vi) local adaptation (+Ns = 100, +prop = 0.001, Nm = 0.1). The gray boxes in the first column show the areas of the chromosome that are experiencing selection, while the white central area evolves neutrally. Note that ?? (in populations a and b) and dxy have been mean centered so they can be viewed on the same scale. Uncentered values and additional simulations with different parameter combinations and more time points can be found in S13 Fig. BDMI, Bateson-Dobzhansky-Muller incompatibility; BGS, background selection.

![](figs/aurantiacus/sim_results.png)
-->

![](figs/sim_mimulus_landscapes.svg){width=100%}

::::: {.flushright}

::::::::::: {.caption}
From [Widespread selection and gene flow shape the genomic landscape during a radiation of monkeyflowers](https://doi.org/10.1371/journal.pbio.3000391),
Stankowski, Chase, Fuiten, Rodrigues, Ralph, and Streisfeld;
PLoS Bio 2019.
:::::::::::
:::::

------------

Conclusions:

* <strike>neutral</strike>
* <strike>background selection</strike>
* <strike>selection against introgressed alleles</strike>
* positive selection
* local adaptation

::::: {.flushright}

::::::::::: {.caption}
From [Widespread selection and gene flow shape the genomic landscape during a radiation of monkeyflowers](https://doi.org/10.1371/journal.pbio.3000391),
Stankowski, Chase, Fuiten, Rodrigues, Ralph, and Streisfeld;
PLoS Bio 2019.
:::::::::::
:::::



# Example 2: identifying sweeps


![https://academic.oup.com/g3journal/article/8/6/1959/6028059](figs/shic_images.png)

-----------

![https://academic.oup.com/g3journal/article/8/6/1959/6028059](figs/shic_cnn.png)


# Example 3: predicting location

![](figs/spatial_pedigree.png)

::::: {.caption}
from [Bradburd & Ralph 2019](https://arxiv.org/abs/1904.09847)
:::::

## 

::: {.centered}
![](figs/locator_methods.png)

[![](figs/locator_paper.png){width=50%}](https://elifesciences.org/articles/54507)
![](figs/cjb.jpg){width=20%}
:::

## locator ([Battey et al 2020](https://elifesciences.org/articles/54507))

![](figs/locator_results.png)

## 

![](figs/locator_spatial_tree_sequence.png)

:::: {.flushright}
::::: {.caption}
from [Battey et al 2020](https://elifesciences.org/articles/54507)
:::::
::::

# Example 4: dispersal maps


<!--
![trees in space, by CJ Battey](figs/spacetree_1.png)

::: {.caption}
by [CJ Battey](cjbattey.com)
:::
-->

-------------

![genetic and geographic distance for desert tortoises](figs/everyone-ibd.png)

- genetic versus geographic distance between pairs of 272 desert tortoises (McCartney-Melstad, Shaffer)
- clouds are comparisons within/between the two colors

-----------

![](figs/range-abundance-map.jpeg)

-----------

![](figs/drecp-pref-alt-snapshot.png)



# Wrap-up


## Software development goals

::: {.columns}
:::::: {.column width=50%}

- open
- welcoming and supportive
- reproducible and well-tested
- backwards compatible
- well-documented
- capacity building

<!--
::: {.centered}
![popsim logo](figs/popsim.png){width=50%}
:::
-->

:::
:::::: {.column width=50%}


::: {.centered}
![tskit logo](figs/tskit_logo.png){width=60%}

[tskit.dev](https://tskit.dev)

<!-- ![SLiM logo](figs/slim_logo.png){width=80%} -->
:::

:::
::::::


## Thanks!

:::: {.columns}
:::::::: {.column width=50%}


- Andy Kern
- Matt Lukac
- Murillo Rodrigues 
- Victoria Caudill
- Anastasia Teterina
- Jeff Adrion
<!--
- Saurabh Belsare
- Chris Smith
- Gilia Patterson
- Gabby Coffing
-->
- CJ Battey
- Jared Galloway
- the rest of the Co-Lab

Funding:

- NIH NIGMS
- NSF DBI
- Sloan foundation
- UO Data Science

::::
:::::::: {.column width=50%}

<div style="font-size: 85%; margin-top: -40px;">


- Jerome Kelleher
- Ben Haller
- Ben Jeffery
- Georgia Tsambos
- Jaime Ashander
- Gideon Bradburd
- Madeline Chase
- Bill Cresko
- Alison Etheridge
- Evan McCartney-Melstad
- Brad Shaffer
- Sean Stankowski
- Matt Streisfeld

</div>

::: {.floatright}
![tskit logo](figs/tskit_logo.png){width=40%}
![SLiM logo](figs/slim_logo.png){width=40%}
:::

::::
::::::::



## {data-background-image="figs/guillemots_thanks.png" data-background-position=center data-background-size=50%}
