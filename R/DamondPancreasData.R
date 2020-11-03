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
#' sce <- DamondPancreasData()
#' images <- DamondPancreasData(data.type = "images")
#' masks <- DamondPancreasData(data.type = "masks")
#'
#' @import cytomapper
#' @importFrom utils download.file
#' @importFrom utils read.csv
#' @importFrom SingleCellExperiment SingleCellExperiment
#'
#' @export
DamondPancreasData <- function(data.type = "sce") {

    # will have to re-add  @importFrom ExperimentHub ExperimentHub

    if(!(data.type %in% c("sce", "images", "masks"))) {
        stop('The data.type argument should be "sce", "images" or "masks".')
    }

    # Code for when the data will be on Bioconductor AWS S3
    # host <- file.path("imcdatasets", "damond-pancreas")
    # hub <- ExperimentHub()
    #
    # if(data.type == "sce") {
    #     cur.dat <- hub[hub$rdatapath == file.path(
    #         host, paste0("sce", ".rds"))]
    # } else if(data.type == "images") {
    #     cur.dat <- hub[hub$rdatapath == file.path(
    #         host, paste0("images", ".rds"))]
    # } else if(data.type == "masks") {
    #     cur.dat <- hub[hub$rdatapath == file.path(
    #         host, paste0("masks", ".rds"))]
    # }

    # Temporary code for downloading files from switchdrive
    if(data.type == "sce") {
        if(!file.exists("../data/damond-pancreas/sce.rds")) {
            url.file <- "https://drive.switch.ch/index.php/s/CAbnHjwJOwRnOS4/download"
            download.file(url.file, destfile = "data/damond-pancreas/sce.rds")
        }
        cur.dat <- readRDS("../data/damond-pancreas/sce.rds")
    } else if(data.type == "images") {
        if(!file.exists("../data/damond-pancreas/images.rds")) {
            url.file <- "https://drive.switch.ch/index.php/s/iJxY21xV3X0XyDZ/download"
            download.file(url.file, destfile = "data/damond-pancreas/images.rds")
        }
        cur.dat <- readRDS("../data/damond-pancreas/images.rds")
    } else if(data.type == "masks") {
        if(!file.exists("../data/damond-pancreas/masks.rds")) {
            url.file <- "https://drive.switch.ch/index.php/s/LvRRTtCtnUWvfBS/download"
            download.file(url.file, destfile = "data/damond-pancreas/masks.rds")
        }
        cur.dat <- readRDS("../data/damond-pancreas/masks.rds")
    }

    cur.dat
}
