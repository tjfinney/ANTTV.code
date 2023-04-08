
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->
<!-- badges: end -->

## Introduction

*ANTTV.code* is one of a set of repositories relating to analysis of New
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

Once *R* is installed, you can install the development version of
*ANTTV.code* from [GitHub](https://github.com/) by entering the
following commands at the *R* prompt:

``` r
install.packages("devtools")
devtools::install_github("tjfinney/ANTTV.code")
```

## Nomenclature

A data matrix specifies the textual state of each witness
(e.g. manuscript, lectionary, version, Church Father) at a series of
variation sites (i.e. places where the texts differ). Each data matrix
has a row for each witnesses and a column for each variation site. Cells
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
the same apparatus).

Acts.UBS2.dist  
A distance matrix constructed from tables of percentage agreement that
were compiled from the apparatus of the second edition of the UBS *Greek
New Testament* by Maurice A. Robinson.

Numerous other New Testament data sets are available from these Zenodo
repositories:

- [Data matrices](https://zenodo.org/record/4064629)
- [Distance matrices](https://zenodo.org/record/4064631)

## Functions

`read_data_frame()`  
Make a data frame from a comma-separated vector (CSV) file.

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
Perform classical multi-dimensional scaling.

`do_DC()`  
Perform divisive clustering.

`do_NJ()`  
Perform neighbour-joining.

`do_PAM()`  
Perform partitioning around medoids.

## Function chains

Analysis is performed by stringing together a chain of functions using
the pipe operator (`|>`) to make the output of one step be the input of
the next step:

    ## input data frame, do data reduction, do distance matrix, do neighbour-joining analysis
    Mark.UBS4 |> do_reduction() |> do_dist() |> do_NJ()

To obtain the same result from the same data stored at the Zenodo
repository:

    read_data_frame("https://zenodo.org/record/6466262/files/Mark.UBS4.csv") |> do_reduction() |> do_dist() |> do_NJ()

To analyse a distance matrix:

    Acts.UBS2.dist |> do_NJ()

To analyse the same distance matrix from the repository:

    read_dist_matrix("https://zenodo.org/record/6505843/files/Acts.UBS2.dist.csv") |> do_NJ()

Different types of analysis results are obtained by varying the final
step. E.g.

    Mark.UBS4 |> do_reduction() |> do_dist() |> do_CMDS()

    Mark.UBS4 |> do_reduction() |> do_dist() |> do_DC()

    Mark.UBS4 |> do_reduction() |> do_dist() |> do_NJ()

    Mark.UBS4 |> do_reduction() |> do_dist() |> do_PAM()

## Keeping a particular witness

Specifying a witness to keep will prevent it being dropped by
`do_reduction()` provided that the states of the specified witness are
known at a sufficient number of variation sites:

    Mark.UBS4 |> do_reduction(keep="Origen") |> do_dist() |> do_NJ()

or

    Mark.UBS4 |> do_reduction(keep="P45") |> do_dist() |> do_NJ()

The minimum number of variation sites required to calculate a distance
can be varied from the default value of 15:

    Mark.UBS4 |> do_reduction(n=6, keep="P88") |> do_dist() |> do_NJ()

Please be aware that reducing the minimum number also reduces the
reliability of the analysis results.

To obtain numbers of variation sites at which the states of witnesses in
a data matrix are known:

    rowSums(!is.na(read_data_frame("https://zenodo.org/record/6466262/files/Mark.UBS4.csv")))

## Saving results

Analysis results from `do_CMDS()`, `do_DC()`, `do_NJ()`, or `do_PAM()`
can be saved by setting the *write* flag to `TRUE` and specifying an
output file:

    Mark.UBS4 |> do_reduction(keep="Origen") |> do_dist() |> do_PAM(fn="output/PAM/Mark.UBS4.Origin.txt", write=TRUE)

(In PAM analysis, *ASW* is the *average silhouette width*, also known as
the *mean silhouette width*, *MSW*. Peaks in *ASW* versus number of
groups indicate better groupings.)

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
