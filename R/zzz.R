.onLoad <- function(libname, pkgname) {
    .Deprecated(
        msg = ".onLoad functions will be deprecated, please use wrapper
        functions instead, e.g. 'JacksonFischer_2020_BreastCancer(data_type = 
        'sce')' rather than 'JacksonFischer2020_sce()'"
    )
    
    fl <- system.file("extdata", "metadata.csv", package = "imcdatasets")
    titles <- read.csv(fl, stringsAsFactors = FALSE)$Title
    ExperimentHub::createHubAccessors(pkgname, titles)
}
