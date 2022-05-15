#' Gospel of Mark textual variation data extracted from UBS4 (*Greek New Testament*, 4th rev. ed., Stuttgart: United Bible Societies, 1993).
#'
#' A data frame that specifies the readings of witnesses for variation sites found in the UBS4 apparatus (one row per witness and one column per variation site). Numerals encode readings according to the order given in the apparatus: i.e. 1 = first reading, 2 = second reading, etc. This data frame was constructed by Richard Mallett.
#'
#' @format A data frame with 267 rows and 142 columns:
#' \describe{
#'   \item{Mk.1.1}{Codes representing readings found in the apparatus entry at Mark 1.1.}
#'   ...
#' }
#' @source \url{https://zenodo.org/record/6466262}
"Mark.UBS4"

#' Acts of the Apostles textual variation data extracted from UBS2 (*Greek New Testament*, 2nd ed.).
#'
#' A distance matrix specifying simple matching distances between a set of witnesses. The distance matrix was constructed by Maurice Robinson. See Timothy J. Finney, "Varieties of New Testament Text" in *Digging for the Truth: Collected Essays Regarding the Byzantine Text of the Greek New Testament*, ed. Mark Billington and Peter Streitenberger (Norden: FYM, 2014) for details of how the distance matrix was constructed. Witnesses are named according to the Gregory-Aland system.
#'
#' @format A distance matrix with 55 rows and 55 columns:
#' \describe{
#'   \item{P74}{Witness P74}
#'   \item{A}{Witness A}
#' }
#' @source \url{https://zenodo.org/record/6505843}
"Acts.UBS2.dist"
