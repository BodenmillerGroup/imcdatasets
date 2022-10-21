#' Obtain the zanotelli-spheroids-2020 dataset
#'
#' This function is provided for compatibility with older versions but is 
#' deprecated. As a replacement, please use \code{Zanotelli_2020_Spheroids}.
#' Obtain the zanotelli-spheroids-2020 dataset, which consists of three data
#' objects: single cell data, multichannel images and cell segmentation masks.
#' The data were obtained by imaging mass cytometry of sections of 3D spheroids
#' generated from different cell lines.
#'
#' @param data_type type of data to load, should be \code{sce} for single cell 
#' data, \code{images} for multichannel images or \code{masks} for cell 
#' segmentation masks.
#' @param metadata if FALSE (default), the data object selected in 
#' \code{data_type} is returned. If TRUE, only the metadata associated to this
#' object is returned.
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
#' This function is provided for compatibility with older versions but is 
#' deprecated. As a replacement, please use \code{Zanotelli_2020_Spheroids}.
#' This is an Imaging Mass Cytometry (IMC) dataset from Zanotelli et al. (2020),
#' consisting of three data objects:
#' \itemize{
#'     \item \code{images} contains 517 multichannel images, each containing 51 
#'     channels, in the form of a \linkS4class{CytoImageList} class object.
#'     \item \code{masks} contains the cell segmentation
#'     masks associated with the images, in the form of a
#'     \linkS4class{CytoImageList} class object.
#'     \item \code{sce} contains the single cell data extracted from the 
#'     multichannel images using the cell segmentation masks, as well as the 
#'     associated metadata, in the form of a \linkS4class{SingleCellExperiment}.
#'      This represents a total of 229,047 cells x 51 channels.
#' }
#'
#' All data are downloaded from ExperimentHub and cached for local re-use.
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
#'     \item \code{counts_neighb}: contains arsinh-transformed counts 
#'     (cofactor = 1).
#'     \item \code{exprs_neighb}: contains arsinh-transformed counts 
#'     (cofactor 1).
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
#'     \item \code{`images`}: size in memory = 21.2 Gb, size on disk = 860 Mb.
#'     \item \code{`masks`}: size in memory = 426 Mb, size on disk = 12 Mb.
#'     \item \code{`sce`}: size in memory = 564 Mb, size on disk = 319 Mb.
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
#' # Load single cell data
#' sce <- ZanotelliSpheroids2020Data(data_type = "sce")
#' print(sce)
#'
#' # Display metadata
#' ZanotelliSpheroids2020Data(data_type = "sce", metadata = TRUE)
#' 
#' # Load masks on disk
#' library(HDF5Array)
#' masks <- ZanotelliSpheroids2020Data(data_type = "masks", on_disk = TRUE,
#' h5FilesPath = getHDF5DumpDir())
#' print(head(masks))
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
ZanotelliSpheroids2020Data <- function (
    data_type = c("sce", "images", "masks"),
    metadata = FALSE,
    on_disk = FALSE,
    h5FilesPath = NULL,
    force = FALSE
) {
    .Deprecated("Zanotelli_2020_Spheroids()")

    available_versions <- dataset_version <- "v0"
    dataset_name <- "Zanotelli_2020_Spheroids"
    
    .checkArguments(data_type, metadata, dataset_version, available_versions,
        on_disk, h5FilesPath, force)
    
    cur_dat <- .loadDataObject(data_type, metadata, dataset_name,
        dataset_version, on_disk, h5FilesPath, force)
    
    return(cur_dat)
}