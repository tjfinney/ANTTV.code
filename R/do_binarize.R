#' Convert multistate data frame to a binary equivalent
#'
#' Create a data frame that represents multistate data with binary equivalents. For example, if a column has seven states represented by seven codes (e.g. 1, 2, 3, 4, 5, 6, 7) then this column will be converted to three columns with states represented by their binary equivalents distributed across the columns (e.g. 0 -> 0 0 0; 1 -> 0 0 1; 2 -> 0 1 0; 3 -> 0 1 1; 4 -> 1 0 0; 5 -> 1 0 1; 6 -> 1 1 1; 7 -> 1 1 1). Cells of the input data frame that are not available (i.e. marked as NA) are converted to the appropriate number of NAs in the output data frame.
#'
#' @param fr A multistate data frame.
#' @return A data frame of binary states.
#' @export
#'
do_binarize <- function(fr) {
  # Initial checks
  stopifnot(
    "input is not a data frame" = is.data.frame(fr),
    "input must have at least one row" = dim(fr)[1] > 0
  )
  fr_out <- data.frame(row.names = rownames(fr))


  fr_out
}

#' Calculate the number of binary digits required to represent a vector of positive integers
#'
#' The required number of binary digits is the floor of the base two logarithm of the maximum value plus one.
#'
#' @param x A vector of positive integers.
#' @return An integer.
#' @export
#'
do_bin_digits <- function(x) {
  floor(log(max(as.numeric(x), na.rm = TRUE), base = 2)) + 1
}

#' Make a binary representation of a positive integer
#'
#' Return a binary representation of the input using a given number of binary digits.
#'
#' @param x A positive integer.
#' @param n A number of binary digits.
#' @return A vector of binary digits of length n.
#' @export
#'
do_bin_rep <- function(x, n) {
  if(is.na(x)) rep(NA, n) else rev(as.integer(intToBits(x)[1:n]))
}

#' Make a binary representation of a vector of positive integers
#'
#' Apply do_bin_rep() to a vector.
#'
#' @param x A vector of positive integers.
#' @return A matrix of length(x) rows and n cols
#' @export
#'
do_bin_vec <- function(x) {
  x <- as.integer(x)  # coerce vector to integer values
  stopifnot(
    "vector contains non-positive values" = all(x > 0, na.rm = TRUE)
  )
  t(sapply(x, do_bin_rep, n = do_bin_digits(x)))
}
