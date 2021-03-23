# imcdatasets

## Introduction

The `imcdatasets` package is an extensible resource containing a set of publicly available Imaging Mass Cytometry datasets. Each dataset consists of three data objects:
1. Single cell data in the form of a `SingleCellExperiment` class object.
2. Multichannel images formatted into a `CytoImageList` class object.
3. Cell segmentation masks formatted into a `CytoImageList` class object.

These formats facilitate accession and integration into R/Bioconductor workflows. The data objects are hosted on Bioconductor's `ExperimentHub` platform.

## Requirements
The `imcdatasets` package requires R version >= 4.1.  
It builds on data objects contained in the [SingleCellExperiment](https://www.bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) and [cytomapper](https://www.bioconductor.org/packages/release/bioc/html/cytomapper.html) packages. These packages must, therefore, be installed (see below).

## Installation

The [release version](https://www.bioconductor.org/packages/release/bioc/html/imcdatasets.html) of `imcdatasets` can be installed by following standard `Bioconductor` package installation procedures:
```{r}
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("imcdatasets")
```

The [development version](https://github.com/BodenmillerGroup/imcdatasets) of `imcdatasets` can be installed from Github using `devtools` in R:
```{r}
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")
devtools::install_github("BodenmillerGroup/imcdatasets", build_vignettes = TRUE)
```

Installing the dependencies (if not already done):
```{r}
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("SingleCellExperiment", "cytomapper"))
```

Loading `imcdatasets` in your R session:
```{r}
library(imcdatasets)
```

## Usage

Detailed information on how to access the datasets is available in the `imcdatasets` vignette, which is available from `Bioconductor`: [Accessing IMC datasets](https://bioconductor.org/packages/devel/data/experiment/vignettes/imcdatasets/inst/doc/imcdatasets.html). It can also be viewed directly in R:
```{r}
vignette("imcdatasets")
```

## Details

The `imcdatasets` package provides quick and easy access to published and curated Imaging Mass Cytometry datasets. Each dataset consists of three data objects that can be retrieved individually:

1. __Single cell data__ in the form of a `SingleCellExperiment` class object:  
This object contain cell-level expression values and metadata. The `rowData` of the `SingleCellExperiment` objects contain marker information while the `colData` contain cell-level metadata, including _image numbers_. The `assay` slots contain marker expression per cell values: the `counts` assay contains mean ion counts whereas the other assay contain counts transformation(s) (details available in the documentation of each dataset).

2. __Multichannel images__ formatted into a `CytoImageList` class object.
This object contains multichannel images and metadata, including channel names and _image numbers_.

3. __Cell segmentation masks__ formatted into a `CytoImageList` class object.
This object contains single-channel images representing cell segmentation masks and metadata, including _image numbers_.

The three data objects can be mapped using the _image numbers_ contained in the metadata of each object. Details are available in the vignette (see above).

For more information about the `SingleCellExperiment` and `CytoImageList` objects, please refer to the [SingleCellExperiment](https://www.bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) and [cytomapper](https://www.bioconductor.org/packages/release/bioc/html/cytomapper.html) packages, respectively.

## Available datasets

Currently available datasets can be viewed with:
```{r}
imc <- imcdatasets::listDatasets()
imc <- as.data.frame(imc)
imc
```
Detailed information about each dataset is available in the help pages (e.g., `?DamondPancreas2019Data`).  

Alternately, available datasets can be viewed with [ExperimentHub](https://bioconductor.org/packages/release/bioc/html/ExperimentHub.html). This package can be installed and loaded as following:
```{r}
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ExperimentHub")
library(ExperimentHub)
```

View available datasets:
```{r}
eh = ExperimentHub()
query(eh, "imcdatasets")
```
For more information, please refer to the [ExperimentHub vignette](https://bioconductor.org/packages/release/bioc/vignettes/ExperimentHub/inst/doc/ExperimentHub.html).

## Citation

Damond N, Eling N (2021). _imcdatasets: Collection of publicly available imaging mass cytometry (IMC) datasets._ R package version 0.99.6, https://github.com/BodenmillerGroup/imcdatasets.

## Authors

[Nicolas Damond](https://github.com/ndamond) (maintainer)  
[Nils Eling](https://github.com/nilseling)

## References

[1] [Giesen et al. Nat Methods. 2014. 11(4):417-22](https://doi.org/10.1038/nmeth.2869)
