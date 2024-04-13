#' Drop witnesses from the input distance matrix if they are within a specified distance of a reference witness.
#'
#' @param dm A distance matrix.
#'
#' @param ref the reference witness (e.g. "Byz").
#'
#' @param d the specified distance (e.g. 0.25).
#'
#' @return A matrix
#' @export
#'
do_trim <- function(dm, ref="Byz", d=0.25) {
  tryCatch(
    expr = {
      # Do checks
      stopifnot(is.matrix(dm))
      stopifnot(ref %in% rownames(dm))
      stopifnot(d > 0)
      stopifnot(d < 1)
      # Find witnesses within d of ref
      row_ref <- dm[ref,]
      keep <- names(row_ref[row_ref > d])
      # Return result
      dm[keep, keep]
    }
  )
}
