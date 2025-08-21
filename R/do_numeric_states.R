#' Convert data frame states to a numeric form
#'
#' Convert data frame states to numeric values. Given the symbols in a data frame (whether alphanumeric or whatever) this first maps all symbols of the data frame to a range of integers (from 1 to the number of unique symbols) then produces a one to one mapping from input to output data frame states. Symbols of input and output data frames are treated as factors. Please see documentation for `as.factor()`. Beware that adding input states will change the mapping. E.g. if initial mapping is &#x0251; = "1", &#x0252; = "2", &#x0254; = "3", &#x0255; = "4", adding &#x0253; results in &#x0251; = "1", &#x0252; = "2", &#x0253; = "3", &#x0254; = "4", &#x0255; = "5" and mapping differs for output states "3" and "4".
#'
#' @param fr A data frame.
#' @return A data frame of numeric states as factors.
#' @export
#'
do_numeric_states <- function(fr) {
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
