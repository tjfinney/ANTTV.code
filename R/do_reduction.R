#' Reduce missing data
#'
#' Drop rows from a data set until the number of pairwise defined columns is at least equal to a minimum acceptable number for every combination of two remaining rows. Given a selection of two rows, a column is pairwise defined if its elements are defined for both rows (i.e. neither row has NA for that column).
#'
#' Reduction is achieved by dropping rows that cause the number of pairwise defined columns to fail the minimum acceptable number condition. The process has two stages. In the first stage, all rows with fewer than the minimum acceptable number of defined elements are dropped as they cannot satisfy the condition when in combination with another row. The second stage is iterative. At each step, rows associated with the least number of pairwise defined counts are identified and one is dropped. (A row that has been nominated to be kept will not be dropped at this stage.) The row elimination process continues until the least number of pairwise counts reaches the minimum acceptable number.
#'
#' This code incorporates suggestions by Bill Venables (see Jan 2014 archive at https://list.science.auckland.ac.nz/sympa/arc/stat-rdownunder).
#'
#' @param fr A data frame.
#' @param n Minimum acceptable number of pairwise defined columns in the reduced data frame. Values can range from 1 to the number of columns. (Default = 15.)
#' @param keep A row to be kept from elimination provided that it has enough defined (i.e. non-NA) elements to satisfy the minimum acceptable number condition.
#' @param report Whether to report which rows are being dropped.
#'
#' @return A data frame where the number of pairwise defined columns is at least equal to the minimum acceptable number for every combination of two rows.
#' @export
#'
do_reduction <- function(fr, n = 15, keep = "", report = FALSE) {
  # Initial checks
  stopifnot(
    "input is not a data frame" = is.data.frame(fr),
    "input must have more than one row" = dim(fr)[1] > 1,
    "*n* must be greater than zero" = 0 < n,
    "*n* exceeds number of columns" = n <= dim(fr)[2]
  )
  if (keep != "") {
    stopifnot(
      "*keep* does not match any row names" = keep %in% row.names(fr),
      "*keep* does not have *n* defined elements" = sum(!is.na(fr[keep,])) >= n
    )
  }
  # Stage 1
  drop <- (diag(do_counts(fr)) < n)
  fr1 <- fr[!drop,]
  if (report) {
    message("Stage 1: drop rows with less than n defined elements:")
    message(paste(rownames(fr)[drop], collapse=" "))
  }
  # Stage 2
  mx <- do_counts(fr1)
  while((m <- min(mx)) < n) {
    # List rows with least counts
    ls <- which(mx == m, arr.ind=TRUE)[, 1]
    # Choose worst defined row which is not to be kept
    wd <- sort(diag(mx)[ls[names(ls) != keep]])[1]
    i <- which(names(ls) == names(wd))[1]
    # Drop it
    mx <- mx[-ls[i], -ls[i]]
  }
  drop <- !(rownames(fr1) %in% rownames(mx))
  if (report) {
    message("Stage 2: drop remaining rows that cause the minimum condition to be violated:")
    message(paste(rownames(fr1)[drop], collapse=" "))
  }
  fr1[!drop,]
}
