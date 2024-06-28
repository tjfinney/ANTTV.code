#' Read a CBGM CSV file.
#'
#' Input is a semi-colon separated text file with the following format:
#'
#' Field nos | Description
#' ------------|------------
#'  1 | record no
#'  2-10 | site addresses (e.g. 20101010)
#'  11 | reading code (e.g. a)
#'  12 | ?
#'  13 | reading (e.g. χριστου)
#'  14 | witness code (Nestle-Aland; e.g. 043)
#'  15 | witness code (INTF; e.g. 200430)
#'  16 | ?
#'
#' Site addresses (fields 2-10) are comprised of:
#'
#' * start address as four fields (book:chapter:verse:word)
#' * end address as three fields (chapter:verse:word)
#' * combined start address field (e.g. 20101010)
#' * combined end address field (e.g. 20101010)
#'
#' All but the following input fields are dropped:
#'
#' * 9 (combined start address)
#' * 10 (combined end address)
#' * 11 (reading code)
#' * 14 (Nestle-Aland witness code)
#' * 15 (INTF witness code)
#'
#' The output is a data frame with witnesses as rows and variation sites as
#' columns. Reading codes "zz", "zw", "zu" are coded as NA = not available.
#' Column headings are variation site labels based on the combined start
#' address and an integer for each corresponding end address. For example, the
#' combined start address for the first variation site in Mark is "20101010"
#' and there is one corresponding end address. The combined start address is
#' converted to "Mk.1.1.10" (i.e. book.chapter.verse.word). Finally, a ".1" for
#' the corresponding end address is appended to produce "Mk.1.1.10.1" as the
#' label.
#'
#' @param fn A file name, which can be a URL.
#'
#' @return A data frame.
#' @export
#'
read_data_frame_CBGM <- function(fn) {
  # Read fields 9, 10, 11, 14, and 15 into input data frame
  df_in <- utils::read.csv2(fn, header=FALSE, na.strings=c("zz", "zu", "zw"), colClasses = c(
    "NULL",
    "NULL",
    "NULL",
    "NULL",
    "NULL",
    "NULL",
    "NULL",
    "NULL",
    "character",
    "character",
    "character",
    "NULL",
    "NULL",
    "character",
    "character",
    "NULL"
  ))
  # Drop rows with NA in reading column
  df_in <- df_in[!is.na(df_in$V11),]
  # Row names (Nestle-Aland codes in INTF order)
  df_r <- data.frame(c1 = unique(df_in$V15), c2 = unique(df_in$V14))
  df_r <- df_r[order(df_r$c1), ]
  r_names <- df_r$c2
  n_row <- length(r_names)
  # Column names (start address plus integer for the nth corresponding end address)
  c1 <- unique(paste(df_in$V9, df_in$V10, sep="."))
  n_col <- length(c1)
  c2 <- unlist(strsplit(c1, "[.]"))[c(TRUE, FALSE)]
  c3 <- unlist(strsplit(c1, "[.]"))[c(FALSE, TRUE)]
  c4 <- c("-", c2[1:n_col-1])
  c5 <- (c2 == c4)
  c6 <- rep(1, n_col)
  for (n in 2:n_col) if (c5[n]) c6[n] <- c6[n - 1] + 1
  # Function to convert INTF start addr to bk.ch.vs.wd format
  fn_c_name <- function(x) {
    books <- c("Mt", "Mk", "Lk", "Jn")
    bk <- books[as.integer(substr(x, 1, 1))]
    ch <- as.integer(substr(x, 2, 3))
    vs <- as.integer(substr(x, 4, 5))
    wd <- as.integer(substr(x, 6, 8))
    paste(bk, ch, vs, wd, sep=".")
  }
  # Make data frame for column name, start addr, end addr
  c7 <- lapply(c2, fn_c_name)
  c_names <- paste(c7, c6, sep=".")
  df_c <- data.frame(c_name = c_names, start = c2, end = c3)
  # Make output
  df_out <- data.frame(row.names = r_names)
  # Function to make an output column with readings in right places.
  fill <- function(ww, rr) {
    # ww: subset of r_names in any order
    # rr: corresponding reading codes
    out <- rep(NA, times=length(r_names))
    for (i in 1:length(ww)) {
      out[which(r_names == ww[i])] <- rr[i]
    }
    out
  }
  for (n in 1:n_col) {
    # Get col name, start addr, end addr
    c <- df_c[n,]
    # Select corresponding input rows
    rr_in <- df_in[df_in$V9 == c$start & df_in$V10 == c$end, ]
    # Add corresponding output column with witnesses in INTF order
    witnesses <- rr_in$V14 # Witnesses ordered as per input data
    readings <- rr_in$V11 # Corresponding readings
    df_out[[c$c_name]] <- fill(witnesses, readings)
  }
  df_out
}
