#' Obtain the jackson-fischer-2020 dataset
#'
#' Obtain the jackson-fischer-2020 dataset, which consists of three data
#' objects: single cell data, multichannel images and cell segmentation masks.
#' The data was obtained by imaging mass cytometry of tumour tissue from
#' patients with breast cancer.
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
#' This is an Imaging Mass Cytometry (IMC) dataset from Jackson, Fischer et al.
#' (2020), consisting of three data objects:
#' \itemize{
#'     \item \code{JacksonFischer2020_images} contains a hundred 42-channel
#'     images in the form of a \linkS4class{CytoImageList} class object.
#'     \item \code{JacksonFischer2020_masks} contains the cell segmentation
#'     masks associated with the images, in the form of a
#'     \linkS4class{CytoImageList} class object.
#'     \item \code{JacksonFischer2020_sce} contains the single cell data
#'     extracted from the images using the cell segmentation masks, as well as
#'     the associated metadata, in the form of a
#'     \linkS4class{SingleCellExperiment}. This represents a total of 285,851
#'     cells x 42 channels.
#' }
#'
#' All data are downloaded from ExperimentHub and cached for local re-use.
#' Specific resources can be retrieved by searching for
#' \code{imcdatasets/JacksonFischer2020_sce},
#' \code{imcdatasets/JacksonFischer2020_images}, or
#' \code{imcdatasets/JacksonFischer2020_masks}.
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
#'     \item \code{`JacksonFischer2020_images`}: size in memory = 17.8 Gb, size
#'     on disk = 1996 Mb.
#'     \item \code{`JacksonFischer2020_masks`}: size in memory = 433 Mb, size
#'     on disk = 10.2 Mb.
#'     \item \code{`JacksonFischer2020_sce`}: size in memory = 517 Mb, size on
#'     disk = 272 Mb.
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
#' sce <- JacksonFischer2020Data(data_type = "sce")
#' images <- JacksonFischer2020Data(data_type = "images")
#' masks <- JacksonFischer2020Data(data_type = "masks")
#'
#' @import cytomapper
#' @import methods
#' @importFrom utils download.file
#' @importFrom utils read.csv
#' @importFrom ExperimentHub ExperimentHub
#' @importFrom SingleCellExperiment SingleCellExperiment
#'
#' @export
JacksonFischer2020Data <- function(data_type = c("sce", "images", "masks"),
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

    dataset_name = "JacksonFischer2020"
    host <- file.path("imcdatasets", "jackson-fischer-2020")
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
