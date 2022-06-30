# imcdatasets

__Documentation is available at: https://bodenmillergroup.github.io/imcdatasets__

## Introduction

The `imcdatasets` package is an extensible resource containing a set of publicly available and curated Imaging Mass Cytometry datasets. Each dataset consists of three data objects:
1. Single cell data in the form of a `SingleCellExperiment` class object.
2. Multichannel images formatted into a `CytoImageList` class object.
3. Cell segmentation masks formatted into a `CytoImageList` class object.

These formats facilitate accession and integration into R/Bioconductor workflows. The data objects are hosted on Bioconductor's `ExperimentHub` platform.

## Requirements
The `imcdatasets` package requires R version >= 4.2.
It builds on data objects contained in the [SingleCellExperiment](https://www.bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) and [cytomapper](https://www.bioconductor.org/packages/release/bioc/html/cytomapper.html) packages. These packages must, therefore, be installed (see below).

## Installation

The [release version](https://www.bioconductor.org/packages/release/data/experiment/html/imcdatasets.html) of `imcdatasets` can be installed by following standard `Bioconductor` package installation procedures:
```{r}
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("imcdatasets")
```

The development version can be installed from GitHub using `devtools`:
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

Detailed information on how to access the datasets is available in the `imcdatasets` vignette, which is available here: https://bodenmillergroup.github.io/imcdatasets/articles/imcdatasets.html.

The vignette can also be viewed directly in R:
```{r}
vignette("imcdatasets")
```

## Details

The `imcdatasets` package provides quick and easy access to published and curated imaging mass cytometry datasets. Each dataset consists of three data objects that can be retrieved individually:

1. __Single cell data__ in the form of a `SingleCellExperiment` class object:
This object contains cell-level expression values and metadata. The `rowData` contain marker information while the `colData` contain cell-level metadata, including _image names_. The `assay` slots contain marker expression per cell values: the `counts` assay contains average ion counts per cell whereas the other assays contain counts transformation(s) (details available in the documentation of each dataset).

2. __Multichannel images__ formatted into a `CytoImageList` class object.
This object contains multichannel images and metadata, including channel names and _image names_.

3. __Cell segmentation masks__ formatted into a `CytoImageList` class object.
This object contains single-channel images representing cell segmentation masks and metadata, including _image names_.

The three data objects can be mapped using the _image names_ contained in the metadata of each object. Details are available in the vignette (see above).

For more information about the `SingleCellExperiment` and `CytoImageList` objects, please refer to the [SingleCellExperiment](https://www.bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) and [cytomapper](https://www.bioconductor.org/packages/release/bioc/html/cytomapper.html) packages, respectively.

## Available datasets

### List of available datasets

* __JacksonFischer2020__: Tumour tissue from patients with breast cancer.  
  - Documentation: [JacksonFischer2020Data](https://bodenmillergroup.github.io/imcdatasets/reference/JacksonFischer2020Data.html).
  - Publication: [Jackson, Fischer et al. _Nature_ (2020) 578:615–620](https://doi.org/10.1038/s41586-019-1876-x)
* __ZanotelliSpheroids2020__: 3D spheroids generated from different cell lines.  
  - Documentation: [ZanotelliSpheroids2020Data](https://bodenmillergroup.github.io/imcdatasets/reference/ZanotelliSpheroids2020Data.html).   
  - Publication: [Zanotelli et al. _Mol Syst Biol_ (2020) 16:e9798](https://doi.org/10.15252/msb.20209798).  
* __DamondPancreas2019__: Pancreas sections from donors with type 1 diabetes.    
  - Documentation: [DamondPancreas2019Data](https://bodenmillergroup.github.io/imcdatasets/reference/DamondPancreas2019Data.html).  
  - Publication: [Damond et al. _Cell Metab_ (2019) 29(3):755-768.e5](https://doi.org/10.1016/j.cmet.2018.11.014).

### View available datasets directly in R

In R, currently available datasets can be viewed with:
```{r}
imc <- imcdatasets::listDatasets()
imc <- as.data.frame(imc)
imc
```
Detailed information about each dataset is available in the help pages (e.g., `?JacksonFischer2020Data`).

Alternately, available datasets can be viewed without installing `imcdatasets` with [ExperimentHub](https://bioconductor.org/packages/release/bioc/html/ExperimentHub.html), as following:
```{r}
# Install and load the ExperimentHub package
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ExperimentHub")
library(ExperimentHub)

# View available datasets
eh <- ExperimentHub()
query(eh, "imcdatasets")
```
For more information, please refer to the [ExperimentHub vignette](https://bioconductor.org/packages/release/bioc/vignettes/ExperimentHub/inst/doc/ExperimentHub.html).

## Citation

Damond N, Eling N, Fischer J (2022). _imcdatasets: Collection of publicly available imaging mass cytometry (IMC) datasets._ R package version 1.5.2, https://github.com/BodenmillerGroup/imcdatasets.

## Authors

[Nicolas Damond](https://github.com/ndamond) (author, maintainer)
[Nils Eling](https://github.com/nilseling) (contributor)
[Jana Fischer](https://github.com/JanaFischer) (contributor)

## References

[1] [Giesen et al. Nat Methods. 2014. 11(4):417-22](https://doi.org/10.1038/nmeth.2869)
