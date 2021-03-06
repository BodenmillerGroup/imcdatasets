#' Obtain the zanotelli-spheroids-2020 dataset
#'
#' Obtain the zanotelli-spheroids-2020 dataset, which consists of three data
#' objects: single cell data, multichannel images and cell segmentation masks.
#' The data were obtained by imaging mass cytometry of sections of 3D spheroids
#' generated from different cell lines.
#'
#' @param data_type type of data to load, should be \code{sce} for single cell 
#' data, \code{images} for multichannel images or \code{masks} for cell 
#' segmentation masks.
#' @param on_disk logical indicating if images in form of
#' \linkS4class{HDF5Array} objects (as .h5 files) should be stored on disk
#' rather than in memory. This setting is valid when downloading \code{images}
#' and \code{masks}.
#' @param h5FilesPath path to where the .h5 files for on disk representation
#' are stored. This path needs to be defined when \code{on_disk = TRUE}.
#' When files should only temporarily be stored on disk, please set
#' \code{h5FilesPath = getHDF5DumpDir()}
#' @param force logical indicating if images should be overwritten when files
#' with the same name already exist on disk.
#'
#' @details
#' This is an Imaging Mass Cytometry (IMC) dataset from Zanotelli et al. (2020),
#' consisting of three data objects:
#' \itemize{
#'     \item \code{ZanotelliSpheroids2020_images} contains 517 multichannel 
#'     images, each containing 51 channels, in the form of a 
#'     \linkS4class{CytoImageList} class object.
#'     \item \code{ZanotelliSpheroids2020_masks} contains the cell segmentation
#'     masks associated with the images, in the form of a
#'     \linkS4class{CytoImageList} class object.
#'     \item \code{ZanotelliSpheroids2020_sce} contains the single cell data
#'     extracted from the images using the cell segmentation masks, as well as
#'     the associated metadata, in the form of a
#'     \linkS4class{SingleCellExperiment}. This represents a total of 229,047
#'     cells x 51 channels.
#' }
#'
#' All data are downloaded from ExperimentHub and cached for local re-use.
#' Specific resources can be retrieved by searching for
#' \code{imcdatasets/ZanotelliSpheroids2020_sce},
#' \code{imcdatasets/ZanotelliSpheroids2020_images}, or
#' \code{imcdatasets/ZanotelliSpheroids2020_masks}.
#'
#' Mapping between the three data objects is performed via variables located in
#' their metadata columns: \code{mcols()} for the \linkS4class{CytoImageList}
#' objects and \code{ColData()} for the \linkS4class{SingleCellExperiment}
#' object. Mapping at the image level can be performed with the
#' \code{ImageName} or \code{ImageNumber} variables. Mapping between cell
#' segmentation masks and single cell data is performed with the
#' \code{CellNumber} variable, the values of which correspond to the intensity
#' values of the \code{ZanotelliSpheroids2020_masks} object. For practical
#' examples, please refer to the "Accessing IMC datasets" vignette.
#'
#' This dataset was obtained as following (the names of the experimental
#' variables, located in the \code{colData} of the
#' \linkS4class{SingleCellExperiment} object, are indicated in parentheses):
#' \emph{i)} Cells from four different cell lines (\code{cellline}) were seeded 
#' at three different densities (\code{concentration}, relative densities) and 
#' grown for either 72 or 96 hours (\code{time_point}, duration in hours). In 
#' the appropriate experimental conditions (see the paper for details), the 
#' cells aggregate into 3D spheroids. \emph{ii)} Cells were harvested and pooled
#' into 60-well barcoding plates. \emph{iii)} A pellet of each spheroid pool was
#' generated and cut into several 6 um-thick sections. \emph{iv)} A subset of 
#' these sections (\code{site_id}) were stained with an IMC panel and acquired 
#' as one or more acquisitions (\code{acquisition_id}) containing multiple 
#' spheres each. \emph{v)} Spheres in these acquisitions were identified by 
#' computer vision and cropped into individual images (\code{ImageNumber}).
#'
#' Other relevant cell metadata include:
#' \itemize{
#'     \item \code{condition_name}: experimental conditions in the format:
#'     \code{"Cell line name"_c"seeding density"_tp"time point"}.
#'     \item \code{Center_X/Y}: object centroid position in image.
#'     \item \code{Area}: area of the cell (um^2).
#'     \item \code{dist.rim}: estimated distance to spheroid border.
#'     \item \code{dist.sphere}: distance to spheroid section border.
#'     \item \code{dist.other}: distance to the closest of the other spheroid
#'     sections in the same image (if there is any).
#'     \item \code{dist.bg}: distance to background pixels.
#'     \item \code{counts_neighb}: contains arsinh-transformed counts, with cofactor 1.
#'     \item \code{exprs_neighb}: contains arsinh-transformed counts, with cofactor 1.
#' }
#' For a full description of the other experimental variables, please refer to
#' the publication (https://doi.org/10.15252/msb.20209798) and to the
#' original dataset repository (https://doi.org/10.5281/zenodo.4271910).
#'
#' The marker-associated metadata, including antibody information and metal tags
#' are stored in the \code{rowData} of the \linkS4class{SingleCellExperiment}
#' object. The channels with names starting with "BC_" are the channels used for
#'  barcoding. Post-transcriptional modification of the protein targets are
#' indicated in brackets.
#'
#' The \code{assay} slot of the \linkS4class{SingleCellExperiment} object
#' contains four assays:
#' \itemize{
#'     \item \code{counts}: mean ion counts per cell.
#'     \item \code{exprs}: arsinh-transformed counts per cell, with cofactor 1.
#'     \item \code{counts_neighb}: mean ion counts of the neighboring cells.
#'     \item \code{exprs_neighb}: arsinh-transformed counts (cofactor 1) of the
#'     neighboring cells.
#' }
#'
#'The \code{metadata} slot of the \linkS4class{SingleCellExperiment} object
#'contains a graph of cell neighbors, generated with the
#'\code{igraph::graph_from_data_frame} function.
#'
#' File sizes:
#' \itemize{
#'     \item \code{`ZanotelliSpheroids2020_images`}: size in memory = 21.2 Gb, 
#'     size on disk = 881 Mb.
#'     \item \code{`ZanotelliSpheroids2020_masks`}: size in memory = 426 Mb, 
#'     size on disk = 11.6 Mb.
#'     \item \code{`ZanotelliSpheroids2020_sce`}: size in memory = 584 Mb, size on
#'     disk = 340 Mb.
#' }
#'
#' When storing images on disk, these need to be first fully read into memory
#' before writing them to disk. This means the process of downloading the data
#' is slower than directly keeping them in memory. However, downstream analysis
#' will lose its memory overhead when storing images on disk.
#'
#' Original source: Zanotelli et al. (2020):
#' https://doi.org/10.15252/msb.20209798
#'
#' Original link to raw data, also containing the entire dataset:
#' https://doi.org/10.5281/zenodo.4271910
#'
#' @return A \linkS4class{SingleCellExperiment} object with single cell data, a
#' \linkS4class{CytoImageList} object containing multichannel images, or a
#' \linkS4class{CytoImageList} object containing cell segmentation masks.
#'
#' @author Nicolas Damond
#'
#' @references
#' Zanotelli VRT et al. (2020).
#' A quantitative analysis of the interplay of environment, neighborhood, and
#' cell state in 3D spheroids
#' \emph{Mol Syst Biol} 16(12), e9798.
#'
#' @examples
#' sce <- ZanotelliSpheroids2020Data(data_type = "sce")
#' sce
#' images <- ZanotelliSpheroids2020Data(data_type = "images")
#' head(images)
#' masks <- ZanotelliSpheroids2020Data(data_type = "masks")
#' head(masks)
#'
#' @import cytomapper
#' @import methods
#' @importFrom utils download.file
#' @importFrom utils read.csv
#' @importFrom ExperimentHub ExperimentHub
#' @importFrom SingleCellExperiment SingleCellExperiment
#' @importFrom HDF5Array writeHDF5Array
#' @importFrom DelayedArray DelayedArray
#'
#' @export
ZanotelliSpheroids2020Data <- function(data_type = c("sce", "images", "masks"),
                                       on_disk = FALSE,
                                       h5FilesPath = NULL,
                                       force = FALSE) {
    if(length(data_type) != 1) {
        stop('The data_type argument should be of length 1.')
    }

    if(!(data_type %in% c("sce", "images", "masks"))) {
        stop('The data_type argument should be "sce", "images" or "masks".')
    }

    if (on_disk) {
        if (is.null(h5FilesPath)) {
            stop("When storing the images on disk, please specify a 'h5FilesPath'. \n",
                 "You can use 'h5FilesPath = getHDF5DumpDir()' to temporarily store the images.\n",
                 "If doing so, .h5 files will be deleted once the R session ends.")
        }
    }

    dataset_name = "ZanotelliSpheroids2020"
    host <- file.path("imcdatasets", "zanotelli-spheroids-2020")
    eh <- ExperimentHub()

    if (data_type == "sce") {
        title <- paste(dataset_name, data_type, sep = "_")
        object_id <- eh[eh$title == title]$ah_id
        cur_dat <- eh[[object_id]]
    } else if (data_type == "images") {
        title <- paste(dataset_name, data_type, sep = "_")
        object_id <- eh[eh$title == title]$ah_id
        cur_dat <- eh[[object_id]]

        if (on_disk) {
            # Check if files exist
            cur_files <- file.path(h5FilesPath, paste0(names(cur_dat), ".h5"))

            if (all(file.exists(cur_files)) & !force) {
                stop("All .h5 files already exist.",
                     " Please specify 'force = TRUE' to overwrite existing files.")
            }

            cur_dat <- CytoImageList(cur_dat, on_disk = on_disk,
                                     h5FilesPath = h5FilesPath)
        }

    } else if (data_type == "masks") {
        title <- paste(dataset_name, data_type, sep = "_")
        object_id <- eh[eh$title == title]$ah_id
        cur_dat <- eh[[object_id]]

        if (on_disk) {
            # Check if files exist
            cur_files <- file.path(h5FilesPath, paste0(names(cur_dat), ".h5"))

            if (all(file.exists(cur_files)) & !force) {
                stop("All .h5 files already exist.",
                     " Please specify 'force = TRUE' to overwrite existing files.")
            }

            cur_dat <- CytoImageList(cur_dat, on_disk = on_disk,
                                     h5FilesPath = h5FilesPath)
        }

    }
    cur_dat
}
