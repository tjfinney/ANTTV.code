#' Compute counts of comparable columns
#'
#' For each combination of two rows, compute how many columns of a data frame are comparable . (Given a selection of two rows, a column is comparable if neither row has `NA` for that column.) Returns a square matrix giving the count for every combination of two rows.
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
