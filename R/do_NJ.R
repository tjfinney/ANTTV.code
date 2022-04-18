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
  tr <- ape::nj(stats::as.dist(dm))
  # Do plot
  grDevices::graphics.off()
  graphics::par(bg="white")
  graphics::par(mai=c(0.5, 0.5, 0.5, 0.5))
  #plot(tr, "u")
  tr
}
