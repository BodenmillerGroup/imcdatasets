#' List all available datasets
#'
#' Summary information for all available datasets in the \pkg{imcdatasets} package.
#'
#' @details
#' One dataset should contain single-cell data, multichannel images and cell masks.
#'
#' @return
#' A \linkS4class{DataFrame} where each row corresponds to a dataset, containing the fields:
#' \itemize{
#' \item \code{Reference}, a Markdown-formatted citation to \code{scripts/ref.bib} in the \pkg{imcdatasets} installation directory.
#' \item \code{Species}, species of origin.
#' \item \code{Tissue}, the tissue that was imaged.
#' \item \code{NumberOfCells}, the total number of cells in the dataset.
#' \item \code{NumberOfImages}, the total number of images in the dataset.
#' \item \code{NumberOfChannels}, the number of channels per image.
#' \item \code{FunctionCall}, the R function call required to construct the dataset.
#' }
#'
#' @examples
#' listDatasets()
#'
#' @export
#' @importFrom S4Vectors DataFrame
#' @importFrom utils read.csv
listDatasets <- function() {
    # path <- system.file("extdata", "alldatasets.csv", package="imcdatasets")
    path <- file.path("../inst/extdata/alldatasets.csv")
    DataFrame(read.csv(path, stringsAsFactors=FALSE))
}
