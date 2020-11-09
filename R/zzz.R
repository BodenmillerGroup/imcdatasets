.onLoad <- function(libname, pkgname) {
    fl <- system.file("extdata", "metadata.csv", package = "imcdatasets")
    titles <- read.csv(fl, stringsAsFactors = FALSE)$Title
    ExperimentHub::createHubAccessors(pkgname, titles)
}
