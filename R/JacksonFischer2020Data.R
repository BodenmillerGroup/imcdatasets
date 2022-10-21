#' Obtain the jackson-fischer-2020 dataset
#'
#' This function is provided for compatibility with older versions but is 
#' deprecated. As a replacement, please use 
#' \code{JacksonFischer_2020_BreastCancer}.
#' Obtain the jackson-fischer-2020 dataset, which consists of three data
#' objects: single cell data, multichannel images and cell segmentation masks.
#' The data was obtained by imaging mass cytometry of tumour tissue from
#' patients with breast cancer.
#'
#' @param data_type type of object to load, should be `sce` for single cell
#' data, `images` for multichannel images or `masks` for cell segmentation
#' masks.
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
#' deprecated. As a replacement, please use 
#' \code{JacksonFischer_2020_BreastCancer}.
#' This is an Imaging Mass Cytometry (IMC) dataset from Jackson, Fischer et al.
#' (2020), consisting of three data objects:
#' \itemize{
#'     \item \code{images} contains a hundred 42-channel
#'     images in the form of a \linkS4class{CytoImageList} class object.
#'     \item \code{masks} contains the cell segmentation
#'     masks associated with the images, in the form of a
#'     \linkS4class{CytoImageList} class object.
#'     \item \code{sce} contains the single cell data extracted from the 
#'     multichannel images using the cell segmentation masks, as well as the 
#'     associated metadata, in the form of a \linkS4class{SingleCellExperiment}.
#'      This represents a total of 285,851 cells x 42 channels.
#' }
#'
#' All data are downloaded from ExperimentHub and cached for local re-use.
#'
#' Mapping between the three data objects is performed via variables located in
#' their metadata columns: \code{mcols()} for the \linkS4class{CytoImageList}
#' objects and \code{ColData()} for the \linkS4class{SingleCellExperiment}
#' object. Mapping at the image level can be performed with the
#' \code{ImageNb} variable. Mapping between cell segmentation masks and single
#' cell data is performed with the \code{CellNb} variable, the values of which
#' correspond to the intensity values of the \code{JacksonFischer2020_masks}
#' object. For practical examples, please refer to the "Accessing IMC datasets"
#' vignette.
#'
#' This dataset is a subset of the complete Jackson, Fischer et al. (2020)
#' dataset comprising the data from tumour tissue from 100 patients with breast
#' cancer (one image per patient).
#'
#' The \code{assay} slot of the \linkS4class{SingleCellExperiment} object
#' contains three assays:
#' \itemize{
#'     \item \code{counts} contains mean ion counts per cell.
#'     \item \code{exprs} contains arsinh-transformed counts, with cofactor 1.
#'     \item \code{quant_norm} contains quantile-normalized counts (0 to 1,
#'     99th percentile).
#' }
#'
#' The marker-associated metadata, including antibody information and metal tags
#' are stored in the \code{rowData} of the \linkS4class{SingleCellExperiment}
#' object.
#'
#' The cell-associated metadata are stored in the \code{colData} of the
#' \linkS4class{SingleCellExperiment} object. These metadata include clusters
#' (in \code{colData(sce)$PhenoGraphBasel}) and metaclusters (in
#' \code{colData(sce)$metacluster}), as well as spatial information (e.g., cell
#' areas are stored in \code{colData(sce)$Area}).
#'
#' The patient-associated clinical data are also stored in the \code{colData} of
#' the \linkS4class{SingleCellExperiment} object. For instance, the tumor grades
#' can be retrieved with \code{colData(sce)$grade}.
#'
#' File sizes:
#' \itemize{
#'     \item \code{`images`}: size in memory = 17.8 Gb, size on disk = 2.0 Gb.
#'     \item \code{`masks`}: size in memory = 433 Mb, size on disk = 10 Mb.
#'     \item \code{`sce`}: size in memory = 477 Mb, size on disk = 266 Mb.
#' }
#'
#' When storing images on disk, these need to be first fully read into memory
#' before writing them to disk. This means the process of downloading the data
#' is slower than directly keeping them in memory. However, downstream analysis
#' will lose its memory overhead when storing images on disk.
#'
#' Original source: Jackson, Fischer et al. (2020):
#' https://doi.org/10.1038/s41586-019-1876-x
#'
#' Original link to raw data, containing the entire dataset:
#' https://doi.org/10.5281/zenodo.3518284
#'
#' @return A \linkS4class{SingleCellExperiment} object with single cell data, a
#' \linkS4class{CytoImageList} object containing multichannel images, or a
#' \linkS4class{CytoImageList} object containing cell masks.
#'
#' @author Jana Fischer
#'
#' @references
#' Jackson, Fischer et al. (2020).
#' The single-cell pathology landscape of breast cancer.
#' \emph{Nature} 578(7796), 615-620.
#'
#' @examples
#' # Load single cell data
#' sce <- JacksonFischer2020Data(data_type = "sce")
#' print(sce)
#' 
#' # Display metadata
#' JacksonFischer2020Data(data_type = "sce", metadata = TRUE)
#' 
#' # Load masks on disk
#' library(HDF5Array)
#' masks <- JacksonFischer2020Data(data_type = "masks", on_disk = TRUE,
#' h5FilesPath = getHDF5DumpDir())
#' print(head(masks))
#' 
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
JacksonFischer2020Data <- function (
    data_type = c("sce", "images", "masks"),
    metadata = FALSE,
    on_disk = FALSE,
    h5FilesPath = NULL,
    force = FALSE
) {
    .Deprecated("JacksonFischer_2020_BreastCancer()")

    available_versions <- dataset_version <- "v0"
    dataset_name <- "JacksonFischer_2020_BreastCancer"

    .checkArguments(data_type, metadata, dataset_version, available_versions,
        on_disk, h5FilesPath, force)
    
    cur_dat <- .loadDataObject(data_type, metadata, dataset_name,
        dataset_version, on_disk, h5FilesPath, force)

    return(cur_dat)
}