#' Obtain the Damond_2019_Pancreas dataset
#'
#' Obtain the Damond_2019_Pancreas dataset, which consists of three data
#' objects: single cell data, multichannel images and cell segmentation masks.
#' The data was obtained by imaging mass cytometry (IMC) of human pancreas 
#' sections from donors with type 1 diabetes.
#'
#' @param data_type type of object to load, `images` for multichannel images or
#' `masks` for cell segmentation masks. Single cell data are retrieved using 
#' either `sce` for the \code{SingleCellExperiment} format or `spe` for the  
#' \code{SpatialExperiment} format.
#' @param full_dataset if FALSE (default), a subset corresponding to 100 images
#' is returned. If TRUE, the full dataset (corresponding to 845 images) is 
#' returned. Due to memory space limitations, this option is only available for 
#' single cell data and masks, not for \code{data_type = "images"}.
#' @param version dataset version. By default, the latest version is returned.
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
#' \code{h5FilesPath = getHDF5DumpDir()}.
#' @param force logical indicating if images should be overwritten when files
#' with the same name already exist on disk.
#'
#' @details
#' This is an Imaging Mass Cytometry (IMC) dataset from Damond et al. (2019):
#' \itemize{
#'     \item \code{images} contains a hundred 38-channel
#'     images in the form of a \linkS4class{CytoImageList} class object.
#'     \item \code{masks} contains the cell segmentation
#'     masks associated with the images, in the form of a
#'     \linkS4class{CytoImageList} class object.
#'     \item \code{sce} contains the single cell data extracted from the 
#'     multichannel images using the cell segmentation masks, as well as the 
#'     associated metadata, in the form of a 
#'     \linkS4class{SingleCellExperiment}. This represents a total of 252,059 
#'     cells x 38 channels.
#'     \item \code{spe} same single cell data as for \code{sce}, but in the
#'     \linkS4class{SpatialExperiment} format.
#' }
#'
#' All data are downloaded from ExperimentHub and cached for local re-use.
#'
#' Mapping between the three data objects is performed via variables located in
#' their metadata columns: \code{mcols()} for the \linkS4class{CytoImageList}
#' objects and \code{ColData()} for the \linkS4class{SingleCellExperiment} and 
#' \linkS4class{SpatialExperiment} objects. Mapping at the image level can be 
#' performed with the \code{image_name} or \code{image_number} variables. 
#' Mapping between cell segmentation masks and single cell data is performed 
#' with the \code{cell_number} variable, the values of which correspond to the 
#' intensity values of the \code{masks} object. For practical
#' examples, please refer to the "Accessing IMC datasets" vignette.
#'
#' This dataset is a subset of the complete Damond et al. (2019) dataset
#' comprising the data from three pancreas donors at different stages of type 1
#' diabetes (T1D). The three donors present clearly diverging characteristics 
#' in terms of cell type composition and cell-cell interactions, which makes 
#' this dataset ideal for benchmarking spatial and neighborhood analysis 
#' algorithms. If \code{full_dataset = TRUE}, the full dataset (845 images from
#' 12 patients) is returned. This option is not available for multichannel 
#' images.
#'
#' The \code{assay} slots of the \linkS4class{SingleCellExperiment} and 
#' \linkS4class{SpatialExperiment} objects contain three assays:
#' \itemize{
#'     \item \code{counts} contains raw mean ion counts per cell.
#'     \item \code{exprs} contains arsinh-transformed counts, with cofactor 1.
#'     \item \code{quant_norm} contains counts censored at the 99th percentile 
#'     and scaled 0-1.
#' }
#'
#' The marker-associated metadata, including antibody information and metal 
#' tags are stored in the \code{rowData} of the 
#' \linkS4class{SingleCellExperiment} / \linkS4class{SpatialExperiment} 
#' objects.
#'
#' The cell-associated metadata are stored in the \code{colData} of the
#' \linkS4class{SingleCellExperiment} and \linkS4class{SpatialExperiment} 
#' objects. These metadata include cell types (in 
#' \code{colData(sce)$cell_type}) and broader cell categories, such  as
#' "immune" or "islet" cells (in \code{colData(sce)$cell_category}). In
#' addition, for cells located inside pancreatic islets, the islet they belong 
#' to is indicated in \code{colData(sce)$islet_parent}. For cells not located 
#' in islets, the "islet_parent" value is set to 0 but the spatially closest 
#' islet can be identified with \code{colData(sce)$islet_closest}.
#'
#' The donor-associated metadata are also stored in the \code{colData} of the
#' \linkS4class{SingleCellExperiment} and \linkS4class{SpatialExperiment} 
#' objects. For instance, the donors' IDs can be retrieved with 
#' \code{colData(sce)$patient_id} and the donors' disease stage can be obtained
#' with \code{colData(sce)$patient_stage}.
#' 
#' Neighborhood information, defined here as cells that are localized next to 
#' each other, is stored as a \code{SelfHits} object in the \code{colPairs} 
#' slot of the \code{SingleCellExperiment} and \linkS4class{SpatialExperiment} 
#' objects.
#'
#' The three donors in the subset present the following characteristics:
#' \itemize{
#'     \item \code{6126} is a non-diabetic donor, with large islets containing
#'     many beta cells, severe infiltration of the exocrine pancreas with
#'     myeloid cells but limited infiltration of islets.
#'     \item \code{6414} is a donor with recent T1D onset (shortly after
#'     diagnosis) showing partial beta cell destruction and mild infiltration 
#'     of islets with T cells.
#'     \item \code{6180} is a donor with long-duration T1D (11 years after
#'     diagnosis), showing near-total beta cell destruction and limited immune
#'     cell infiltration in both the islets and the pancreas.
#' }
#' For information about other donors in the full dataset, please refer to the
#' Damond et al. publication.
#' 
#' Dataset versions: a \code{version} argument can be passed to the function to 
#' specify which dataset version should be retrieved.
#' \itemize{
#'     \item \code{`v0`}: original version (Bioconductor <= 3.15).
#'     \item \code{`v1`}: consistent object formatting across datasets.
#' }
#' 
#' File sizes:
#' \itemize{
#'     \item \code{`images`}: size in memory = 7.4 Gb, size on disk = 1.7 Gb.
#'     \item \code{`masks`}: size in memory = 200 Mb, size on disk = 8.2 Mb.
#'     \item \code{`sce`}: size in memory = 353 Mb, size on disk = 204 Mb.
#'     \item \code{`spe`}: size in memory = 372 Mb, size on disk = 205 Mb.
#'     \item \code{`sce_full`}: size in memory = 2.4 Gb, size on disk = 1.5 Gb.
#'     \item \code{`spe_full`}: size in memory = 2.5 Gb, size on disk = 1.5 Gb.
#'     \item \code{`masks_full`}: size in memory = 1.4 Gb, 
#'     size on disk = 60 Mb.
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
#' \linkS4class{SpatialExperiment} object with single cell data, a 
#' \linkS4class{CytoImageList} object containing multichannel images, or a
#' \linkS4class{CytoImageList} object containing cell segmentation masks.
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
#' sce <- Damond_2019_Pancreas(data_type = "sce")
#' print(sce)
#' 
#' # Display metadata
#' Damond_2019_Pancreas(data_type = "sce", metadata = TRUE)
#' 
#' # Load masks on disk
#' library(HDF5Array)
#' masks <- Damond_2019_Pancreas(data_type = "masks", on_disk = TRUE,
#' h5FilesPath = getHDF5DumpDir())
#' print(head(masks))
#'
#' @import cytomapper
#' @import SingleCellExperiment
#' @import methods
#' @importFrom utils download.file
#' @importFrom utils read.csv
#' @importFrom ExperimentHub ExperimentHub
#' @importFrom SpatialExperiment SpatialExperiment
#' @importFrom HDF5Array writeHDF5Array
#' @importFrom DelayedArray DelayedArray
#'
#' @export
Damond_2019_Pancreas <- function (
    data_type = c("sce", "spe", "images", "masks"),
    full_dataset = FALSE,
    version = "latest",
    metadata = FALSE,
    on_disk = FALSE,
    h5FilesPath = NULL,
    force = FALSE
) {
    available_versions <- c("v0", "v1")
    dataset_name <- "Damond_2019_Pancreas"
    dataset_version <- ifelse(version == "latest",
        utils::tail(available_versions, n=1), version)

    .checkArguments(data_type, metadata, dataset_version, available_versions,
        full_dataset, on_disk, h5FilesPath, force)

    cur_dat <- .loadDataObject(data_type, metadata, dataset_name,
        dataset_version, full_dataset, on_disk, h5FilesPath, force)

    return(cur_dat)
}