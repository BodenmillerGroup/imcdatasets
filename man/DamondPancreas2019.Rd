\name{DamondPancreas2019-deprecated}
\alias{DamondPancreas2019_sce-deprecated}
\alias{DamondPancreas2019_images-deprecated}
\alias{DamondPancreas2019_masks-deprecated}
\docType{data}
\title{Deprecated function - 'DamondPancreas2019' dataset}
\description{
These functions are provided for compatibility with older versions of 
\sQuote{imcdatasets} only, and will be defunct at the next release.
This dataset consists of three data objects: single cell data, multichannel 
images and cell segmentation masks. The data was obtained by imaging mass 
cytometry of human pancreas sections from donors with type 1 diabetes.
}
\details{
This is an Imaging Mass Cytometry (IMC) dataset from Damond et al. (2019), 
consisting of three data objects. Note: The following functions are deprecated 
and will be made defunct; use the replacements indicated below:
\itemize{
    \item{DamondPancreas2019_images -> 
    \code{\link{Damond_2019_Pancreas}}} contains a hundred 38-channel images in 
    the form of a \linkS4class{CytoImageList} class object.
    \item{DamondPancreas2019_masks -> 
    \code{\link{Damond_2019_Pancreas}}} contains the cell segmentation masks 
    associated with the images, in the form of a \linkS4class{CytoImageList} 
    class object.
    \item{DamondPancreas2019_sce -> 
    \code{\link{Damond_2019_Pancreas}}} contains the single cell data extracted 
    from the images using the cellsegmentation masks, as well as the associated 
    metadata, in the form of a \linkS4class{SingleCellExperiment}. This 
    represents a total of 252,059 cells x 38 channels.
}

All data are downloaded from ExperimentHub and cached for local re-use.  

Mapping between the three data objects is performed via variables located in 
their metadata columns: \code{mcols()} for the \linkS4class{CytoImageList} 
objects and \code{ColData()} for the \linkS4class{SingleCellExperiment} 
object. Mapping at the image level can be performed with the 
\code{ImageName} or \code{ImageNumber} variables. Mapping between cell 
segmentation masks and single cell data is performed with the 
\code{CellNumber} variable, the values of which correspond to the intensity
values of the \code{DamondPancreas2019_masks} object. For practical
examples, please refer to the "Accessing IMC datasets" vignette.

This dataset is a subset of the complete Damond et al. (2019) dataset 
comprising the data from three pancreas donors at different stages of type 1 
diabetes (T1D). The three donors present clearly diverging characteristics in
terms of cell type composition and cell-cell interactions, which makes this
dataset ideal for benchmarking spatial and neighborhood analysis algorithms. 

The \code{assay} slot of the \linkS4class{SingleCellExperiment} object 
contains two assays:
\itemize{
    \item \code{counts} contains mean ion counts per cell.
    \item \code{exprs} contains arsinh-transformed counts, with cofactor 1.
}

The marker-associated metadata, including antibody information and metal tags 
are stored in the \code{rowData} of the \linkS4class{SingleCellExperiment} 
object.

The cell-associated metadata are stored in the \code{colData} of the 
\linkS4class{SingleCellExperiment} object. These metadata include cell types 
(in \code{colData(sce)$CellType}) and broader cell categories, such  as 
"immune" or "islet" cells (in \code{colData(sce)$CellCat}). In addition, 
for cells located inside pancreatic islets, the islet they belong to is 
indicated in \code{colData(sce)$ParentIslet}. For cells not located in 
islets, the "ParentIslet" value is set to 0 but the spatially closest islet
can be identified with \code{colData(sce)$ClosestIslet}.

The donor-associated metadata are also stored in the \code{colData} of the
\linkS4class{SingleCellExperiment} object. For instance, the donors' IDs can
be retrieved with \code{colData(sce)$case} and the donors' disease stage can 
be obtained with \code{colData(sce)$stage}.

The three donors present the following characteristics:
\itemize{
    \item \code{6126} is a non-diabetic donor, with large islets containing
    many beta cells, severe infiltration of the exocrine pancreas with 
    myeloid cells but limited infiltration of islets.
    \item \code{6414} is a donor with recent T1D onset (shortly after
    diagnosis) showing partial beta cell destruction and mild infiltration of
    islets with T cells.
    \item \code{6180} is a donor with long-duration T1D (11 years after
    diagnosis), showing near-total beta cell destruction and limited immune 
    cell infiltration in both the islets and the pancreas.
}

File sizes:
\itemize{
    \item \code{`images`}: size in memory = 7.4 Gb, size on disk = 1780 Mb.
    \item \code{`masks`}: size in memory = 200.0 Mb, size on disk = 8.6 Mb.
    \item \code{`sce`}: size in memory = 248.6 Mb, size on disk = 145 Mb.
}

Original source: Damond et al. (2019): 
https://doi.org/10.1016/j.cmet.2018.11.014

Original link to raw data, also containing the entire dataset:
https://data.mendeley.com/datasets/cydmwsfztj/2
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
sce <- DamondPancreas2019Data(data_type = "sce")
sce
images <- DamondPancreas2019Data(data_type = "images")
head(images)
masks <- DamondPancreas2019Data(data_type = "masks")
head(masks)
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