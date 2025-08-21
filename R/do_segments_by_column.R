#' Divide a data frame into n column-wise segments
#'
#' Split a data frame into a number of roughly equal chunks of columns. The last segment will contain remaining columns if n is not a divisor of the number of data frame columns.
#'
#' File paths are relative to the current working directory (gettable with
#' getwd() and settable with setwd()). Segments are written as CSV files with
#' names derived from the output file stem. E.g. if n is 4 and the stem is
#' "data/Mark.UBS4" then the output files will be written to:
#'
#' * "data/Mark.UBS4.a.csv"
#' * "data/Mark.UBS4.b.csv",
#' * "data/Mark.UBS4.c.csv"
#' * "data/Mark.UBS4.d.csv"
#'
#' @param fr A data frame
#' @param write logical flag: (default = FALSE) if TRUE then write output files
#' @param n Number of segments (must be less than or equal to 26)
#' @param fn Output file stem
#'
#' @return Nothing. Output files are produced as a side effect.
#' @export
#'
do_segments_by_column <- function(fr, write = FALSE, n = 4, fn = "data/Mark.UBS4") {
  # Initial checks
  stopifnot(
    "input is not a data frame" = is.data.frame(fr),
    "input must have more than one row" = dim(fr)[1] > 1,
    "*n* must be greater than zero" = 0 < n,
    "*n* exceeds allowable number" = n <= 26
  )
  # Make array of chunk sizes
  nc <- ncol(fr)
  quotient <- nc %/% n
  remainder <- nc %% n
  chunks <- rep(quotient, times=n)
  chunks[n] <- chunks[n] + remainder
  # Write segments
  for (i in 1:n) {
    first <- (i - 1) * quotient + 1
    last <- first + chunks[i] - 1
    seg <- fr[, first:last]
    f_name <- paste(c(fn, letters[i], "csv"), collapse=".")
    if (write) {
      message(paste0(c("write ", f_name)))
      utils::write.csv(seg, f_name)
    }
  }
}
