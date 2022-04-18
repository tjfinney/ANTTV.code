#' Perform neighbour-joining tree estimation
#'
#' Perform the neighbor-joining tree estimation of Saitou and Nei on a distance matrix and plot the result.
#'
#' @param dm A distance matrix.
#'
#' @return A neighbour-joining tree plot.
#' @export
#'
do_NJ <- function(dm) {
  # Perform analysis.
  tr <- ape::nj(as.dist(dm))
  # Do plot
  graphics.off()
  par(bg="white")
  par(mai=c(0.5, 0.5, 0.5, 0.5))
  plot(tr, "u")
}
