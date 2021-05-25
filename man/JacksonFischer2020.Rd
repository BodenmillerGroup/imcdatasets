\name{JacksonFischer2020}
\alias{JacksonFischer2020_sce}
\alias{JacksonFischer2020_images}
\alias{JacksonFischer2020_masks}
\docType{data}
\title{'JacksonFischer2020' dataset}
\description{
This dataset consists of three data objects: single cell data, multichannel 
images and cell segmentation masks. The data was obtained by imaging mass 
cytometry of tumour tissue from patients with breast cancer.
}
\details{
This is an Imaging Mass Cytometry (IMC) dataset from Jackson, Fischer et al.
(2020), consisting of three data objects:
\itemize{
    \item \code{JacksonFischer2020_images} contains a hundred 42-channel
    images in the form of a \linkS4class{CytoImageList} class object.
    \item \code{JacksonFischer2020_masks} contains the cell segmentation 
    masks associated with the images, in the form of a 
    \linkS4class{CytoImageList} class object.
    \item \code{JacksonFischer2020_sce} contains the single cell data 
    extracted from the images using the cell segmentation masks, as well as 
    the associated metadata, in the form of a 
    \linkS4class{SingleCellExperiment}. This represents a total of 285,851 cells
    x 42 channels.
}

All data are downloaded from ExperimentHub and cached for local re-use. 
Specific resources can be retrieved by searching for
\code{imcdatasets/JacksonFischer2020_sce}, 
\code{imcdatasets/JacksonFischer2020_images}, or 
\code{imcdatasets/JacksonFischer2020_masks}.

Mapping between the three data objects is performed via variables located in 
their metadata columns: \code{mcols()} for the \linkS4class{CytoImageList} 
objects and \code{ColData()} for the \linkS4class{SingleCellExperiment} object. 
Mapping at the image level can be performed with the \code{ImageNb} variable. 
Mapping between cell segmentation masks and single cell data is performed with
the \code{CellNb} variable, the values of which correspond to the intensity
values of the \code{JacksonFischer2020_masks} object. For practical examples,
please refer to the "Accessing IMC datasets" vignette.

This dataset is a subset of the complete Jackson, Fischer et al. (2020) dataset comprising the data from tumour tissue from 100 patients with breast cancer
(one image per patient).

The \code{assay} slot of the \linkS4class{SingleCellExperiment} object 
contains three assays:
\itemize{
    \item \code{counts} contains mean ion counts per cell.
    \item \code{exprs} contains arsinh-transformed counts, with cofactor 1.
    \item \code{quant_norm} contains quantile-normalized counts (0 to 1, 99th 
    percentile).
}

The marker-associated metadata, including antibody information and metal tags 
are stored in the \code{rowData} of the \linkS4class{SingleCellExperiment} 
object.

The cell-associated metadata are stored in the \code{colData} of the 
\linkS4class{SingleCellExperiment} object. These metadata include clusters (in \code{colData(sce)$PhenoGraphBasel}) and metaclusters (in 
\code{colData(sce)$metacluster}), as well as spatial information (e.g., cell 
areas are stored in \code{colData(sce)$Area}).

The patient-associated clinical data are also stored in the \code{colData} of
the \linkS4class{SingleCellExperiment} object. For instance, the tumor grades
can be retrieved with \code{colData(sce)$grade}.

File sizes:
\itemize{
    \item \code{`JacksonFischer2020_images`}: size in memory = 17.8 Gb, size 
    on disk = 1996 Mb.
    \item \code{`JacksonFischer2020_masks`}: size in memory = 433 Mb, size 
    on disk = 10.2 Mb.
    \item \code{`JacksonFischer2020_sce`}: size in memory = 517 Mb, size on
    disk = 272 Mb.
}

Original source: Jackson, Fischer et al. (2020): 
https://doi.org/10.1038/s41586-019-1876-x

Original link to raw data, also containing the entire dataset:
https://doi.org/10.5281/zenodo.3518284
}
\usage{
JacksonFischer2020_sce(metadata = FALSE)
JacksonFischer2020_images(metadata = FALSE)
JacksonFischer2020_masks(metadata = FALSE)
}
\arguments{
\item{metadata}{\code{logical} value indicating whether ExperimentHub metadata 
(describing the overall dataset) should be returned only, or if the whole 
dataset should be loaded. Default = FALSE, which loads the whole dataset.}
}
\examples{
sce <- JacksonFischer2020Data(data_type = "sce")
sce
images <- JacksonFischer2020Data(data_type = "images")
head(images)
masks <- JacksonFischer2020Data(data_type = "masks")
head(masks)
}
\value{
Returns a \code{\linkS4class{SingleCellExperiment}} object with single cell 
data, a \code{\linkS4class{CytoImageList}} object containing multichannel 
images, or a \linkS4class{CytoImageList} object containing cell masks.
}
\source{
\href{https://doi.org/10.1038/s41586-019-1876-x}{Publication}
\href{https://doi.org/10.5281/zenodo.3518284}{Original dataset}
}
\references{
Jackson, Fischer et al. (2020).
The single-cell pathology landscape of breast cancer.
\emph{Nature} 578(7796), 615-620.
}
\author{Jana Fischer}
\keyword{datasets}