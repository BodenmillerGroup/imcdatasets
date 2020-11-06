#' Obtain the damond-pancreas-2019 data
#'
#' Obtain the human pancreas from donors with type 1 diabetes data from Damond
#' et al. (2019).
#'
#' @param data.type type of data to load, should be `sce` for single cell data
#' (default), `images` for multichannel images or `masks` for cell masks.
#'
#' @details
#' The dataset contains three types of data: single cell data in form of a
#' `SingleCellExperiment` object, multichannel images formatted into a
#' `CytoImageList` object and cell masks formatted into a `CytoImageList`
#' object. The type of data to retrieve is defined by the `data.type` parameter.
#'
#' All data are downloaded from ExperimentHub and cached for local re-use.
#'
#' @return A \linkS4class{SingleCellExperiment} object with single cell data, a
#' \linkS4class{CytoImageList} object containing multichannel images, or a
#' \linkS4class{CytoImageList} object containing cell masks.
#'
#' @author Nicolas Damond
#'
#' @references
#' Damond N et al. (2019).
#' A Map of Human Type 1 Diabetes Progression by Imaging Mass Cytometry.
#' \emph{Cell Metab} 29(3), 755-768.
#'
#' @examples
#' sce <- DamondPancreas2019Data()
#' images <- DamondPancreas2019Data(data.type = "images")
#' masks <- DamondPancreas2019Data(data.type = "masks")
#'
#' @import cytomapper
#' @importFrom utils download.file
#' @importFrom utils read.csv
#' @importFrom ExperimentHub ExperimentHub
#' @importFrom SingleCellExperiment SingleCellExperiment
#'
#' @export
DamondPancreas2019Data <- function(data.type = "sce") {
    if(!(data.type %in% c("sce", "images", "masks"))) {
        stop('The data.type argument should be "sce", "images" or "masks".')
    }

    host <- file.path("imcdatasets", "damond-pancreas-2019")
    hub <- ExperimentHub()

    if(data.type == "sce") {
        cur.dat <- hub[hub$rdatapath == file.path(
            host, paste0("sce", ".rds"))]
    } else if(data.type == "images") {
        cur.dat <- hub[hub$rdatapath == file.path(
            host, paste0("images", ".rds"))]
    } else if(data.type == "masks") {
        cur.dat <- hub[hub$rdatapath == file.path(
            host, paste0("masks", ".rds"))]
    }

    cur.dat
}
