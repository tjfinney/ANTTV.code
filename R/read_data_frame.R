#' Read a data frame
#'
#' Make a data frame from a comma-separated vector (CSV) file. The file is read as a table with rows for witnesses and columns for variation sites. The first column is taken to be witness names and the first row to be variation site identifiers. Table elements are treated as factors. Consequently, the only meaningful result of comparing two elements in a column is whether they match.
#'
#' This is a wrapper for utils::read.csv.
#'
#' @param fn A file name, which can be a URL.
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' x <- read_data_frame("https://zenodo.org/record/6466262/files/Mark.UBS4.csv")
#'
read_data_frame <- function(fn) {
  utils::read.csv(fn, row.names=1, colClasses="factor")
}
