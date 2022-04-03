#' Reduce missing data
#'
#' Drop rows from a data set until the number of pairwise defined columns is at least equal to a minimum acceptable number for every combination of two remaining rows. Given a selection of two rows, a column is pairwise defined if its elements are defined for both rows (i.e. neither row has `NA`).
#'
#' Reduction is achieved by dropping rows that cause the number of pairwise defined columns to fail the minimum acceptable number condition. The process has two stages. In the first stage, all rows with fewer than the minimum acceptable number of defined elements are dropped as they cannot satisfy the condition when in combination with another row. The second stage is iterative and proceeds until the minimum condition is satisfied for all combinations of two remaining rows. At each step, the two rows with the least number of pairwise defined columns are identified then the least well defined of the two (i.e. the one with the most missing data) is dropped.
#'
#' A particular row can be nominated to be kept from elimination provided that it has enough defined (i.e. non-`NA`) elements to satisfy the minimum acceptable number condition.
#'
#' If `report` is TRUE then the program will report which rows are being dropped.
#'
#' @param fr A data frame.
#' @param min Minimum acceptable number of pairwise defined columns.
#' @param keep Name of a row to be kept.
#' @param report Whether to report dropped rows.
#'
#' @return A data frame.
#' @export
#'
do_reduction <- function(fr, min = 15, keep = NULL, report = FALSE) {
  # Initial checks
  stopifnot(
    "input is not a data frame" = is.data.frame(fr),
    "input must have more than one row" = dim(fr)[1] > 1,
    "*min* must be greater than zero" = 0 < min,
    "*min* exceeds number of columns" = min <= dim(fr)[2]
  )
  if (!is.null(keep)) {
    stopifnot(
      "*keep* does not match any row names" = keep %in% row.names(fr),
      "*keep* does not have *min* defined elements" = sum(!is.na(fr[keep,]) >= min)
    )
  }
  # Stage 1
  drop <- (diag(do_counts(fr)) < min)
  fr1 <- fr[!drop,]
  if (report) {
    message("Stage 1: drop rows with < ", min, " elements:")
    message(paste(rownames(fr)[drop], collapse=" "))
  }
  dim(fr1)
}
