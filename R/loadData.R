# Argument check for wrapper functions
.checkArguments <- function(
    data_type, metadata, version, available_versions,
    on_disk, h5FilesPath, force
) {
    if(length(data_type) != 1) {
        stop('The data_type argument should be of length 1.')
    }
  
    if(!(data_type %in% c("sce", "images", "masks"))) {
        stop('The data_type argument should be "sce", "images" or "masks".')
    }
  
    if (!(isTRUE(metadata) | isFALSE(metadata))) {
        stop('"metadata" should be either TRUE or FALSE')
    }
  
    if(length(version) != 1) {
        stop('The version argument should be of length 1.')
    }
  
    if(!version %in% available_versions)) {
        stop('"version" should be "latest" or one of the available dataset
            versions, e.g., "v1".')
    }
  
    if (!(isTRUE(on_disk) | isFALSE(on_disk))) {
        stop('"on_disk" should be either TRUE or FALSE')
    }
  
    if (on_disk) {
        if (!data_type %in% c("images", "masks")) {
            stop('The "on_disk" option is only valid for images and masks.')
        }
        if (is.null(h5FilesPath)) {
            stop(
              "When storing the images on disk, please specify a 'h5FilesPath'.
              \n", "You can use 'h5FilesPath = getHDF5DumpDir()' to temporarily 
              store the images.\n", "If doing so, .h5 files will be deleted once
              the R session ends.")
        }
    }
}

# Load data objects
.loadDataObject <- function(
    dataset_name, host,
    data_type, metadata,
    on_disk, h5FilesPath, force
) {
  
    ## Load queried dataset
    eh <- ExperimentHub()
    title <- paste(dataset_name, data_type, sep = "_")
    object_id <- eh[eh$title == title]$ah_id
  
    if (metadata) {
        cur_dat <- eh[object_id]
        return(cur_dat)
    } else {
        cur_dat <- eh[[object_id]]
    }

    if (on_disk) {
        ## Check if files exist
        cur_files <- file.path(h5FilesPath, paste0(names(cur_dat), ".h5"))
    
        if (all(file.exists(cur_files)) & !force) {
            stop("All .h5 files already exist.",
            "Please specify 'force = TRUE' to overwrite existing files.")
        }
        cur_dat <- CytoImageList(cur_dat, on_disk = on_disk,
            h5FilesPath = h5FilesPath)
    }
    return(cur_dat)
}

# # Convert SCE to SPE
# .SCEtoSPE <- function(sce, dataset_name) {
#     # Load the SCE object
#     eh <- ExperimentHub()
#     title <- paste(dataset_name, "sce", sep = "_")
#     object_id <- eh[eh$title == title]$ah_id
#     spe <- eh[[object_id]]
#     
#     # Convert to SPE
#     spe <- as(spe, "SpatialExperiment")
#     spe$sample_id <- spe$image_number
#     spatialCoords(spe) <- as.matrix(
#         colData(spe)[, c("cell_x", "cell_y")])
#     spe$cell_x <- NULL
#     spe$cell_y <- NULL
# }