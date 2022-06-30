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

  # DamondPancreas2019
  data.frame(
    Title = sprintf("DamondPancreas2019_%s", c("sce", "images", "masks")),
    FunctionCall = sprintf("DamondPancreas2019Data(data_type = '%s",
     c("sce')", "images')", "masks')")),
     Description = sprintf(
       "%s for the DamondPancreas2019 imaging mass cytometry dataset",
       c("Single cell data", "Multichannel images", "Cell masks")),
     BiocVersion = rep("3.13", 3),
     SourceType = rep("Zip", 3),
     SourceUrl = rep("http://dx.doi.org/10.17632/cydmwsfztj.2", 3),
     SourceVersion = "Apr 04 2020",
     RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)),
     RDataPath = file.path("imcdatasets", "damond-pancreas-2019",
                           c("sce.rds", "images.rds", "masks.rds")),
     DataType = c("sce", "images", "masks"),
     Notes = c("","","")
   ),

   # JacksonFischer2020
   data.frame(
    Title = sprintf("JacksonFischer2020_%s", c("sce", "images", "masks")),
    FunctionCall = sprintf("JacksonFischer2020Data(data_type = '%s",
                           c("sce')", "images')", "masks')")),
    Description = sprintf(
        "%s for the JacksonFischer2020 imaging mass cytometry dataset",
        c("Single cell data", "Multichannel images", "Cell masks")),
    BiocVersion = rep("3.13", 3),
    SourceType = rep("Zip", 3),
    SourceUrl = rep("https://doi.org/10.5281/zenodo.3518284", 3),
    SourceVersion = "Nov 04 2019",
    RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)),
    RDataPath = file.path("imcdatasets", "jackson-fischer-2020",
                          c("sce.rds", "images.rds", "masks.rds")),
    DataType = c("sce", "images", "masks"),
    Notes = c("","","")
  ),

  # ZanotelliSpheroids2020
  data.frame(
    Title = sprintf("ZanotelliSpheroids2020_%s", c("sce", "images", "masks")),
    FunctionCall = sprintf("ZanotelliSpheroids2020Data(data_type = '%s",
                           c("sce')", "images')", "masks')")),
    Description = sprintf(
        "%s for the ZanotelliSpheroids2020 imaging mass cytometry dataset",
        c("Single cell data", "Multichannel images", "Cell masks")),
    BiocVersion = rep("3.13", 3),
    SourceType = rep("Zip", 3),
    SourceUrl = rep("https://zenodo.org/record/4271910#.YGWR_T8kz-i", 3),
    SourceVersion = "Aug 20 2020",
    RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)),
    RDataPath = file.path("imcdatasets", "zanotelli-spheroids-2020",
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
