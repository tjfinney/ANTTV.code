#' Convert multi-state data frame to its binary equivalent
#'
#' Create a data frame that represents multi-state data with binary equivalents. For example, if a column has seven states represented by seven codes (e.g. 1, 2, 3, 4, 5, 6, 7) then this column is converted to three columns with states represented by their binary equivalents distributed across the columns (e.g. 0 -> 0 0 0; 1 -> 0 0 1; 2 -> 0 1 0; 3 -> 0 1 1; 4 -> 1 0 0; 5 -> 1 0 1; 6 -> 1 1 0; 7 -> 1 1 1). Cells of the input data frame that are not available (i.e. NA) are converted to the appropriate number of NAs in the output data frame.
#'
#' @param fr A data frame of multi-state values.
#' @return A data frame of binary values
#' @export
#'
do_binarize <- function(fr) {
  # Initial checks
  stopifnot(
    "input is not a data frame" = is.data.frame(fr)
  )
  # Create output data frame (same rows as input data frame but no columns yet)
  fr_out <- fr[, FALSE]
  # Apply column conversion function to every input column
  nc <- dim(fr)[2]
  for (i in 1:nc) {
    fr_out <- cbind(fr_out, do_bin_col(fr[i]))
  }
  fr_out
}

#' Convert a multi-state data frame of one column to a multi-column data frame of the binary equivalents of the multi-state values.
#'
#' The required number of columns is one plus the floor of the base two logarithm of the maximum value in the input column.
#'
#' @param fr A data frame of one column.
#' @return A data frame with multiple columns.
#' @export
#'
do_bin_col <- function(fr) {
  # Initial checks
  stopifnot(
    "data frame must have exactly one column" = dim(fr)[2] == 1
  )
  # Convert column to vector of integers
  v <- as.integer(unlist(fr))
  # Check that values are non-negative
  stopifnot(
    "vector contains non-negative values" = all(v >= 0, na.rm = TRUE)
  )
  # Calculate required number of columns
  v_max <- max(v, na.rm = TRUE)
  n <- 1 + floor(log(v_max, base = 2))
  # Do conversion
  out <- as.data.frame(t(sapply(v, do_bin_rep, n)))
  # Apply names
  names(out) <- make.unique(rep(names(fr), n + 1))[2:(n+1)]
  row.names(out) <- row.names(fr)
  # Return result
  out
}

#' Make a binary representation of a non-negative integer
#'
#' Return a binary representation of the input using a given number of binary digits.
#'
#' @param x A non-negative integer.
#' @param n A number of binary digits.
#' @return A vector of binary digits of length n.
#' @export
#'
do_bin_rep <- function(x, n) {
  if(is.na(x)) rep(NA, n) else rev(as.integer(intToBits(x)[1:n]))
}
