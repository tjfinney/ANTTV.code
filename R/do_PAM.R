#' Do PAM (partitioning around medoids) analysis.
#'
#' According to the cluster::pam() documentation, 'The pam-algorithm is based on the search for k representative objects or medoids among the observations of the dataset. These observations should represent the structure of the data. After finding a set of k medoids, k clusters are constructed by assigning each observation to the nearest medoid. The goal is to find k representative objects which minimize the sum of the dissimilarities of the observations to their closest representative object.'
#'
#' The output clustering is the optimal one, namely that which produces the maximum average silhouette width. A file can be written to give a table of partitions corresponding to various values of k, as specified by argument ks. Each line of the table gives (1) k, (2) clusters enclosed in braces with medoids enclosed in parentheses, (3) witnesses that are poorly classified (as indicated by a negative silhouette width).
#'
#' @param dm A distance matrix.
#'
#' @param write logical flag: (default = FALSE) if TRUE then write a table of partitions to file fn.
#'
#' @param ks A vector of numbers of clusters to be written.
#'
#' @param fn a connection or character string naming the file to write to.
#'
#' @return An object of class "pam" representing the clustering for the optimal value of k.
#' @export
#'
do_PAM <- function(dm, write = FALSE, fn = "../PAM/output.txt", ks = 2:20) {
  # Do analysis
  k.max <- (dim(dm))[1] - 1
  asw <- numeric(k.max)
  dist <- stats::as.dist(dm)
  for (k in 2:k.max) {
    asw[k] <- cluster::pam(dist, k)$silinfo$avg.width
  }
  asw.max <- which.max(asw)
  # Write table to file
  if (write) {
    zz <- file(fn, "w")
    cat("k | ASW | Clusters | Poorly classified\n", file = zz)
    cat("------|------|------------------------------------------------------------|------------\n", file = zz)
    for (k in ks) {
      PAM <- cluster::pam(dist, k)
      groups <- vector(mode = "character", length = k)
      for (n in 1:k) {
        group <- names(PAM$clustering[PAM$clustering == n])
        medoid <- PAM$medoids[n]
        group[group == medoid] <- sprintf("(%s)", medoid)
        groups[[n]] <- sprintf("[%s]", paste(group, collapse=" "))
      }
      groups <- paste(groups, collapse=" ")
      sil.widths <- sort(PAM$silinfo$widths[,3], decreasing=TRUE)
      av.sil.width <- round(PAM$silinfo$avg.width, digits=3)
      poor <- paste(names(sil.widths[sil.widths < 0]), collapse=" ")
      cat(sprintf("%s | %.3f | %s | %s\n", k, av.sil.width, groups, poor), file = zz)
    }
    close(zz)
  }
  # Return result
  cluster::pam(dist, asw.max)
}
