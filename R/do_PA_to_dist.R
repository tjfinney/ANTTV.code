#' Convert percentage agreement matrix to distance matrix
#'
#' The input is assumed to be comma-separated vector of percentage agreements; that is, a square table with rows and columns for the same set of witnesses in the same order. The first column and row is taken to be witness names. Table elements are treated as numeric. (Each element of the diagonal should be 100.)
#'
#' The output is the distance matrix obtained by taking the 100 complement of the percentage agreement and dividing by 100.
#'
#' This uses utils::read.csv to read the input CSV file.
#'
#' @param file A file name, which can be a URL.
#'
#' @return A distance matrix.
#' @export
#'
#' @examples
#' # do_PA_to_dist("my_percentage_agreements.csv")
#'
do_PA_to_dist <- function(file) {
  agree <- as.matrix(utils::read.csv(file, row.names=1, check.names=FALSE))
  (100 - agree)/100
}
