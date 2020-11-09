# ------------------------------
# Base metadata for all datasets
# ------------------------------

df_base <- data.frame(
    DispatchClass = "Rds",
    Genome = NA,
    stringsAsFactors = FALSE
)

# ------------
# DamondPancreas2019
# ------------
df_DamondPancreas2019 <- cbind(
    df_base,
    Title = sprintf("DamondPancreas2019_%s", c("sce", "images", "masks")),
    Description = sprintf(
        "%s for the DamondPancreas2019 imaging mass cytometry dataset",
        c("Single cell data", "Multichannel images", "Cell masks")),
    BiocVersion = rep("3.13", 3),
    SourceType = rep("Zip", 3),
    SourceUrl = rep("http://dx.doi.org/10.17632/cydmwsfztj.2", 3),
    SourceVersion = "Apr 04 2020",
    Species = "Homo sapiens",
    TaxonomyId = 9606,
    Coordinate_1_based = NA,
    DataProvider = "University of Zurich",
    Maintainer = "Nicolas Damond <nicolas.damond@dqbm.uzh.ch>",
    RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)),
    RDataPath = file.path("imcdatasets", "damond-pancreas-2019",
                          c("sce.rds", "images.rds", "masks.rds")),
    DataType = c("sce", "images", "masks"),
    Notes = c("","","")
)


# ---------------------------------
# Combine for all datasets and save
# ---------------------------------

# Combine all datasets
df_all <- rbind(
    df_DamondPancreas2019
)

# Save as .csv file
write.csv(df_all,
          file = "../extdata/metadata.csv",
          row.names = FALSE)
