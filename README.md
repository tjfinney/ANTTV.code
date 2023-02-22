
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ANTTV

<!-- badges: start -->
<!-- badges: end -->

ANTTV is a package of *R* programs for analysing data on New Testament
textual variation. [How to discover textual
groups](https://www.tfinney.net/Groups/index.xhtml) provides an
introduction to the techniques involved.

To get started:

1.  Install *R* on your computer
2.  \[Optional\] To make life far easier, install RStudio on your
    computer
3.  Install the ANTTV package
4.  Use the programs in the package to analyse the data.

## Installation

You can install the development version of ANTTV from
[GitHub](https://github.com/) with:

``` r
install.packages("devtools")
devtools::install_github("tjfinney/ANTTV")
```

Installing the *ape* and *rgl* packages can be challenging as additional
software may need to be installed on your operating system. Details will
vary according to your platform (whether Linux, Mac, or Windows).
Looking at the package documentation is a good place to start:

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

Numerous other New Testament data sets are available from the [Zenodo
repository](https://zenodo.org/). (Try searching for *Finney, Tim* to
find them.) Some are data matrices (showing textual states of witnesses)
and others are distance matrices (showing distances between pairs of
witnesses calculated with the simple matching distance).

## Function chains

Analysis is performed by stringing together a chain of functions using
the `|>` pipe operator:

    ## input data frame, do data reduction, do distance matrix, do neighbour-joining analysis
    Mark.UBS4 |> do_reduction() |> do_dist() |> do_NJ()

or, to obtain the same result from the same data stored at the Zenodo
repository,

    read_data_frame("https://zenodo.org/record/6466262/files/Mark.UBS4.csv") |> do_reduction() |> do_dist() |> do_NJ()

To analyse a distance matrix,

    Acts.UBS2.dist |> do_NJ()

or, using the same distance matrix from the repository,

    read_dist_matrix("https://zenodo.org/record/6505843/files/Acts.UBS2.dist.csv") |> do_NJ()

Different types of analysis results are obtained by varying the final
step. E.g.

    Mark.UBS4 |> do_reduction() |> do_dist() |> do_CMDS()

or

    Mark.UBS4 |> do_reduction() |> do_dist() |> do_DC()

or

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

## Saving results

Analysis results from `do_CMDS()`, `do_DC()`, `do_NJ()`, or `do_PAM()`
can be saved by setting the *write* flag to `TRUE` and specifying an
output file:

    Mark.UBS4 |> do_reduction(keep="Origen") |> do_dist() |> do_PAM(fn="../PAM/Mark.UBS4.Origin.txt", write=TRUE)

(In PAM analysis, *ASW* is the *average silhouette width*, also known as
the *mean silhouette width*, *MSW*. Peaks in *ASW* versus number of
groups indicate better groupings.)

A distance matrix can be saved by concluding the function chain with
`write.csv()` and specifying an output file:

    Mark.UBS4 |> do_reduction(keep="Origen") |> do_dist() |> write.csv("../Dist/Mark.UBS4.Origin.dist.csv")
