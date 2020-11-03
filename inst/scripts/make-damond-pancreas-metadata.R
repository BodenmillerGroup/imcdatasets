meta <- data.frame(
    Title = sprintf("Damond Pancreas %s", c("single cell data", "multichannel images", "cell masks")),
    Description = sprintf("%s for the Damond pancreas imaging mass cytometry dataset",
                          c("Single cell data", "Multichannel images", "Cell masks")),
    BiocVersion = rep("3.13", 3),
    Genome = NA,
    SourceType = rep("Zip", 3),
    SourceUrl = rep("http://dx.doi.org/10.17632/cydmwsfztj.2", 3),
    SourceVersion = "Apr 04 2020",
    Species = "Homo sapiens",
    TaxonomyId = 9606,
    Coordinate_1_based = NA,
    DataProvider = "University of Zurich",
    Maintainer = "Nicolas Damond <nicolas.damond@dqbm.uzh.ch>",
    RDataClass = c("SingleCellExperiment", rep("CytoImageList", 2)) ,
    DispatchClass = rep("Rds", 3),
    # RDataPath = c(paste0("imcdatasets/damond-pancreas", c("sce.rds", "images.rds", "masks.rds"))),
    Location_Prefix = "https://drive.switch.ch/index.php/",
    RDataPath = c(paste0("s/", c("CAbnHjwJOwRnOS4", "iJxY21xV3X0XyDZ", "LvRRTtCtnUWvfBS"))),
    Data_Type = c("sce", "images", "masks"),
    Tags = "",
    Notes = c("","","")
)

write.csv(meta, file="inst/extdata/metadata-damond-pancreas.csv", row.names=FALSE)
