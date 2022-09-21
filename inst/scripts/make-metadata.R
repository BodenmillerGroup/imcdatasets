# Base metadata for all datasets

df_base <- data.frame(
    DispatchClass = "Rds",
    Genome = NA,
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
      Title = sprintf("Damond_2019_Pancreas_%s", c("sce", "images", "masks")),
      FunctionCall = sprintf("Damond_2019_Pancreas(data_type = '%s",
                             c("sce')", "images')", "masks')")),
      Description = sprintf(
          "%s for the Damond_2019_Pancreas imaging mass cytometry dataset",
          c("Single cell data", "Multichannel images", "Cell masks")),
      BiocVersion = rep("3.16", 3),
      DatasetVersion = rep("v1", 3),
      SourceType = rep("Zip", 3),
      SourceUrl = rep("http://dx.doi.org/10.17632/cydmwsfztj.2", 3),
      SourceVersion = "Apr 04 2020",
      RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)),
      RDataPath = file.path(
        "imcdatasets", "Damond_2019_Pancreas_v1",
        c("sce.rds", "images.rds", "masks.rds")),
      DataType = c("sce", "images", "masks"),
      Notes = c("","","")
    ),

    # JacksonFischer_2020_BreastCancer
    data.frame(
      Title = sprintf("JacksonFischer_2020_BreastCancer_%s",
                      c("sce", "images", "masks")),
      FunctionCall = sprintf("JacksonFischer_2020_BreastCancer(data_type = '%s",
                             c("sce')", "images')", "masks')")),
      Description = sprintf(
          "%s for the JacksonFischer_2020_BreastCancer imaging mass cytometry 
          dataset",
          c("Single cell data", "Multichannel images", "Cell masks")),
      BiocVersion = rep("3.16", 3),
      DatasetVersion = rep("v1", 3),
      SourceType = rep("Zip", 3),
      SourceUrl = rep("https://doi.org/10.5281/zenodo.3518284", 3),
      SourceVersion = "Nov 04 2019",
      RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)),
      RDataPath = file.path(
        "imcdatasets", "JacksonFischer_2020_BreastCancer_v1",
        c("sce.rds", "images.rds", "masks.rds")),
      DataType = c("sce", "images", "masks"),
      Notes = c("","","")
    ),

    # Zanotelli_2020_Spheroids
    data.frame(
      Title = sprintf("Zanotelli_2020_Spheroids_%s",
                      c("sce", "images", "masks")),
      FunctionCall = sprintf("Zanotelli_2020_Spheroids(data_type = '%s",
                             c("sce')", "images')", "masks')")),
      Description = sprintf(
          "%s for the Zanotelli_2020_Spheroids imaging mass cytometry dataset",
          c("Single cell data", "Multichannel images", "Cell masks")),
      BiocVersion = rep("3.16", 3),
      DatasetVersion = rep("v1", 3),
      SourceType = rep("Zip", 3),
      SourceUrl = rep("https://zenodo.org/record/4271910#.YGWR_T8kz-i", 3),
      SourceVersion = "Aug 20 2020",
      RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)),
      RDataPath = file.path(
        "imcdatasets", "Zanotelli_2020_Spheroids_v1",
        c("sce.rds", "images.rds", "masks.rds")),
      DataType = c("sce", "images", "masks"),
      Notes = c("","","")
    ),
    
    # IMMUcanExample2022
    data.frame(
        Title = sprintf("IMMUcanExample2022_%s", c("sce", "images", "masks")),
        FunctionCall = sprintf("IMMUcanExample2022Data(data_type = '%s",
                               c("sce')", "images')", "masks')")),
        Description = sprintf(
            "%s for the IMMUcanExample2022 imaging mass cytometry dataset",
            c("Single cell data", "Multichannel images", "Cell masks")),
        BiocVersion = rep("3.16", 3),
        SourceType = rep("RDS", 3),
        SourceUrl = rep("https://zenodo.org/record/6810879", 3),
        SourceVersion = "Sep 14 2022",
        RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)),
        RDataPath = file.path("imcdatasets", "immucan-example-2022",
                              c("sce.rds", "images.rds", "masks.rds")),
        DataType = c("sce", "images", "masks"),
        Notes = c("","","")
    )
)

# Combine all datasets
dfs <- lapply(df_list, cbind, df_base)
dfs <- do.call(rbind, dfs)

# Save as .csv file
filename <- file.path(".", "inst", "extdata", "metadata.csv")
write.csv(dfs, file = filename, row.names = FALSE)
