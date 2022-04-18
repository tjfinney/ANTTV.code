#' Perform divisive clustering analysis
#'
#' Compute a divisive hierarchical clustering of a distance matrix.
#'
#' @param dm A distance matrix.
#'
#' @param plot logical flag: (default = TRUE) if TRUE then a plot will be drawn on the current graphics device.
#'
#' @param write logical flag: (default = FALSE) if TRUE then a plot will be written to file fn.
#'
#' @param fn the file to write to.
#'
#' @return An object of class "diana" representing the clustering.
#' @export
#'
do_DC <- function(dm, plot = TRUE, write = FALSE, fn = "../DC/Mark.UBS4.png") {
  DC <- cluster::diana(stats::as.dist(dm))
  if (plot) {
    grDevices::graphics.off()
    plot(DC, which=2, main="", xlab="", cex=0.8)
  }
  if (write) { dev.print(png, file=fn, width=1000, height=600) }
  DC
}
