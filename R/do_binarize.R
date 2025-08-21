#' Convert multistate data frame to a binary data frame
#'
#' Convert multistate columns of a dataframe to binary columns. For example, if a column has seven states represented by seven codes (e.g. 1, 2, 3, 4, 5, 6, 7 or a, b, c, d, e, f, g) then this column will be converted to three columns with states represented by their binary equivalents distributed across the columns (e.g. 0 -> 0 0 0; 1 -> 0 0 1; 2 -> 0 1 0; 3 -> 0 1 1; 4 -> 1 0 0; 5 -> 1 0 1; 6 -> 1 1 1; 7 -> 1 1 1). Cells of the input dataframe that are not available (i.e. marked as NA) are converted to the appropriate number of NAs in the output dataframe.
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
  # Test data
  eg <- Mark.UBS4[1:10,1]
  eg
  # Functions
  # Calculate number of columns required to a represent a column of integer states.
  fn_n_col <- function(c) {
    max(!is.na(as.integer(c)))
  }
  # ...
  x = fn_n_col(eg)
  message(x)

}
