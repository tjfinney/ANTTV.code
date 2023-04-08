#' Perform bootstrap test of a neighbour-joining tree estimate
#'
#' Estimate bipartition support values for an NJ tree estimate.
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
do_bootstrap_NJ <- function(fr, write = FALSE, fn="output/NJ/bootstrap.png") {
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
