% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/do_segments_by_column.R
\name{do_segments_by_column}
\alias{do_segments_by_column}
\title{Divide a data frame into n column-wise segments}
\usage{
do_segments_by_column(fr, write = FALSE, n = 4, fn = "data/Mark.UBS4")
}
\arguments{
\item{fr}{A data frame}

\item{write}{logical flag: (default = FALSE) if TRUE then write output files}

\item{n}{Number of segments (must be less than or equal to 26)}

\item{fn}{Output file stem}
}
\value{
Nothing. Output files are produced as a side effect.
}
\description{
The last segment will contain remaining columns if n is not a divisor of the
number of data frame columns.
}
\details{
File paths are relative to the current working directory (gettable with
getwd() and settable with setwd()). Segments are written as CSV files with
names derived from the output file stem. E.g. if n is 4 and the stem is
"data/Mark.UBS4" then the output files will be written to:
\itemize{
\item "data/Mark.UBS4.a.csv"
\item "data/Mark.UBS4.b.csv",
\item "data/Mark.UBS4.c.csv"
\item "data/Mark.UBS4.d.csv"
}
}
