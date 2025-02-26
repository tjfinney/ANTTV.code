#' Perform non-negative matrix factorization
#'
#' Do NMF.
#'
#' @param fr A data frame.
#'
#' @param rank NMF rank (default = 2)
#'
#' @param method NMF method (default = "ls-nmf")
#'
#' @param write logical flag: (default = FALSE) if TRUE then a plot will be written to file fn.
#'
#' @param fn a connection or character string naming the file to write to.
#'
#' @return A basis map.
#' @export
#'
do_nmf <- function(fr, rank = 2, method = "ls-nmf", write = FALSE, fn = "output/NMF/output.png") {
  # X is target matrix
  X <- t(data.matrix(fr))
  # Handle NAs
  NA_cells <- is.na(X)
  X[ NA_cells ] <- 99999
  W <- matrix(1, nrow(X), ncol(X))
  W[ NA_cells ] <- 0
  # Perform analysis
  res <- NMF::nmf(X, rank, method, weight = W)
  # Do plot
  # Write plot to file
  if (write) {
    grDevices::dev.print(grDevices::png, file=fn, width=1000, height=600)
  }
  # Return result
  NMF::basismap(res, tracks=':basis', annColor=list(basis=1:rank))
}
