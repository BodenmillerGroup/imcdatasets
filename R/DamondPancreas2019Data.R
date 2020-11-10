#' Obtain the damond-pancreas-2019 data
#'
#' Obtain the human pancreas from donors with type 1 diabetes data from Damond
#' et al. (2019).
#'
#' @param data_type type of data to load, should be `sce` for single cell data
#' (default), `images` for multichannel images or `masks` for cell masks.
#'
#' @details
#' The dataset contains three types of data: single cell data in form of a
#' `SingleCellExperiment` object, multichannel images formatted into a
#' `CytoImageList` object and cell masks formatted into a `CytoImageList` 
#' object.
#'
#' The value of \code{data_type} will retrieve different data sets.
#' \itemize{
#' \item \code{"sce"}, single cell data
#' \item \code{"images"}, 38-channel images.
#' \item \code{"masks"}, cell masks.
#' }
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
#' sce <- DamondPancreas2019Data(data_type = "sce")
#' images <- DamondPancreas2019Data(data_type = "images")
#' masks <- DamondPancreas2019Data(data_type = "masks")
#'
#' @import cytomapper
#' @import methods
#' @importFrom utils download.file
#' @importFrom utils read.csv
#' @importFrom ExperimentHub ExperimentHub
#' @importFrom SingleCellExperiment SingleCellExperiment
#'
#' @export
DamondPancreas2019Data <- function(data_type) {
    if(!(data_type %in% c("sce", "images", "masks"))) {
        stop('The data_type argument should be "sce", "images" or "masks".')
    }
    
    dataset_name = "DamondPancreas2019"
    host <- file.path("imcdatasets", "damond-pancreas-2019")
    eh <- ExperimentHub()
    
    if(data_type == "sce") {
        title = paste(dataset_name, data_type, sep = "_")
        object_id <- eh[eh$title == title]$ah_id
        cur_dat <- eh[[object_id]]
    } else if(data_type == "images") {
        title = paste(dataset_name, data_type, sep = "_")
        object_id <- eh[eh$title == title]$ah_id
        cur_dat <- eh[[object_id]]
    } else if(data_type == "masks") {
        title = paste(dataset_name, data_type, sep = "_")
        object_id <- eh[eh$title == title]$ah_id
        cur_dat <- eh[[object_id]]
    }
    cur_dat
}
