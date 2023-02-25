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
            "Damond_2019_Pancreas - %s - %s%s",
            rep(c("sce", "images", "masks"), 3),
            rep(c(rep("v1", 2), "v0"), each = 3),
            rep(c("", " - full", ""), each = 3)),
        FunctionCall = sprintf(
            "Damond_2019_Pancreas(data_type = '%s",
            paste0(rep(c("sce'", "images'", "masks'"), 3),
                rep(c("", ", full_dataset = TRUE", ""), each = 3),
                rep(c(")", ")", ", dataset_version = 'v0')"), each = 3))),
        Description = sprintf(
            "%s (%s) for the Damond_2019_Pancreas IMC dataset",
            c("Single cell data", "Multichannel images", "Cell masks"),
            rep(c("subset", "full dataset", "subset"), each = 3)),
        BiocVersion = rep(c("3.16", "3.17", "3.13"), each = 3),
        DatasetVersion = rep(c(rep("v1", 2), "v0"), each = 3),
        SourceUrl = "http://dx.doi.org/10.17632/cydmwsfztj.2",
        SourceVersion = "Apr 04 2020",
        RDataClass = rep(c("SingleCellExperiment",
            rep("CytoImageList", 2)), 3),
        RDataPath = file.path(
            "imcdatasets", "Damond_2019_Pancreas",
            rep(c(rep("v1", 2), "v0"), each = 3),
            paste0(rep(c("sce", "images", "masks"), 3),
                rep(c("", "_full", ""), each = 3),
                rep(c(".rds"), 9))),
        DataType = rep(c("sce", "images", "masks"), 3),
        DatasetType = rep(c("matched subset", "full dataset",
            "matched subset"), each = 3),
        Notes = c("")
    ),
    
    # IMMUcan_2022_CancerExample
    data.frame(
        Title = sprintf(
            "IMMUcan_2022_CancerExample - %s - %s",
            rep(c("sce", "images", "masks")),
            rep(c("v1"), 1)),
        FunctionCall = sprintf(
            "IMMUcan_2022_CancerExample(data_type = '%s",
            paste0(rep(c("sce'", "images'", "masks'"), 1),
                rep(c(")"), each = 3))),
        Description = sprintf(
            "%s for the IMMUcan_2022_CancerExample IMC dataset",
            c("Single cell data", "Multichannel images", "Cell masks")),
        BiocVersion = rep(c("3.17"), each=3),
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
        DatasetType = rep(c("matched subset"), 3),
        Notes = c("")
    ),

    # JacksonFischer_2020_BreastCancer
    data.frame(
        Title = sprintf("JacksonFischer_2020_BreastCancer%s - %s - %s%s",
            rep(c("_Basel", "_Zurich", "", "", ""), each = 3),
            rep(c("sce", "images", "masks"), 5),
            rep(c("v2", "v2", "v2", "v1", "v0"), each = 3),
            rep(c("", "", " - full", "", ""), each = 3)),
        FunctionCall = sprintf(
            "JacksonFischer_2020_BreastCancer(data_type = '%s'%s%s%s)",
            rep(c("sce", "images", "masks"), 5),
            rep(c("", ", cohort = 'Zurich'", "", "", ""), each = 3),
            rep(c("", "", ", full_dataset = TRUE", "", ""), each = 3),
            rep(c("", "", "", ", dataset_version = 'v1'",
                ", dataset_version = 'v0'"), each = 3)),
        Description = sprintf(
            "%s (%s) for the JacksonFischer_2020_BreastCancer IMC dataset",
            rep(c("Single cell data", "Multichannel images", "Cell masks"), 5),
            rep(c("Basel cohort subset", "Zurich cohort subset",
                "full dataset", "Basel cohort subset",
                "Basel cohort subset"), each=3)),
        BiocVersion = rep(c(rep("3.17", 3), "3.16", "3.13"), each = 3),
        DatasetVersion = rep(c(rep("v2", 3), "v1", "v0"), each = 3),
        SourceUrl = "https://doi.org/10.5281/zenodo.3518284",
        SourceVersion = "Nov 04 2019",
        RDataClass = rep(c("SingleCellExperiment",
            rep("CytoImageList", 2)), 5),
        RDataPath = file.path(
            "imcdatasets", "JacksonFischer_2020_BreastCancer",
            rep(c(rep("v2", 3), "v1", "v0"), each = 3),
            paste0(sprintf("%s%s%s",
                rep(c("sce", "images", "masks"), 5),
                rep(c("_basel", "_zurich", "", "", ""), each = 3),
                rep(c("", "", "_full", "", ""), each = 3)), ".rds")),
        DataType = rep(c("sce", "images", "masks"), 5),
        DatasetType = rep(c("matched subset", "matched subset",
            "full dataset", "matched subset",
            "matched subset"), each = 3),
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
        DatasetType = rep(c("full and matched dataset"), 6),
        Notes = c("")
    )
)

# Combine all datasets
dfs <- lapply(df_list, cbind, df_base)
dfs <- do.call(rbind, dfs)
dfs <- dfs[!(dfs$DataType == "images" & dfs$DatasetType == "full dataset"), ]

# Save as .csv file
filename <- file.path(".", "inst", "extdata", "metadata.csv")
write.csv(dfs, file = filename, row.names = FALSE)
