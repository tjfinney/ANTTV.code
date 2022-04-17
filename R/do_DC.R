#' Perform divisive clustering analysis
#'
#' Perform divisive hierarchical clustering analysis on a distance matrix and plot the result.
#'
#' @param dm A distance matrix.
#'
#' @return A divisive hierarchical clustering plot.
#' @export
#'
do_DC <- function(dm) {
  DC <- cluster::diana(as.dist(dm))
  plot(DC, which=2, main="", xlab="", cex=0.8)
}
