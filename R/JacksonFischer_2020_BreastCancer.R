#' Obtain the JacksonFischer_2020_BreastCancer dataset
#'
#' Obtain the JacksonFischer_2020_BreastCancer dataset, which consists of three 
#' data objects: single cell data, multichannel images and cell segmentation 
#' masks.
#' The data was obtained by imaging mass cytometry (IMC) of tumour tissue from
#' patients with breast cancer.
#'
#' @param data_type type of object to load, `images` for multichannel images or
#' `masks` for cell segmentation masks. Single cell data are retrieved using 
#' either `sce` for the \code{SingleCellExperiment} format or `spe` for the  
#' \code{SpatialExperiment} format.
#' @param full_dataset if FALSE (default), a subset corresponding to 100 images
#' is returned. If TRUE, the full dataset is returned, including both "Basel" 
#' and "Zurich" cohorts. Due to memory space limitations, this option is only 
#' available for single cell data and masks, not for 
#' \code{data_type = "images"}.
#' @param cohort which patient cohort should be returned? Can be set to "Basel"
#' (default) or "Zurich". Ignored if \code{full_dataset} is set to TRUE.
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
#' This is an Imaging Mass Cytometry (IMC) dataset from Jackson, Fischer et al.
#' (2020):
#' \itemize{
#'     \item \code{images} contains a hundred 42-channel
#'     images in the form of a \linkS4class{CytoImageList} class object.
#'     \item \code{masks} contains the cell segmentation
#'     masks associated with the images, in the form of a
#'     \linkS4class{CytoImageList} class object.
#'     \item \code{sce} contains the single cell data extracted from the 
#'     multichannel images using the cell segmentation masks, as well as the 
#'     associated metadata, in the form of a 
#'     \linkS4class{SingleCellExperiment}. This represents a total of 285,851 
#'     cells x 42 channels.
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
#' performed with the \code{image_name} variable. Mapping between cell 
#' segmentation masks and single cell data is performed with the 
#' \code{cell_number} variable, the values of which correspond to the intensity
#' values of the \code{masks} object. For practical examples, please refer 
#' to the "Accessing IMC datasets" vignette.
#'
#' This dataset is a subset of the complete Jackson, Fischer et al. (2020)
#' dataset comprising the data from tumour tissue from 100 patients with breast
#' cancer (one image per patient). By default, data from the "Basel" cohort are
#' returned. By setting \code{cohort = "Zurich"}, data from the "Zurich" 
#' cohort, corresponding to images and associated data from 72 patients, are 
#' returned. For details about the patient cohorts, refer to the publication. 
#' If \code{full_dataset = TRUE}, the full dataset is returned (including both 
#' "Basel" and "Zurich" patient cohorts). This option is not available for 
#' multichannel images.
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
#' The marker-associated metadata, including antibody information and metal 
#' tags are stored in the \code{rowData} of the 
#' \linkS4class{SingleCellExperiment} and \linkS4class{SpatialExperiment} 
#' objects.
#'
#' The cell-associated metadata are stored in the \code{colData} of the
#' \linkS4class{SingleCellExperiment} and \linkS4class{SpatialExperiment} 
#' objects. These metadata include clusters (in 
#' \code{colData(sce)$cell_cluster_phenograph}) and metaclusters (in
#' \code{colData(sce)$cell_metacluster}), as well as spatial information (e.g., 
#' cell areas are stored in \code{colData(sce)$cell_area}).
#'
#' The clinical data are also stored in the \code{colData} of the 
#' \linkS4class{SingleCellExperiment} and \linkS4class{SpatialExperiment} 
#' objects. For instance, the tumor grades can be retrieved with 
#' \code{colData(sce)$tumor_grade}.
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
#'     \item \code{`images_basel`}: size in memory = 19 Gb, 
#'     size on disk = 2.0 Gb.
#'     \item \code{`masks_basel`}: size in memory = 433 Mb, 
#'     size on disk = 10 Mb.
#'     \item \code{`sce_basel`}: size in memory = 513 Mb, 
#'     size on disk = 270 Mb.
#'     \item \code{`images_zurich`}: size in memory = 6.0 Gb, 
#'     size on disk = 724 Mb.
#'     \item \code{`masks_zurich`}: size in memory = 137 Mb, 
#'     size on disk = 3.4 Mb.
#'     \item \code{`sce_zurich`}: size in memory = 188 Mb, 
#'     size on disk = 105 Mb.
#'     \item \code{`masks_full`}: size in memory = 2.1 Gb, 
#'     size on disk = 10 Mb.
#'     \item \code{`sce_full`}: size in memory = 2.2 Gb, 
#'     size on disk = 1.2 Gb.
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
#' \linkS4class{SpatialExperiment} object with single cell data, a 
#' \linkS4class{CytoImageList} object containing multichannel images, or a
#' \linkS4class{CytoImageList} object containing cell segmentation masks.
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
#' sce <- JacksonFischer_2020_BreastCancer(data_type = "sce")
#' print(sce)
#' 
#' # Display metadata
#' JacksonFischer_2020_BreastCancer(data_type = "sce", metadata = TRUE)
#' 
#' # Load masks on disk
#' library(HDF5Array)
#' masks <- JacksonFischer_2020_BreastCancer(data_type = "masks", on_disk = 
#' TRUE, h5FilesPath = getHDF5DumpDir())
#' print(head(masks))
#' 
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
JacksonFischer_2020_BreastCancer <- function (
    data_type = c("sce", "spe", "images", "masks"),
    full_dataset = FALSE,
    cohort = "Basel",
    version = "latest",
    metadata = FALSE,
    on_disk = FALSE,
    h5FilesPath = NULL,
    force = FALSE
) {
    available_versions <- c("v0", "v1")
    dataset_name <- "JacksonFischer_2020_BreastCancer"
    dataset_version <- ifelse(version == "latest",
        utils::tail(available_versions, n=1), version)
    
    if (!cohort %in% c("Basel", "Zurich"))
        stop('"cohort" should be either "Basel" or "Zurich"')
    
    .checkArguments(data_type, metadata, dataset_version, available_versions,
        full_dataset, on_disk, h5FilesPath, force)
    
    if (cohort == "Zurich" & isFALSE(full_dataset))
        dataset_name <- paste(dataset_name, cohort, sep = "_")
    
    cur_dat <- .loadDataObject(data_type, metadata, dataset_name,
        dataset_version, full_dataset, on_disk, h5FilesPath, force)
    
    return(cur_dat)
}