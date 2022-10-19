#' Obtain the damond-pancreas-2019 dataset
#' 
#' This function and the associated dataset are provided for compatibility with 
#' older versions but are deprecated. As a replacement, please use 
#' \code{Damond_2019_Pancreas}.
#' Obtain the damond-pancreas-2019 dataset, which consists of three data
#' objects: single cell data, multichannel images and cell segmentation masks.
#' The data was obtained by imaging mass cytometry of human pancreas sections
#' from donors with type 1 diabetes.
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
#' This function and the associated dataset are provided for compatibility with 
#' older versions but are deprecated. As a replacement, please use 
#' \code{Damond_2019_Pancreas}.
#' This is an Imaging Mass Cytometry (IMC) dataset from Damond et al. (2019),
#' consisting of three data objects:
#' \itemize{
#'     \item \code{images} contains a hundred 38-channel
#'     images in the form of a \linkS4class{CytoImageList} class object.
#'     \item \code{masks} contains the cell segmentation
#'     masks associated with the images, in the form of a
#'     \linkS4class{CytoImageList} class object.
#'     \item \code{sce} contains the single cell data extracted from the 
#'     multichannel images using the cell segmentation masks, as well as the 
#'     associated metadata, in the form of a \linkS4class{SingleCellExperiment}.
#'      This represents a total of 252,059 cells x 38 channels.
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
#'     \item \code{`images`}: size in memory = 7.40 Gb, size on disk = 1.78 Gb.
#'     \item \code{`masks`}: size in memory = 200 Mb, size on disk = 8.6 Mb.
#'     \item \code{`sce`}: size in memory = 248 Mb, size on disk = 145 Mb.
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
#' # Load single cell data
#' sce <- DamondPancreas2019Data(data_type = "sce")
#' print(sce)
#' 
#' # Display metadata
#' DamondPancreas2019Data(data_type = "sce", metadata = TRUE)
#' 
#' # Load masks on disk
#' library(HDF5Array)
#' masks <- DamondPancreas2019Data(data_type = "masks", on_disk = TRUE,
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
DamondPancreas2019Data <- function (
    data_type = c("sce", "images", "masks"),
    metadata = FALSE,
    on_disk = FALSE,
    h5FilesPath = NULL,
    force = FALSE
) {
    .Deprecated("Damond_2019_Pancreas()")
    .checkArguments(data_type, metadata,
        on_disk, h5FilesPath, force)

    dataset_name <- "DamondPancreas2019"
    host <- file.path("imcdatasets", "damond-pancreas-2019")

    cur_dat <- .loadDataObject(
        dataset_name, host, data_type, metadata,
        on_disk, h5FilesPath, force)
}