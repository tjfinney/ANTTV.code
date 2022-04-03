#' Compute pairwise defined counts
#'
#' Compute how many columns in a data set are pairwise defined for each combination of two rows. Given a selection of two rows, a column is pairwise defined if its elements are defined for both rows (i.e. neither row has `NA` for that column).
#'
#' This code incorporates suggestions by Bill Venables (see Jan 2014 archive at https://list.science.auckland.ac.nz/sympa/arc/stat-rdownunder).
#'
#' @param fr A data frame.
#'
#' @return A square matrix giving the number of pairwise defined columns for every combination of two rows.
#' @export
#'
do_counts <- function(fr) {
  mx <- data.matrix(fr)
  mx[] <- !is.na(mx)
  tcrossprod(mx)
}
