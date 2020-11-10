% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DamondPancreas2019Data.R
\name{DamondPancreas2019Data}
\alias{DamondPancreas2019Data}
\title{Obtain the damond-pancreas-2019 data}
\usage{
DamondPancreas2019Data(data_type)
}
\arguments{
\item{data_type}{type of data to load, should be `sce` for single cell data
(default), `images` for multichannel images or `masks` for cell masks.}
}
\value{
A \linkS4class{SingleCellExperiment} object with single cell data, a
\linkS4class{CytoImageList} object containing multichannel images, or a
\linkS4class{CytoImageList} object containing cell masks.
}
\description{
Obtain the human pancreas from donors with type 1 diabetes data from Damond
et al. (2019).
}
\details{
The dataset contains three types of data: single cell data in form of a
`SingleCellExperiment` object, multichannel images formatted into a
`CytoImageList` object and cell masks formatted into a `CytoImageList` 
object.

The value of \code{data_type} will retrieve different data sets.
\itemize{
\item \code{"sce"}, single cell data
\item \code{"images"}, 38-channel images.
\item \code{"masks"}, cell masks.
}

All data are downloaded from ExperimentHub and cached for local re-use.
}
\examples{
sce <- DamondPancreas2019Data(data_type = "sce")
images <- DamondPancreas2019Data(data_type = "images")
masks <- DamondPancreas2019Data(data_type = "masks")

}
\references{
Damond N et al. (2019).
A Map of Human Type 1 Diabetes Progression by Imaging Mass Cytometry.
\emph{Cell Metab} 29(3), 755-768.
}
\author{
Nicolas Damond
}