#' Perform neighbour-joining tree estimation
#'
#' Perform the neighbor-joining tree estimation of Saitou and Nei on a distance matrix and plot the result.
#'
#' @param dm A distance matrix.
#'
#' @param plot logical flag: (default = TRUE) if TRUE then a plot will be drawn on the current graphics device.
#'
#' @param write logical flag: (default = FALSE) if TRUE then a plot will be written to file fn.
#'
#' @return An object of class "phylo".
#' @export
#'
do_NJ <- function(dm, plot = TRUE, write = FALSE, fn = "../NJ/Mark.UBS4.png") {
  # Perform analysis.
  tr <- ape::nj(stats::as.dist(dm))
  # Do plot
  if (plot) {
    grDevices::graphics.off()
    graphics::par(bg="white")
    graphics::par(mai=c(0.5, 0.5, 0.5, 0.5))
    plot(tr, "u")
  }
  if (write) {
    grDevices::dev.print(grDevices::png, file=fn, width=600)
  }
  tr
}
