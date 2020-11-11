#' Obtain the damond-pancreas-2019 dataset
#'
#' Obtain the damond-pancreas-2019 dataset, which consists of three data 
#' objects: single cell data, multichannel images and cell masks. The data was
#' obtained by imaging mass cytometry of human pancreas sections from donors 
#' with type 1 diabetes.
#'
#' @param data_type type of data to load, should be `sce` for single cell data, 
#' `images` for multichannel images or `masks` for cell masks.
#'
#' @details
#' The dataset contains three data objects corresponding to 100 multichannel 
#' images, the associated cell masks and single cell data 
#' . The desired object can be selected 
#' using the \code{data_type} argument:
#' \itemize{
#' \item \code{`sce`}, single cell data in form of 
#' a \linkS4class{SingleCellExperiment} object of dimension 38 x 252059.
#' \item \code{`images`}, 100 images, each with 38 channels formatted into 
#' a \linkS4class{CytoImageList} object. 
#' \item \code{`masks`}, 100 cell masks formatted into 
#' a \linkS4class{CytoImageList} object.
#' }
#'
#' All data are downloaded from ExperimentHub and cached for local re-use. 
#' Specific resources can be retrieved by searching for
#' \code{imcdatasets/DamondPancreas2019_sce}, 
#' \code{imcdatasets/DamondPancreas2019_images}, or 
#' \code{imcdatasets/DamondPancreas2019_masks}.
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
