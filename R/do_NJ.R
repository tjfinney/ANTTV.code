#' Perform neighbour-joining tree estimation
#'
#' Perform the neighbor-joining tree estimation of Saitou and Nei on a distance matrix and plot the result.
#'
#' @param dm A distance matrix.
#'
#' @param write logical flag: (default = FALSE) if TRUE then a plot will be written to file fn.
#'
#' @param fn a connection or character string naming the file to write to.
#'
#' @return An object of class "phylo".
#' @export
#'
do_NJ <- function(dm, write = FALSE, fn = "../NJ/output.png") {
  # Perform analysis
  tr <- ape::nj(stats::as.dist(dm))
  # Do plot
  grDevices::graphics.off()
  graphics::par(bg="white")
  graphics::par(mai=c(0.5, 0.5, 0.5, 0.5))
  plot(tr, "u")
  # Write plot to file
  if (write) {
    grDevices::dev.print(grDevices::png, file=fn, width=600)
  }
  # Return result
  tr
}
