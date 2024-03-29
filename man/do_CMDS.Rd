% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/do_CMDS.R
\name{do_CMDS}
\alias{do_CMDS}
\title{Perform classical multidimensional scaling}
\usage{
do_CMDS(dm, write = FALSE, fp = "output/CMDS/", fn = "output")
}
\arguments{
\item{dm}{A distance matrix.}

\item{write}{logical flag: (default = FALSE) if TRUE then a plot will be written to file fn.}

\item{fp}{a character string naming the file path to write to.}

\item{fn}{a character string specifying the file name prefix (".gif" will be appended).}
}
\value{
A list of coordinates, eigenvalues, and other parameters as described in stats::cmdscale().
}
\description{
Perform classical multidimensional scaling (CMDS) on a distance matrix and plot the result. CMDS computes a set of points such that the distances between them approximate those of the distance matrix. The maximum number of dimensions of the points is set to three. The fraction of variance explained by the model is calculated and printed as the R-squared value.
}
