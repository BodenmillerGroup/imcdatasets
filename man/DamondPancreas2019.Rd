\name{DamondPancreas2019}
\alias{DamondPancreas2019_sce}
\alias{DamondPancreas2019_images}
\alias{DamondPancreas2019_masks}
\docType{data}
\title{'DamondPancreas2019' dataset}
\description{
This dataset consists of three data objects: single cell data, multichannel 
images and cell masks. The data was obtained by imaging mass cytometry of human 
pancreas sections from donors with type 1 diabetes.
}
\details{
The dataset contains three data objects corresponding to 100 multichannel 
images, the associated cell masks and single cell data.
All data are downloaded from ExperimentHub and cached for local re-use.
}
\usage{
DamondPancreas2019_sce(metadata = FALSE)
DamondPancreas2019_images(metadata = FALSE)
DamondPancreas2019_masks(metadata = FALSE)
}
\arguments{
\item{metadata}{\code{logical} value indicating whether ExperimentHub metadata 
(describing the overall dataset) should be returned only, or if the whole 
dataset should be loaded. Default = FALSE, which loads the whole dataset.}
}
\examples{
DamondPancreas2019_sce()
DamondPancreas2019_images()
DamondPancreas2019_masks()
}
\value{
Returns a \code{\linkS4class{SingleCellExperiment}} or 
\code{\linkS4class{CytoImageList}} object.
}
\source{
\href{https://doi.org/10.1016/j.cmet.2018.11.014}{Publication}
\href{http://dx.doi.org/10.17632/cydmwsfztj.2}{Original dataset}
}
\references{
Damond N et al. (2019).
A Map of Human Type 1 Diabetes Progression by Imaging Mass Cytometry.
\emph{Cell Metab} 29(3), 755-768.
}
\author{Nicolas Damond}
\keyword{datasets}