
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->
<!-- badges: end -->

## ANTTV.code

This is one of a set of repositories relating to analysis of New
Testament textual variation:

[ANTTV.book](https://github.com/tjfinney/ANTTV.book)  
A book on analysis of New Testament textual variation.

[ANTTV.code](https://github.com/tjfinney/ANTTV.code)  
Computer programs written in *R* (*a free software environment for
statistical computing and graphics*) to analyse data relating to New
Testament Textual variation.

[ANTTV.data](https://github.com/tjfinney/ANTTV.data)  
Data relating to New Testament textual variation.

[How to discover textual
groups](https://www.digitalstudies.org/article/id/7324/) provides an
introduction to the analysis techniques.

## Getting started

1.  Install
    [R](https://cran.r-project.org/doc/FAQ/R-FAQ.html#How-can-R-be-installed_003f)
    on your computer
2.  \[Optional\] To make life far easier, install the [RStudio
    IDE](https://posit.co/download/rstudio-desktop/) on your computer
3.  Install the `ANTTV.code` package
4.  Use the programs in the package to analyse the data.

## Installation

Once *R* is installed, you can install the *ANTTV.code* package from
[GitHub](https://github.com/) by entering the following commands at the
*R* prompt:

``` r
install.packages("devtools")
devtools::install_github("tjfinney/ANTTV.code")
```

## Nomenclature

A data matrix specifies the textual state of each witness
(e.g. manuscript, lectionary, version, Church Father) at a series of
variation sites (i.e. places where the texts differ). Each data matrix
has a row for each witness and a column for each variation site. Cells
of the matrix contain symbols (typically numerals) that represent the
textual states of the witnesses at the variation sites. If the state of
a witness is not known at a particular site then the symbol `NA` is
entered to indicate that this datum is *not available*.

A distance matrix records the *simple matching distance* (SMD) between
each possible pairing of witnesses in a data matrix. Given two witnesses
whose textual states are known at a series of variation sites, the SMD
is the number of sites at which their states differ divided by the
number of variation sites compared. A pairing of witnesses is not
compared at sites where the textual state of either witness is not
known, as indicated by the symbol `NA`. The SMD ranges from a minimum of
zero to a maximum of one: 0 represents perfect agreement (all compared
textual states are the same) and 1 represents perfect disagreement (all
compared textual states differ). The distance matrix is square, with a
column and row for each witness. If rows and columns have the same
ordering then the diagonal is comprised entirely of zeroes because each
witness is a distance of zero from itself.

## Data sets

Built-in data sets include:

Mark.UBS4  
A data matrix comprised of 267 rows of observations (i.e. witnesses
listed in the apparatus of Mark’s Gospel in the 4th ed. of the UBS
*Greek New Testament*) and 142 variables (i.e. variation sites listed in
the same apparatus) compiled by Richard Mallett.

Acts.UBS2.dist  
A distance matrix constructed from tables of percentage agreement that
were compiled from the apparatus of the second edition of the UBS *Greek
New Testament* by Maurice A. Robinson.

Numerous other New Testament data sets are available from these Zenodo
repositories:

- [Data matrices](https://zenodo.org/record/4064629)
- [Distance matrices](https://zenodo.org/record/4064631)

## Analysis methods

Details of the different analysis types (CMDS = classical
multidimensional scaling, DC = divisive clustering, NJ =
neighbour-joining, PAM = partitioning around medoids) can be found in
the references.

In NJ analysis, bootstrap sampling of an input data matrix can be used
to include support values or obtain a majority-rule tree. Due to the
random nature of the sampling process, results are liable to change
every time a bootstrap program is executed.

In PAM analysis, *ASW* is the *average silhouette width*, also known as
the *mean silhouette width*, *MSW*. Peaks in *ASW* versus number of
groups indicate better groupings.

## Functions

`read_data_frame()`  
Read a data matrix from a comma-separated vector (CSV) file. (A data
frame is the R data structure used to store a data matrix.)

`read_data_frame_CBGM()`  
Read a CBGM (Coherence-based Genealogical Method) data file and convert
it to a data frame suitable for further analysis using the programs in
this package.

`read_dist_matrix()`  
Read a distance matrix from a comma-separated vector (CSV) file.

`do_reduction()`  
Drop witnesses from a data matrix until the number of variation sites
that can be compared reaches a minimum tolerable number for each
possible pairing of witnesses. This function is used to prevent
accidental agreements skewing analysis results. The default value of the
minimum tolerable number is fifteen. Using smaller values increases the
statistical uncertainties associated with calculated distances. (The
chance of the calculated distance being a poor indication of the actual
value increases as the number of variation sites compared decreases.)

`do_dist()`  
Calculate the distance between each possible pairing of witnesses in a
data matrix.

`do_CMDS()`  
Perform classical multi-dimensional scaling on a distance matrix.

`do_DC()`  
Perform divisive clustering on a distance matrix.

`do_NJ()`  
Perform neighbour-joining on a distance matrix.

`do_NJ_consensus()`  
Use bootstrap sampling of a data matrix to obtain the majority-rule
consensus neighbour-joining tree. (This uses do_reduction() with its
default settings to reduce missing data in the input data matrix.)

`do_NJ_support()`  
Use bootstrap sampling of a data matrix to obtain support values for the
neighbour-joining tree. (This uses do_reduction() with its default
settings to reduce missing data in the input data matrix.)

`do_PAM()`  
Perform partitioning around medoids on a distance matrix.

`do_rank()`  
For each witness, rank other witnesses by distance. (This uses
do_reduction() with its default settings to reduce missing data in the
input data matrix.) Distances that are not expected to happen by chance
are marked by an asterisk (“\*“).

`do_segments_by_column()`  
Divide a data frame into a number of data frames, each containing
consecutive sets of columns from the input data frame. This function
does not produce an output, instead writing output data frames as a side
effect.

## Function chains

The pipe operator (`|>`) is used to make the output of one step be the
input of the next step. A chain of functions can be strung together to
produce analysis results:

    ## load ANTTV.code package
    library(ANTTV.code)
    ## input data frame, do data reduction, do distance matrix, do neighbour-joining analysis
    Mark.UBS4 |> do_reduction() |> do_dist() |> do_NJ()

To obtain the same result from the same data stored at a Zenodo
repository:

    read_data_frame("https://zenodo.org/record/6466262/files/Mark.UBS4.csv") |> do_reduction() |> do_dist() |> do_NJ()

To analyse a distance matrix:

    Acts.UBS2.dist |> do_NJ()

To analyse the same distance matrix from a repository:

    read_dist_matrix("https://zenodo.org/record/6505843/files/Acts.UBS2.dist.csv") |> do_NJ()

Different types of analysis results are obtained by varying the final
step:

    Mark.UBS4 |> do_reduction() |> do_dist() |> do_CMDS()

    Mark.UBS4 |> do_reduction() |> do_dist() |> do_DC()

    Mark.UBS4 |> do_reduction() |> do_dist() |> do_NJ()

    Mark.UBS4 |> do_reduction() |> do_dist() |> do_PAM()

## Functions that incorporate do_reduction()

For various reasons, certain functions (`do_NJ_support()`,
`do_NJ_consensus()`, `do_rank()`) need to operate directly on a data
matrix rather than a distance matrix. These functions incorporate
`do_reduction()` as part of their internal processing chain. (It doesn’t
matter if `do_reduction()` has already been applied to the input.)

To include NJ support values or obtain a majority-rule consensus tree:

    Mark.UBS4 |> do_NJ_support()

    Mark.UBS4 |> do_NJ_consensus()

To produce ranked distances from each witness:

    Mark.UBS4 |> do_rank()

## Keeping a particular witness

Specifying a witness to keep will prevent it being dropped by
`do_reduction()` provided that the states of the specified witness are
known at a sufficient number of variation sites:

    Mark.UBS4 |> do_reduction(keep="Origen") |> do_dist() |> do_NJ()

    Mark.UBS4 |> do_reduction(keep="P45") |> do_dist() |> do_NJ()

The minimum number of variation sites required to calculate a distance
can be varied from the default value of 15:

    Mark.UBS4 |> do_reduction(n=6, keep="P88") |> do_dist() |> do_NJ()

Please be aware that reducing the minimum number also reduces the
reliability of the analysis results.

To obtain numbers of variation sites at which the states of witnesses in
a data matrix are known:

    rowSums(!is.na(read_data_frame("https://zenodo.org/record/6466262/files/Mark.UBS4.csv")))

## Dropping particular witnesses

Witnesses can be dropped by inserting a filter into the pipeline:

``` r
Mark.UBS4 |> (\(d) (d[(!row.names(d) %in% c("UBS", "Byz", "2427")),]))() |> do_rank()
```

## Column-wise data frame subsets

`do_segments_by_column()` writes a number of column-wise subsets of a
data frame to a corresponding number of output files as a side effect.
(The function has no output so cannot be used in a function chain.) As
an example, the following will produce four output files
(“data/Mark.UBS4.a.csv”, “data/Mark.UBS4.b.csv”, “data/Mark.UBS4.b.csv”,
“data/Mark.UBS4.b.csv”). The file path (`data/` in this example) is
relative to the current working directory.

``` r
Mark.UBS4 |> do_segments_by_column(write = TRUE, n = 4, fn = "data/Mark.UBS4")
```

The resulting files can then be processed in the usual way:

    read_data_frame("data/Mark.UBS4.a.csv") |> do_reduction() |> do_dist() |> do_NJ()

## Saving results

Results from `do_CMDS()`, `do_DC()`, `do_NJ()`, `do_NJ_consensus()`,
`do_NJ_support()`, or `do_PAM()` can be saved by setting the *write*
flag to `TRUE` and specifying an output file:

    Mark.UBS4 |> do_reduction(keep="Origen") |> do_dist() |> do_PAM(fn="output/PAM/Mark.UBS4.Origin.txt", write=TRUE)

A distance matrix can be saved by concluding the function chain with
`write.csv()` and specifying an output file:

    Mark.UBS4 |> do_reduction(keep="Origen") |> do_dist() |> write.csv("dist/Mark.UBS4.Origin.dist.csv")

## Troubleshooting

Installing the required *ape* and *rgl* packages can be challenging as
additional software may need to be installed on your operating system.
Details will vary according to your platform (whether Linux, Mac, or
Windows). Looking at the package documentation is a good place to start:

- <http://ape-package.ird.fr/ape_installation.html>
- <https://dmurdoch.github.io/rgl/>

The following notes (specific to Ubuntu Linux) might help too.

### Install ape package

If you hit errors like
`/usr/bin/ld: cannot find -llapack: No such file or directory` then try
installing `gfortran`, `blas`, and `lapack` with
`sudo apt install gfortran libblas-dev liblapack-dev`.

### Install software for do_CMDS()

`do_CMDS()` didn’t work with the default `rgl` installation. The
following steps were required to get it working:

1.  Install OpenGL support (on Linux):
    `sudo apt install libgl1-mesa-dev libglu1-mesa-dev`
2.  Install dev version of `rgl` package in RStudio:
    `remotes::install_github("dmurdoch/rgl")`
3.  Install Magick++ (on Linux): `sudo apt install libmagick++-dev`
4.  Install `magick` package in RStudio: `install.packages("magick")`
5.  Install ImageMagick (on Linux): `sudo apt install imagemagick`

## References

Chatfield, Christopher and Alexander J. Collins. 1980. *Introduction to
Multivariate Analysis.* London: Chapman and Hall.

Felsenstein, Joseph. 2004. *Inferring Phylogenies.* Sunderland, MA:
Sinauer.

Maechler, Martin, Peter Rousseeuw, Anja Struyf, Mia Hubert, Kurt Hornik.
2023. *cluster: Cluster Analysis Basics and Extensions.* R package
version 2.1.6.

Murdoch, Duncan and Daniel Adler. 2023. *rgl: 3D Visualization Using
OpenGL.* R package version 1.2.8,
<https://CRAN.R-project.org/package=rgl>.

Paradis, Emmanuel. 2012. *Analysis of Phylogenetics and Evolution with
R.* 2nd ed. New York, NY: Springer.

Paradis, Emmanuel and Klaus Schliep. 2019. *ape 5.0: an environment for
modern phylogenetics and evolutionary analyses in R.* *Bioinformatics*
35, 526-528. <doi:10.1093/bioinformatics/bty633>
<https://doi.org/10.1093/bioinformatics/bty633>.

R Core Team. 2023. *R: A Language and Environment for Statistical
Computing.* Vienna: R Foundation for Statistical Computing.
<https://www.R-project.org/>.
