.onLoad <- function(libname, pkgname) {
  .Deprecated(
    msg = "The .onLoad functions will be deprecated, please use the wrapper 
    functions instead (e.g. 'JacksonFischer2020Data(data_type = 'sce')'
    rather than 'JacksonFischer2020_sce()'"
  )
  
  fl <- system.file("extdata", "metadata.csv", package = "imcdatasets")
  titles <- read.csv(fl, stringsAsFactors = FALSE)$Title
  ExperimentHub::createHubAccessors(pkgname, titles)
}