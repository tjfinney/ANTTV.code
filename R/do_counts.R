#' Compute counts of comparable columns
#'
#' For each combination of two rows, compute how many columns of a data frame are comparable . (Given a selection of two rows, a column is comparable if neither row has `NA`.) Returns a square matrix giving the count for every combination of two rows.
#'
#' @param frame A data frame.
#'
#' @return A matrix.
#' @export
#'
do_counts <- function(frame) {
  mx <- data.matrix(frame)
  mx[] <- !is.na(mx)
  tcrossprod(mx)
}
