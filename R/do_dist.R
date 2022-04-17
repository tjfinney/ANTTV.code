#' Compute distance matrix from a data frame
#'
#' Compute distances between rows in a data frame. Elements are taken to be factors so the only meaningful result of comparing two rows (i.e. witnesses) for the same column (i.e. variation site) is whether their elements match. Simple matching is used to compute the distance between two rows. The simple matching distance between two rows is the number of columns that differ divided by number of columns compared. (Columns where either row has NA are not compared.)
#'
#' @param fr A data frame.
#' @param digits Number of digits for rounding distances (default = 3).
#'
#' @return A square matrix giving the simple matching distance between every combination of two rows.
#' @export
#'
do_dist <- function(fr, digits = 3) {
  round(as.matrix(cluster::daisy(fr)), digits)
}
