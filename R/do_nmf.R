#' Perform non-negative matrix factorization (NMF)
#'
#' Do NMF to factorize an n x p matrix *X* into two non-negative matrices: the n x r *basis matrix W* and the r x p *mixture coefficient matrix H* such that *X ≈ WH*. The factorization rank r is typically much less than the minimum of n and p. The columns of *W* are r factors of *X*.
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
  wm <- matrix(1, nrow(X), ncol(X))
  wm[ NA_cells ] <- 0
  # Perform analysis
  result <- NMF::nmf(X, rank, method, weight = wm)
  #estim.r <- NMF::nmf(X, 2:6, nrun = 10, seed = 1, method, weight = wm)
  # W: Basis matrix W
  W <- NMF::basis(result)
  # H: mixture coefficient matrix
  H <- NMF::coef(result)
  # Do plot
  #layout(cbind(1, 2))
  # Basis components
  #NMF::basismap(result)
  #NMF::basismap(result, tracks=':basis', annColor=list(basis=1:rank))
  #NMF::fit(res)
  # Mixture coefficients
  NMF::coefmap(result)
  # Write plot to file
  if (write) {
    grDevices::dev.print(grDevices::png, file=fn, width=1000, height=600)
  }
  # Return result
  #...
}
