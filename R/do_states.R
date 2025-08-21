#' Convert data frame states to a standard form
#'
#' Convert data frame states to numeric values. Given the symbols in a data frame (whether alphanumeric or whatever) this first maps all symbols of the dataframe to a range of integers (from 1 to the number of unique symbols) then produces an output dataframe in which input symbols are replaced with corresponding integers from the map.
#'
#' This treats the symbols that comprise the input data frame as factors. Please see documentation for `as.factor()`.
#'
#' If the input set of states changes then the output encoding will change in a way you might not expect.
#'
#' @param fr A data frame.
#' @return A data frame of input states encoded as integers.
#' @export
#'
do_binarize <- function(fr) {
  # Initial checks
  stopifnot(
    "input is not a data frame" = is.data.frame(fr),
    "input must have at least one row" = dim(fr)[1] > 0
  )
  # Test data
  eg <- Mark.UBS4[1:10,1]
  eg
  # Functions

}
