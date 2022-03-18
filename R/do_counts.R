#' Compute pairwise defined counts
#'
#' Compute how many columns in a data set are pairwise defined for each combination of two rows. A column is pairwise defined if its elements are defined for both rows. (That is, neither row has `NA`.) Returns a square matrix giving the count for every combination of two rows.
#'
#' @param fr A data frame.
#'
#' @return A matrix.
#' @export
#'
do_counts <- function(fr) {
  mx <- data.matrix(fr)
  mx[] <- !is.na(mx)
  tcrossprod(mx)
}
