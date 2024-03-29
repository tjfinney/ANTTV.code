#' Read a distance matrix
#'
#' Read a distance matrix from a comma-separated vector (CSV) file. The file is assumed to be a square table with rows and columns for the same set of witnesses in the same order. The first column and row is taken to be witness names. Table elements are treated as numeric. (Each element of the diagonal should be zero.)
#'
#' This is a wrapper for utils::read.csv.
#'
#' @param fn A file name, which can be a URL.
#'
#' @return A square matrix.
#' @export
#'
#' @examples
#' x <- read_dist_matrix("https://zenodo.org/record/6505843/files/Acts.UBS2.dist.csv")
#'
read_dist_matrix <- function(fn) {
  as.matrix(utils::read.csv(fn, row.names=1, check.names=FALSE))
}
