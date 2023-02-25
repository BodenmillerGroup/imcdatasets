# Argument check for wrapper functions
.checkArguments <- function(data_type, metadata, dataset_version,
    available_versions, full_dataset, on_disk, h5FilesPath, force
) {
    if (length(data_type) != 1) {
        stop('The data_type argument should be of length 1.')
    }
    
    if (!(data_type %in% c("sce", "spe", "images", "masks"))) {
        stop('The data_type argument should be "sce", "spe", "images", or "masks".')
    }
    
    if (!(isTRUE(metadata) | isFALSE(metadata))) {
        stop('"metadata" should be either TRUE or FALSE')
    }
    
    if (!(isTRUE(full_dataset) | isFALSE(full_dataset))) {
        stop('"full_dataset" should be either TRUE or FALSE')
    }
    
    if (length(dataset_version) != 1) {
        stop('The version argument should be of length 1.')
    }
    
    if (!(dataset_version %in% available_versions)) {
        stop('"version" should be "latest" or one of the available dataset versions, e.g., "v1".')
    }
    
    if (data_type == "spe" & dataset_version == "v0") {
        stop('It is only possible to retrieve SPE objects with dataset versions >= v1.')
    }
    
    if (full_dataset == TRUE & data_type == "images") {
        stop('Full datasets are only available for masks and single cell data.')
    }
    
    if (full_dataset == TRUE & dataset_version == "v0") {
        stop('Full datasets are only available for dataset versions >= v1.')
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
                "When storing the images on disk, please specify a 
                'h5FilesPath'.\n", "You can use 'h5FilesPath = getHDF5DumpDir()'
                to temporarily store the images.\n", "If doing so, .h5 files 
                will be deleted once the R session ends.")
        }
    }
}

# Load data objects
.loadDataObject <- function(data_type, metadata, dataset_name, dataset_version,
    full_dataset, on_disk, h5FilesPath, force
) {
    ## Load queried dataset
    eh <- ExperimentHub()
    if (grepl("spe", data_type)) {
        title <- paste(dataset_name, gsub("spe", "sce", data_type), 
            dataset_version, sep = " - ")
    } else {
        title <- paste(dataset_name, data_type, dataset_version, sep = " - ")
    }
    
    if (isTRUE(full_dataset))
        title <- paste(title, "full", sep = " - ")
    
    object_id <- eh[eh$title == title]$ah_id

    if (metadata) {
        cur_dat <- eh[object_id]
        return(cur_dat)
    } else {
        cur_dat <- eh[[object_id]]
    }
    
    if (data_type == "spe")
        cur_dat <- .SCEtoSPE(cur_dat)
    
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

# Convert SCE to SPE
.SCEtoSPE <- function(exp_object) {
    if (is(exp_object,  "SingleCellExperiment")) {
        exp_object <- SpatialExperiment::toSpatialExperiment(
            exp_object,
            sample_id = "image_name",
            spatialCoordsNames = c("cell_x", "cell_y")
        )
    }
    
    if (length(altExpNames(exp_object)) > 0) {
        alt_exps <- altExps(exp_object)
        alt_exps_spe <- lapply(alt_exps, .SCEtoSPE)
        altExps(exp_object) <- alt_exps_spe
    }

    return(exp_object)
}