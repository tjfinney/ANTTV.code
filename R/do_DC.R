#' Perform divisive clustering analysis
#'
#' Compute a divisive hierarchical clustering of a distance matrix and plot the result.
#'
#' @param dm A distance matrix.
#'
#' @param write logical flag: (default = FALSE) if TRUE then a plot will be written to file fn.
#'
#' @param fn a connection or character string naming the file to write to.
#'
#' @return An object of class "diana" representing the clustering.
#' @export
#'
do_DC <- function(dm, write = FALSE, fn = "output/DC/output.png") {
  # Perform analysis
  DC <- cluster::diana(stats::as.dist(dm))
  # Do plot
  grDevices::graphics.off()
  plot(DC, which=2, main="", xlab="", cex=0.8)
  # Write plot to file
  if (write) {
    grDevices::dev.print(grDevices::png, file=fn, width=1000, height=600)
  }
  # Return result
  DC
}
