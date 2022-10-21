# imcdatasets

__Documentation is available at: https://bodenmillergroup.github.io/imcdatasets__

## Introduction

The `imcdatasets` package is an extensible resource containing a set of publicly
 available and curated Imaging Mass Cytometry datasets. Each dataset consists of
  three data objects:
1. Single cell data in the form of a `SingleCellExperiment` or
`SpatialExperiment` class object.
2. Multichannel images formatted into a `CytoImageList` class object.
3. Cell segmentation masks formatted into a `CytoImageList` class object.

These formats facilitate accession and integration into R/Bioconductor
workflows. The data objects are hosted on Bioconductor's `ExperimentHub`
platform.

## Requirements
The `imcdatasets` package requires R version >= 4.2.
It builds on data objects contained in the
[SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment),
[SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment),  
and [cytomapper](https://bioconductor.org/packages/cytomapper) packages.
These packages must, therefore, be installed (see below).

## Installation

The [release version](https://www.bioconductor.org/packages/release/data/experiment/html/imcdatasets.html)
of `imcdatasets` can be installed by following standard `Bioconductor` package
installation procedures:
```{r}
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("imcdatasets")
```

The [development version](https://www.bioconductor.org/packages/devel/data/experiment/html/imcdatasets.html)
can be installed from GitHub using `devtools`:
```{r}
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")
devtools::install_github("BodenmillerGroup/imcdatasets", build_vignettes = TRUE)
```

Installing the dependencies (if not already done):
```{r}
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("SpatialExperiment", "cytomapper"))
```

Loading `imcdatasets` in your R session:
```{r}
library(imcdatasets)
```

## Usage

Detailed information on how to access the datasets is available in the
`imcdatasets` vignette, which is available here: https://bodenmillergroup.github.io/imcdatasets/articles/imcdatasets.html.

The vignette can also be viewed directly in R:
```{r}
vignette("imcdatasets")
```

## Details

The `imcdatasets` package provides quick and easy access to published and
curated imaging mass cytometry datasets. Each dataset consists of three data
objects that can be retrieved individually:

1. __Single cell data__ in the form of a `SingleCellExperiment` or a
`SpatialExperiment` class object:
This object contains cell-level expression values and metadata. The `rowData`
entry contain marker information while the `colData` entry contain cell-level
metadata, including _image names_ and _cell numbers_. The `assays` slots contain
 marker expression levels per cell: the `counts` assay contains average ion
 counts per cell whereas the other assays contain counts transformations
 (details available in the documentation of each dataset).

2. __Multichannel images__ formatted into a `CytoImageList` class object.
This object contains multichannel images and metadata, including channel names
and _image names_.

3. __Cell segmentation masks__ formatted into a `CytoImageList` class object.
This object contains single-channel images representing cell segmentation masks
and metadata, including _image names_. The mask intensity values map to
_cell number_ values in the `SingleCellExperiment` object so that single cell
data can be associated to segmentation masks.

The three data objects can be mapped using the _image names_ contained in the
metadata of each object. Details are available in the vignette (see above).

For more information about the `SingleCellExperiment`, `SpatialCellExperiment`,
and `CytoImageList` objects, please refer to the
[SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment),
[SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment),
and [cytomapper](https://bioconductor.org/packages/cytomapper) packages,
respectively.

## Available datasets

### List of available datasets

* __Damond_2019_Pancreas__: Pancreas sections from organ donors with type 1
diabetes.    
  - Documentation: [Damond_2019_Pancreas](https://bodenmillergroup.github.io/imcdatasets/reference/Damond_2019_Pancreas.html).  
  - Publication: [Damond et al. _Cell Metab_ (2019) 29(3):755-768.e5](https://doi.org/10.1016/j.cmet.2018.11.014).
* __JacksonFischer_2020_BreastCancer__: Tumour tissue from patients with breast
cancer.  
  - Documentation: [JacksonFischer_2020_BreastCancer](https://bodenmillergroup.github.io/imcdatasets/reference/JacksonFischer_2020_BreastCancer.html).
  - Publication: [Jackson, Fischer et al. _Nature_ (2020) 578:615–620](https://doi.org/10.1038/s41586-019-1876-x)
* __Zanotelli_2020_Spheroids__: 3D spheroids generated from different cell
lines.  
  - Documentation: [Zanotelli_2020_Spheroids](https://bodenmillergroup.github.io/imcdatasets/reference/Zanotelli_2020_Spheroids.html).   
  - Publication: [Zanotelli et al. _Mol Syst Biol_ (2020) 16:e9798](https://doi.org/10.15252/msb.20209798).  

### View available datasets directly in R

In R, currently available datasets can be viewed with:
```{r}
imc <- imcdatasets::listDatasets()
imc <- as.data.frame(imc)
imc
```
Detailed information about each dataset is available in the help pages
(e.g., `?JacksonFischer_2020_BreastCancer`).
For more information, please refer to the
[ExperimentHub vignette](https://bioconductor.org/packages/release/bioc/vignettes/ExperimentHub/inst/doc/ExperimentHub.html).

## Contributing

Suggestions for new Imaging Mass Cytometry datasets to include in the
`imcdatasets` package are welcome and can be made by
[opening an issue on GitHub](https://github.com/BodenmillerGroup/imcdatasets/issues).

Guidelines about contributions and dataset formatting are provided in a
[dedicated vignette]().

## Citation

Damond N, Eling N, Fischer J (2022). _imcdatasets: Collection of publicly available imaging mass cytometry (IMC) datasets._
R package version 1.5.3, https://github.com/BodenmillerGroup/imcdatasets.

## Authors

* [Nicolas Damond](https://github.com/ndamond) (author, maintainer)  
* [Nils Eling](https://github.com/nilseling) (contributor)  
* [Jana Fischer](https://github.com/JanaFischer) (contributor)  

## References

[1] [Giesen et al. Nat Methods. 2014. 11(4):417-22](https://doi.org/10.1038/nmeth.2869)
