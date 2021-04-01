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

# ------------
# JacksonFischer2020
# ------------
df_JacksonFischer2020 <- cbind(
    df_base,
    Title = sprintf("JacksonFischer2020_%s", c("sce", "images", "masks")),
    Description = sprintf(
        "%s for the JacksonFischer2020 imaging mass cytometry dataset",
        c("Single cell data", "Multichannel images", "Cell masks")),
    BiocVersion = rep("3.13", 3),
    SourceType = rep("Zip", 3),
    SourceUrl = rep("https://doi.org/10.5281/zenodo.3518284", 3),
    SourceVersion = "Nov 04 2019",
    Species = "Homo sapiens",
    TaxonomyId = 9606,
    Coordinate_1_based = NA,
    DataProvider = "University of Zurich",
    Maintainer = "Jana Fischer <jana.fischer@dqbm.uzh.ch>",
    RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)),
    RDataPath = file.path("imcdatasets", "jackson-fischer-2020",
                          c("sce.rds", "images.rds", "masks.rds")),
    DataType = c("sce", "images", "masks"),
    Notes = c("","","")
)

# ------------
# ZanotelliSpheroids2020
# ------------
df_ZanotelliSpheroids2020 <- cbind(
    df_base,
    Title = sprintf("ZanotelliSpheroids2020_%s", c("sce", "images", "masks")),
    Description = sprintf(
        "%s for the ZanotelliSpheroids2020 imaging mass cytometry dataset",
        c("Single cell data", "Multichannel images", "Cell masks")),
    BiocVersion = rep("3.13", 3),
    SourceType = rep("Zip", 3),
    SourceUrl = rep("https://zenodo.org/record/4271910#.YGWR_T8kz-i", 3),
    SourceVersion = "Aug 20 2020",
    Species = "Homo sapiens",
    TaxonomyId = 9606,
    Coordinate_1_based = NA,
    DataProvider = "University of Zurich",
    Maintainer = "Vito RT Zanotelli <Vito Zanotelli <vito.zanotelli@uzh.ch>",
    RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)),
    RDataPath = file.path("imcdatasets", "zanotelli-spheroids-2020",
                          c("sce.rds", "images.rds", "masks.rds")),
    DataType = c("sce", "images", "masks"),
    Notes = c("","","")
)

# ---------------------------------
# Combine for all datasets and save
# ---------------------------------

# Combine all datasets
df_all <- rbind(
    df_DamondPancreas2019, df_JacksonFischer2020, df_ZanotelliSpheroids2020
)

# Save as .csv file
write.csv(df_all,
          file = file.path(".", "inst", "extdata", "metadata.csv"),
          row.names = FALSE)
