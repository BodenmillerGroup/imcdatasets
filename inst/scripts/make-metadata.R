# Base metadata for all datasets

df_base <- data.frame(
    SourceType = "Zip",
    DispatchClass = "Rds",
    Genome = NA,
    Coordinate_1_based = NA,
    Species = "Homo sapiens",
    TaxonomyId = 9606,
    DataProvider = "University of Zurich",
    Maintainer = "Nicolas Damond <nicolas.damond@dqbm.uzh.ch>",
    stringsAsFactors = FALSE
)

# Dataset-specific metadata
df_list <- list(
    
    # Damond_2019_Pancreas
    data.frame(
        Title = sprintf(
            "Damond_2019_Pancreas - %s",
            paste(c("sce", "images", "masks"),
                  rep(c("v1", "v0"), each = 3), sep = " - ")),
        FunctionCall = sprintf(
            "Damond_2019_Pancreas(data_type = '%s",
            paste0(rep(c("sce'", "images'", "masks'"), 2),
                   rep(c(")", ", dataset_version = 'v0')"), each = 3))),
        Description = rep(sprintf(
            "%s for the Damond_2019_Pancreas IMC dataset",
            c("Single cell data", "Multichannel images", "Cell masks")), 2),
        BiocVersion = rep(c("3.16", "3.13"), each=3),
        DatasetVersion = rep(c("v1", "v0"), each=3),
        SourceUrl = "http://dx.doi.org/10.17632/cydmwsfztj.2",
        SourceVersion = "Apr 04 2020",
        RDataClass = rep(c("SingleCellExperiment",
                           rep("CytoImageList", 2)), 2),
        RDataPath = file.path(
            "imcdatasets", "Damond_2019_Pancreas",
            rep(c("v1", "v0"), each = 3),
            rep(c("sce.rds", "images.rds", "masks.rds"), 2)),
        DataType = rep(c("sce", "images", "masks"), 2),
        Notes = c("")
    ),
    
    # JacksonFischer_2020_BreastCancer
    data.frame(
        Title = sprintf(
            "JacksonFischer_2020_BreastCancer - %s",
            paste(c("sce", "images", "masks"),
                  rep(c("v1", "v0"), each = 3), sep = " - ")),
        FunctionCall = sprintf(
            "JacksonFischer_2020_BreastCancer(data_type = '%s",
            paste0(rep(c("sce'", "images'", "masks'"), 2),
                   rep(c(")", ", dataset_version = 'v0')"), each = 3))),
        Description = rep(sprintf(
            "%s for the JacksonFischer_2020_BreastCancer IMC dataset",
            c("Single cell data", "Multichannel images", "Cell masks")), 2),
        BiocVersion = rep(c("3.16", "3.13"), each=3),
        DatasetVersion = rep(c("v1", "v0"), each=3),
        SourceUrl = "https://doi.org/10.5281/zenodo.3518284",
        SourceVersion = "Nov 04 2019",
        RDataClass = rep(c("SingleCellExperiment",
                           rep("CytoImageList", 2)), 2),
        RDataPath = file.path(
            "imcdatasets", "JacksonFischer_2020_BreastCancer",
            rep(c("v1", "v0"), each = 3),
            rep(c("sce.rds", "images.rds", "masks.rds"), 2)),
        DataType = rep(c("sce", "images", "masks"), 2),
        Notes = c("")
    ),
    
    # Zanotelli_2020_Spheroids
    data.frame(
        Title = sprintf(
            "Zanotelli_2020_Spheroids - %s",
            paste(c("sce", "images", "masks"),
                  rep(c("v1", "v0"), each = 3), sep = " - ")),
        FunctionCall = sprintf(
            "Zanotelli_2020_Spheroids(data_type = '%s",
            paste0(rep(c("sce'", "images'", "masks'"), 2),
                   rep(c(")", ", dataset_version = 'v0')"), each = 3))),
        Description = rep(sprintf(
            "%s for the Zanotelli_2020_Spheroids IMC dataset",
            c("Single cell data", "Multichannel images", "Cell masks")), 2),
        BiocVersion = rep(c("3.16", "3.13"), each=3),
        DatasetVersion = rep(c("v1", "v0"), each=3),
        SourceUrl = "https://zenodo.org/record/4271910#.YGWR_T8kz-i",
        SourceVersion = "Aug 20 2020",
        RDataClass = rep(c("SingleCellExperiment",
                           rep("CytoImageList", 2)), 2),
        RDataPath = file.path(
            "imcdatasets", "Zanotelli_2020_Spheroids",
            rep(c("v1", "v0"), each = 3),
            rep(c("sce.rds", "images.rds", "masks.rds"), 2)),
        DataType = rep(c("sce", "images", "masks"), 2),
        Notes = c("")
    ),
    
    # IMMUcan_2022_CancerExample
    data.frame(
        Title = sprintf(
            "IMMUcan_2022_CancerExample - %s",
            paste(c("sce", "images", "masks"),
                  rep(c("v1"), each = 3), sep = " - ")),
        FunctionCall = sprintf(
            "IMMUcan_2022_CancerExample(data_type = '%s",
            paste0(rep(c("sce'", "images'", "masks'"), 1),
                   rep(c(")"), each = 3))),
        Description = sprintf(
            "%s for the IMMUcan_2022_CancerExample IMC dataset",
            c("Single cell data", "Multichannel images", "Cell masks")),
        BiocVersion = rep(c("3.16"), each=3),
        DatasetVersion = rep(c("v1"), each=3),
        SourceUrl = "https://zenodo.org/record/6810879",
        SourceVersion = "Sep 14 2022",
        RDataClass = rep(c("SingleCellExperiment",
                           rep("CytoImageList", 2)), 1),
        RDataPath = file.path(
            "imcdatasets", "IMMUcan_2022_CancerExample",
            rep(c("v1"), each = 3),
            rep(c("sce.rds", "images.rds", "masks.rds"), 1)),
        DataType = rep(c("sce", "images", "masks"), 1),
        Notes = c("")
    )
)

# Combine all datasets
dfs <- lapply(df_list, cbind, df_base)
dfs <- do.call(rbind, dfs)

# Save as .csv file
filename <- file.path(".", "inst", "extdata", "metadata.csv")
write.csv(dfs, file = filename, row.names = FALSE)
