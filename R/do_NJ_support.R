#' Estimate support values for a neighbour-joining tree
#'
#' This uses bootstrap sampling of a data frame to produce a neighbour-joining tree with support values. Function do_reduction() is used with its default settings to reduce missing data in the input data frame. (It doesn't matter if the input data frame is already reduced.) Functions do_dist() and do_NJ() are used to produce 100 NJ trees from the reduced data frame. Support values are obtained from these trees.
#'
#'
#' @param fr A data frame.
#'
#' @param write logical flag: (default = FALSE) if TRUE then a plot will be written to file fn.
#'
#' @param fn a connection or character string naming the file to write to.
#'
#' @return An object of class "phylo".
#' @export
#'
do_NJ_support <- function(fr, write = FALSE, fn="output/NJ/support.png") {
  fr1 <- do_reduction(fr)
  fun <- function(x) ape::as.phylo(do_NJ(do_dist(x)))
  tree <- fun(fr1)
  bstrees <- ape::boot.phylo(tree, fr1, fun, trees = TRUE)$trees
  boot <- ape::prop.clades(tree, bstrees)
  # Do plot
  grDevices::graphics.off()
  graphics::par(mar = rep(2, 4))
  plot(tree, main = "Bipartition Support Values")
  ape::drawSupportOnEdges(boot)
  # Write plot to file
  if (write) {
    grDevices::dev.print(grDevices::png, file=fn, width=600)
  }
  # Return result
  tree
}
