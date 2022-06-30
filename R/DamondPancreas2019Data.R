#' Obtain the damond-pancreas-2019 dataset
#'
#' Obtain the damond-pancreas-2019 dataset, which consists of three data
#' objects: single cell data, multichannel images and cell segmentation masks.
#' The data was obtained by imaging mass cytometry of human pancreas sections
#' from donors with type 1 diabetes.
#'
#' @param data_type type of data to load, should be `sce` for single cell data,
#' `images` for multichannel images or `masks` for cell segmentation masks.
#' @param on_disk logical indicating if images in form of
#' \linkS4class{HDF5Array} objects (as .h5 files) should be stored on disk
#' rather than in memory. This setting is valid when downloading \code{images} and
#' \code{masks}.
#' @param h5FilesPath path to where the .h5 files for on disk representation
#' are stored. This path needs to be defined when \code{on_disk = TRUE}.
#' When files should only temporarily be stored on disk, please set
#' \code{h5FilesPath = getHDF5DumpDir()}
#' @param force logical indicating if images should be overwritten when files
#' with the same name already exist on disk.
#'
#' @details
#' This is an Imaging Mass Cytometry (IMC) dataset from Damond et al. (2019),
#' consisting of three data objects:
#' \itemize{
#'     \item \code{images} contains a hundred 38-channel
#'     images in the form of a \linkS4class{CytoImageList} class object.
#'     \item \code{masks} contains the cell segmentation
#'     masks associated with the images, in the form of a
#'     \linkS4class{CytoImageList} class object.
#'     \item \code{sce} contains the single cell data
#'     extracted from the images using the cell segmentation masks, as well as
#'     the associated metadata, in the form of a
#'     \linkS4class{SingleCellExperiment}. This represents a total of 252,059
#'     cells x 38 channels.
#' }
#'
#' Mapping between the three data objects is performed via variables located in
#' their metadata columns: \code{mcols()} for the \linkS4class{CytoImageList}
#' objects and \code{ColData()} for the \linkS4class{SingleCellExperiment}
#' object. Mapping at the image level can be performed with the
#' \code{ImageName} or \code{ImageNumber} variables. Mapping between cell
#' segmentation masks and single cell data is performed with the
#' \code{CellNumber} variable, the values of which correspond to the intensity
#' values of the \code{DamondPancreas2019_masks} object. For practical
#' examples, please refer to the "Accessing IMC datasets" vignette.
#'
#' This dataset is a subset of the complete Damond et al. (2019) dataset
#' comprising the data from three pancreas donors at different stages of type 1
#' diabetes (T1D). The three donors present clearly diverging characteristics in
#' terms of cell type composition and cell-cell interactions, which makes this
#' dataset ideal for benchmarking spatial and neighborhood analysis algorithms.
#'
#' The \code{assay} slot of the \linkS4class{SingleCellExperiment} object
#' contains two assays:
#' \itemize{
#'     \item \code{counts} contains mean ion counts per cell.
#'     \item \code{exprs} contains arsinh-transformed counts, with cofactor 1.
#' }
#'
#' The marker-associated metadata, including antibody information and metal tags
#' are stored in the \code{rowData} of the \linkS4class{SingleCellExperiment}
#' object.
#'
#' The cell-associated metadata are stored in the \code{colData} of the
#' \linkS4class{SingleCellExperiment} object. These metadata include cell types
#' (in \code{colData(sce)$CellType}) and broader cell categories, such  as
#' "immune" or "islet" cells (in \code{colData(sce)$CellCat}). In addition,
#' for cells located inside pancreatic islets, the islet they belong to is
#' indicated in \code{colData(sce)$ParentIslet}. For cells not located in
#' islets, the "ParentIslet" value is set to 0 but the spatially closest islet
#' can be identified with \code{colData(sce)$ClosestIslet}.
#'
#' The donor-associated metadata are also stored in the \code{colData} of the
#' \linkS4class{SingleCellExperiment} object. For instance, the donors' IDs can
#' be retrieved with \code{colData(sce)$case} and the donors' disease stage can
#' be obtained with \code{colData(sce)$stage}.
#'
#' The three donors present the following characteristics:
#' \itemize{
#'     \item \code{6126} is a non-diabetic donor, with large islets containing
#'     many beta cells, severe infiltration of the exocrine pancreas with
#'     myeloid cells but limited infiltration of islets.
#'     \item \code{6414} is a donor with recent T1D onset (shortly after
#'     diagnosis) showing partial beta cell destruction and mild infiltration of
#'     islets with T cells.
#'     \item \code{6180} is a donor with long-duration T1D (11 years after
#'     diagnosis), showing near-total beta cell destruction and limited immune
#'     cell infiltration in both the islets and the pancreas.
#' }
#'
#' File sizes:
#' \itemize{
#'     \item \code{`images`}: size in memory = 7.4 Gb, size
#'     on disk = 1780 Mb.
#'     \item \code{`masks`}: size in memory = 200.0 Mb, size
#'     on disk = 8.6 Mb.
#'     \item \code{`sce`}: size in memory = 248.6 Mb, size on
#'     disk = 145 Mb.
#' }
#'
#' When storing images on disk, these need to be first fully read into memory
#' before writing them to disk. This means the process of downloading the data
#' is slower than directly keeping them in memory. However, downstream analysis
#' will lose its memory overhead when storing images on disk.
#'
#' Original source: Damond et al. (2019):
#' https://doi.org/10.1016/j.cmet.2018.11.014
#'
#' Original link to raw data, also containing the entire dataset:
#' https://data.mendeley.com/datasets/cydmwsfztj/2
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
#' sce
#' images <- DamondPancreas2019Data(data_type = "images")
#' head(images)
#' masks <- DamondPancreas2019Data(data_type = "masks")
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
DamondPancreas2019Data <- function(data_type = c("sce", "images", "masks"),
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

    dataset_name = "DamondPancreas2019"
    host <- file.path("imcdatasets", "damond-pancreas-2019")
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
