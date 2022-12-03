#' Perform classical multidimensional scaling
#'
#' Perform classical multidimensional scaling (CMDS) on a distance matrix and plot the result. CMDS computes a set of points such that the distances between them approximate those of the distance matrix. The maximum number of dimensions of the points is set to three. The fraction of variance explained by the model is calculated and printed as the R-squared value.
#'
#' @param dm A distance matrix.
#'
#' @param write logical flag: (default = FALSE) if TRUE then a plot will be written to file fn.
#'
#' @param fp a character string naming the file path to write to.
#'
#' @param fn a character string naming the file name to write to.
#'
#' @return A list of coordinates, eigenvalues, and other parameters as described in stats::cmdscale().
#'
#' @export
#'
do_CMDS <- function(dm, write = FALSE, fp = "../CMDS/", fn = "Mark.UBS4") {
  # Do analysis
  distances <- stats::as.dist(dm)
  MDS <- stats::cmdscale(distances, k=3, eig=TRUE)
  x <- MDS$points[,1]
  y <- MDS$points[,2]
  z <- MDS$points[,3]
  # Calculate R-squared
  MDS.dist <- stats::dist(MDS$points, diag=TRUE, upper=TRUE)
  MDS.summary <- stats::summary.lm(stats::lm(distances ~ MDS.dist))
  rsq <- MDS.summary$r.squared
  # Do plot
  grDevices::graphics.off()
  rgl::par3d(windowRect = c(0, 0, 600, 600))
  rgl::par3d(cex = 0.8)
  rgl::plot3d(x, y, z, xlab="axis 1", ylab="axis 2", zlab="axis 3", type='n', axes=TRUE, box=TRUE, sub=sprintf("R-squared = %0.2f", rsq))
  rgl::text3d(x, y, z, rownames(MDS$points), col=4)
  # Write plot to file
  if (write) {
    rgl::movie3d(rgl::spin3d(rpm = 10), duration = 6, movie = fn, dir = fp, webshot = FALSE, convert = "convert -delay 1x%d -loop 0 %s*.png %s.%s")
  }
  # Return result
  MDS
}
