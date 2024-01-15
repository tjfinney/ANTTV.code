#' For each witness, rank other witnesses by distance
#'
#' This uses do_reduction() to reduce missing data then do_dist() to obtain the corresponding distance matrix. (It doesn't matter if the input data frame is already reduced.)
#'
#' Function stats::qbinom() is used to estimate lower and upper critical distances (LCD, UCD). Distances that are less than the LCD or greater than the UCD are marked with an asterisk. (Such distances are not expected to happen by chance.)
#'
#' Asterices are escaped (with "\") to facilitate use of output files in Markdown documents.
#'
#' @param fr a data frame.
#'
#' @param n minimum acceptable number of pairwise defined columns in the reduced data frame. Values can range from 1 to the number of columns. (Default = 15.)
#'
#' @param keep a row to be kept from elimination provided that it has enough defined (i.e. non-NA) elements to satisfy the minimum acceptable number condition.
#'
#' @param alpha alpha value (i.e. probability of a type I error) (default = 0.05).
#'
#' @param write logical flag: (default = FALSE) if TRUE then ranked distances will be written to file fn.
#'
#' @param fn a connection or character string naming the file to write to.
#'
#' @return A matrix giving ranked distances for each witness.
#' @export
#'
do_rank <- function(fr, n=15, keep="", alpha=0.05, write = FALSE, fn="output/rank/output.txt") {
  fr1 <- do_reduction(fr, keep=keep, n=n)
  dist1 <- do_dist(fr1)
  cts1 <- do_counts(fr1)
  # Make output
  ww <- row.names(fr1)
  # Matrix for output
  mx_out <- matrix(
    ww,
    nrow = length(ww),
    ncol = 1,
    dimnames = list(ww, "Ranked distances")
  )
  # Data frame for making ranked distances string for a witness
  fr_w <- data.frame(row.names = ww)
  for (w in ww) {
    dd <- dist1[, w]
    cc <- cts1[, w]
    # Mean of distances for this witness (excluding distance to self)
    pr <- mean(dd[names(dd) != w])
    # Lower and upper critical distances
    # Critical distances depend on numbers of pair-wise defined counts
    lcd <- stats::qbinom(alpha/2, cc, pr)/cc
    ucd <- stats::qbinom(1- (alpha/2), cc, pr)/cc
    # Whether given distance is outside expected bounds
    is_significant <- (((dd - lcd) < 0) | ((dd - ucd) > 0))
    fr_w[["dist"]] <- dd
    fr_w[["is_sig"]] <- is_significant
    # Sort by distance
    ranked <- fr_w[order(fr_w$dist),]
    # Drop distance to self (always zero)
    ranked <- subset(ranked, rownames(ranked) != w)
    # Add asterisk to mark significant distances
    sig <- as.array(ranked$is_sig)
    ranked[["star"]] <- apply(sig, 1, function(x) if (x) "\\*" else "")
    # Make output string
    mx_out[w, "Ranked distances"] <- paste(
      sprintf(
        "%s (%.3f)%s",
        row.names(ranked),
        ranked$dist,
        ranked$star
      ),
      collapse=", "
    )
  }
  # Write table to file
  if (write) {
    zz <- file(fn, "w")
    cat("| Witness | Ranked distances |\n", file = zz)
    cat("|:------|:------------------------------------|\n", file = zz)
    cat(
      sprintf(
        "| %s | %s |\n",
        row.names(mx_out),
        mx_out[, "Ranked distances"]
      ),
      file = zz
    )
    close(zz)
  }
  # Return result
  mx_out
}
