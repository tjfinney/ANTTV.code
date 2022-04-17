#' Read a data frame
#'
#' Make a data frame from a comma-separated vector (CSV) file. The file is read as a table with rows for witnesses and columns for variation sites. The first column is taken to be witness names and the first row to be variation site identifiers. Data is assumed to have class "character". (Numerals are therefore treated as characters, not numbers.)
#'
#' This is a wrapper for utils::read.csv.
#'
#' @param file A file name, which can be a URL.
#'
#' @return A data frame.
#' @export
#'
#' @examples
#' x <- read_data_frame("https://zenodo.org/record/6466262/files/Mark.UBS4.csv")
#'
read_data_frame <- function(file) {
  read.csv(file, row.names=1, colClasses="character")
}
