#' Perform non-negative matrix factorization
#'
#' Do NMF.
#'
#' @param fr A data frame.
#'
#' @param write logical flag: (default = FALSE) if TRUE then a plot will be written to file fn.
#'
#' @param fn a connection or character string naming the file to write to.
#'
#' @return An object of class "NMFfit".
#' @export
#'
do_nmf <- function(fr, rank = 2, method = "ls-nmf", write = FALSE, fn = "output/NMF/output.png") {
  # Handle NAs
  x <- data.matrix(fr)
  NA_cells <- is.na(x)
  x[ NA_cells ] <- 99999
  w <- matrix(1, nrow(x), ncol(x))
  w[ NA_cells ] <- 0
  # Perform analysis
  res <- NMF::nmf(x, rank, method, weight = w)
  # Do plot
  # Write plot to file
  if (write) {
    grDevices::dev.print(grDevices::png, file=fn, width=1000, height=600)
  }
  # Return result
  NMF::basismap(res, tracks=':basis', annColor=list(basis=1:rank))
}
