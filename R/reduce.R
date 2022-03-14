#' Reduce a data frame that contains missing data (NAs) so that the number of columns where any two rows can be compared (i.e. neither has NA) is at least equal to a minimum value. Reduction is achieved by recursively eliminating rows that cause a violation of the minimum condition.
#'
#' @param df A data frame.
#' @param min Minimum number of mutually defined places.
#' @param retain Name of a row that must be retained.
#'
#' @return A data frame.
#' @export
#'
reduce <- function(df, min = 16, retain = NULL) {
  dim(df)
}
