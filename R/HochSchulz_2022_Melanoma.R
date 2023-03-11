#' Obtain the HochSchulz_2022_Melanoma dataset
#'
#' Obtain the HochSchulz_2022_Melanoma dataset, which is composed of two 
#' panels (rna and protein) that were acquired on consecutive sections. Each 
#' dataset (panel) is composed of three data objects: single cell data, 
#' multichannel images and cell segmentation masks.
#' The data was obtained by imaging mass cytometry (IMC) of a tissue microarray
#' (TMA) with multiple cores of formalin-fixed paraffin-embedded (FFPE) tissue
#' from 69 patients with metastatic melanoma.
#'
#' @param data_type type of object to load, `images` for multichannel images or
#' `masks` for cell segmentation masks. Single cell data are retrieved using 
#' either `sce` for the \code{SingleCellExperiment} format or `spe` for the  
#' \code{SpatialExperiment} format.
#' @param panel which panel should be returned? Can be set to "rna" (default) 
#' or "protein".
#' @param full_dataset if FALSE (default), a subset corresponding to the 50 
#' images containing the most B cells is returned. If TRUE, the full dataset 
#' (corresponding to 166 images) is returned. Due to memory space limitations, 
#' this option is only available for single cell data and masks, not for 
#' \code{data_type = "images"}.
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
#' This is an Imaging Mass Cytometry (IMC) dataset from Hoch, Schulz et al. 
#' (2022):
#' \itemize{
#'     \item \code{images} contains fifty 38-channel
#'     images in the form of a \linkS4class{CytoImageList} class object.
#'     \item \code{masks} contains the cell segmentation
#'     masks associated with the images, in the form of a
#'     \linkS4class{CytoImageList} class object.
#'     \item \code{sce} contains the single cell data extracted from the 
#'     multichannel images using the cell segmentation masks, as well as the 
#'     associated metadata, in the form of a 
#'     \linkS4class{SingleCellExperiment} object.
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
#' The \code{assay} slots of the \linkS4class{SingleCellExperiment} and 
#' \linkS4class{SpatialExperiment} objects contain three assays:
#' \itemize{
#'     \item \code{counts} contains raw mean ion counts per cell.
#'     \item \code{exprs} contains arsinh-transformed counts, with cofactor 1.
#'     \item \code{scaled_counts} contains scaled counts.
#'     \item \code{scaled_exprs} contains scaled asinh-transformed counts.
#' }
#'
#' The marker-associated metadata, including antibody information and metal 
#' tags are stored in the \code{rowData} of the 
#' \linkS4class{SingleCellExperiment} / \linkS4class{SpatialExperiment} 
#' objects.
#'
#' The cell-associated metadata are stored in the \code{colData} of the
#' \linkS4class{SingleCellExperiment} and \linkS4class{SpatialExperiment} 
#' objects. These metadata include various information about cells, milieu, 
#' samples, and patients. For instance, cell types can be retrieved with 
#' \code{colData(sce)$cell_type} and cell clusters with 
#' \code{colData(sce)$cell_cluster}. 
#' 
#' Neighborhood information, defined here as cells that are localized next to 
#' each other, is stored as a \code{SelfHits} object in the \code{colPairs} 
#' slot of the \code{SingleCellExperiment} and \linkS4class{SpatialExperiment} 
#' objects.
#'
#' For more information, please refer to the Hoch, Schulz, et al. publication.
#' 
#' Dataset versions: a \code{version} argument can be passed to the function to 
#' specify which dataset version should be retrieved.
#' \itemize{
#'     \item \code{`v1`}: first published version
#' }
#' 
#' File sizes:
#' \itemize{
#'     \item \code{`images_rna`}: size in memory = 13.9 Gb, 
#'     size on disk = 954 Mb.
#'     \item \code{`masks_rna`}: size in memory = 347 Mb, 
#'     size on disk = 11 Mb.
#'     \item \code{`sce_rna`}: size in memory = 774 Mb, 
#'     size on disk = 401 Mb.
#'     \item \code{`masks_full_rna`}: size in memory = 1.1 Gb, 
#'     size on disk = 30 Mb.
#'     \item \code{`sce_full_rna`}: size in memory = 2.0 Gb, 
#'     size on disk = 1.1 Gb.
#'     \item \code{`images_protein`}: size in memory = 16.8 Gb, 
#'     size on disk = 1.2 Gb.
#'     \item \code{`masks_protein`}: size in memory = 374 Mb, 
#'     size on disk = 12 Mb.
#'     \item \code{`sce_protein`}: size in memory = 856 Mb, 
#'     size on disk = 531 Mb.
#'     \item \code{`masks_full_protein`}: size in memory = 1.2 Gb, 
#'     size on disk = 35 Mb.
#'     \item \code{`sce_full_protein`}: size in memory = 2.2 Gb, 
#'     size on disk = 1.4 Gb.
#' }
#'
#' When storing images on disk, these need to be first fully read into memory
#' before writing them to disk. This means the process of downloading the data
#' is slower than directly keeping them in memory. However, downstream analysis
#' will lose its memory overhead when storing images on disk.
#'
#' Original source: Hoch, Schulz et al. (2022):
#' https://doi.org/10.1126/sciimmunol.abk1692
#'
#' Original link to raw data: https://doi.org/10.5281/zenodo.5994136.
#'
#' @return A \linkS4class{SingleCellExperiment} object with single cell data, a
#' \linkS4class{SpatialExperiment} object with single cell data, a 
#' \linkS4class{CytoImageList} object containing multichannel images, or a
#' \linkS4class{CytoImageList} object containing cell segmentation masks.
#'
#' @author Nicolas Damond
#'
#' @references
#' Hoch, Schulz et al. (2022). Multiplexed imaging mass cytometry of the 
#' chemokine milieus in melanoma characterizes features of the response to 
#' immunotherapy \emph{Sci Immunol} 7(70):eabk1692.
#'
#' @examples
#' # Load single cell data
#' sce <- HochSchulz_2022_Melanoma(data_type = "sce")
#' print(sce)
#' 
#' # Display metadata
#' HochSchulz_2022_Melanoma(data_type = "sce", metadata = TRUE)
#' 
#' # Load masks on disk
#' library(HDF5Array)
#' masks <- HochSchulz_2022_Melanoma(data_type = "masks", on_disk = TRUE,
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
HochSchulz_2022_Melanoma <- function (
    data_type = c("sce", "spe", "images", "masks"),
    panel = "rna",
    full_dataset = FALSE,
    version = "latest",
    metadata = FALSE,
    on_disk = FALSE,
    h5FilesPath = NULL,
    force = FALSE
) {
    available_versions <- c("v1")
    dataset_name <- "HochSchulz_2022_Melanoma"
    dataset_version <- ifelse(version == "latest",
        utils::tail(available_versions, n=1), version)
    
    .checkArguments(data_type, metadata, dataset_version, available_versions,
        full_dataset, on_disk, h5FilesPath, force)
    
    if (!panel %in% c("rna", "protein"))
        stop('"panel" should be either "rna" or "protein"')
    dataset_name_panel <- paste(dataset_name, panel, sep = " - ")
    
    cur_dat <- .loadDataObject(data_type, metadata, dataset_name_panel,
        dataset_version, full_dataset, on_disk, h5FilesPath, force)
    
    return(cur_dat)
}