#' Reduce missing data
#'
#' Remove rows from a data frame so that the number of columns where any two rows are comparable is at least equal to a minimum value. (Here, two rows are comparable at a column if neither has missing data (`NA`) there.) Reduction is achieved by recursively eliminating rows that cause a violation of the minimum condition. At each step the two rows with the least number of comparable columns are identified then the least well-defined of the two is eliminated. (The least well-defined is the one with the most missing data.) One row may be marked to be kept from elimination.
#'
#' @param frame A data frame.
#' @param min Minimum number of comparable elements.
#' @param keep Name of a row to be preserved.
#'
#' @return A data frame.
#' @export
#'
do_reduction <- function(frame, min = 15, keep = NULL) {
  dim(frame)
}
