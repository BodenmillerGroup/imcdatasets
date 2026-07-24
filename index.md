# imcdatasets

\_\_Documentation is available at:
<https://bodenmillergroup.github.io/imcdatasets/index.html__>

## Check status

| Bioc branch | Checks |
|:--:|:--:|
| Devel | [![build-checks-devel](https://github.com/BodenmillerGroup/imcdatasets/actions/workflows/build-checks-devel.yml/badge.svg?branch=devel)](https://github.com/BodenmillerGroup/imcdatasets/actions/workflows/build-checks-devel.yml) |
| BioC Devel | [![Bioc devel status](http://www.bioconductor.org/shields/build/devel/data-experiment/imcdatasets.svg)](https://bioconductor.org/checkResults/devel/data-experiment-LATEST/imcdatasets) |
| BioC Release | [![Bioc release status](http://www.bioconductor.org/shields/build/release/data-experiment/imcdatasets.svg)](https://bioconductor.org/checkResults/release/data-experiment-LATEST/imcdatasets) |

## Introduction

The `imcdatasets` package is an extensible resource containing a set of
publicly available and curated Imaging Mass Cytometry datasets. Each
dataset consists of three data objects: 1. Single cell data in the form
of a `SingleCellExperiment` or `SpatialExperiment` class object. 2.
Multichannel images formatted into a `CytoImageList` class object. 3.
Cell segmentation masks formatted into a `CytoImageList` class object.

These formats facilitate accession and integration into R/Bioconductor
workflows. The data objects are hosted on Bioconductor’s
[ExperimentHub](https://bioconductor.org/packages/ExperimentHub)
platform.

## Installation

### Release version

The [release
version](https://www.bioconductor.org/packages/release/data/experiment/html/imcdatasets.html)
of `imcdatasets` requires *R* version \>= 4.6 and *Bioconductor* version
\>= 3.23.

The current release of *Bioconductor* should be installed:

``` r

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.23")
```

Then, `imcdatasets` can be installed from *Bioconductor*:

``` r

BiocManager::install("imcdatasets")
```

### Development version

The [development
version](https://www.bioconductor.org/packages/devel/data/experiment/html/imcdatasets.html)
of `imcdatasets` requires *R* version \>= 4.6 and *Bioconductor* version
\>= 3.24.

The development version of *Bioconductor* should be installed:

``` r

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version='devel')
```

Then, `imcdatasets` can be installed from *Bioconductor*:

``` r

BiocManager::install("imcdatasets")
```

`imcdatasets` can also be installed from GitHub using `devtools`:

``` r

if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")
devtools::install_github("BodenmillerGroup/imcdatasets", build_vignettes = TRUE)
```

### Dependencies

`imcdatasets` builds on data objects contained in the
[SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment),
[SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment),
and [cytomapper](https://bioconductor.org/packages/cytomapper) packages.

These packages can be installed as follows:

``` r

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("SingleCellExperiment", "SpatialExperiment", "cytomapper"))
```

## Usage

To load `imcdatasets` in your R session, use:

``` r

library(imcdatasets)
```

Detailed information on how to access the datasets is available in the
[imcdatasets
vignette](https://bodenmillergroup.github.io/imcdatasets/articles/imcdatasets.html).

The vignette can also be viewed directly in R:

``` r

vignette("imcdatasets")
```

## Details

The `imcdatasets` package provides quick and easy access to published
and curated imaging mass cytometry datasets. Each dataset consists of
three data objects that can be retrieved individually:

1.  **Single cell data** in the form of a `SingleCellExperiment` or a
    `SpatialExperiment` class object: This object contains cell-level
    expression values and metadata. The `rowData` entry contain marker
    information while the `colData` entry contain cell-level metadata,
    including *image names* and *cell numbers*. The `assays` slots
    contain marker expression levels per cell: the `counts` assay
    contains average ion counts per cell whereas the other assays
    contain counts transformations (details available in the
    documentation of each dataset).

2.  **Multichannel images** formatted into a `CytoImageList` class
    object. This object contains multichannel images and metadata,
    including channel names and *image names*.

3.  **Cell segmentation masks** formatted into a `CytoImageList` class
    object. This object contains single-channel images representing cell
    segmentation masks and metadata, including *image names*. The mask
    intensity values map to *cell number* values in the
    `SingleCellExperiment` object so that single cell data can be
    associated to segmentation masks.

The three data objects can be mapped using the *image names* contained
in the metadata of each object. Details are available in the vignette
(see above).

For more information about the `SingleCellExperiment`,
`SpatialExperiment`, and `CytoImageList` objects, please refer to the
[SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment),
[SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment),
and [cytomapper](https://bioconductor.org/packages/cytomapper) packages,
respectively.

## Available datasets

### List of available datasets

- **Damond_2019_Pancreas**: Pancreas sections from organ donors with
  type 1 diabetes.
  - Documentation:
    [Damond_2019_Pancreas](https://bodenmillergroup.github.io/imcdatasets/reference/Damond_2019_Pancreas.html).  
  - Publication: [Damond et al. *Cell Metab* (2019)
    29(3):755-768.e5](https://doi.org/10.1016/j.cmet.2018.11.014).
- **Meyer_2025_TripleNegativeBreastCancer**: Triple Negative Breast
  Cancer samples.
  - Documentation:
    [Meyer_2025_TripleNegativeBreastCancer](https://bodenmillergroup.github.io/imcdatasets/reference/Meyer_2025_TripleNegativeBreastCancer.html).
  - Publication: [Meyer et al. *Cancer Cell* (2025)
    43(9):1637–1655.e9](https://doi.org/10.1016/j.ccell.2025.06.019).
- **HochSchulz_2022_Melanoma**: Metastatic melanoma samples, including a
  panel with co-detection of protein and RNA targets.
  - Documentation:
    [HochSchulz_2022_Melanoma](https://bodenmillergroup.github.io/imcdatasets/reference/HochSchulz_2022_Melanoma.html).
  - Publication: [Hoch, Schulz et al. *Sci Immunol* (2022)
    70(7):abk1692](https://doi.org/10.1126/sciimmunol.abk1692)
- **JacksonFischer_2020_BreastCancer**: Tumour tissue from patients with
  breast cancer.
  - Documentation:
    [JacksonFischer_2020_BreastCancer](https://bodenmillergroup.github.io/imcdatasets/reference/JacksonFischer_2020_BreastCancer.html).
  - Publication: [Jackson, Fischer et al. *Nature* (2020)
    578:615–620](https://doi.org/10.1038/s41586-019-1876-x)
- **Zanotelli_2020_Spheroids**: 3D spheroids generated from different
  cell lines.
  - Documentation:
    [Zanotelli_2020_Spheroids](https://bodenmillergroup.github.io/imcdatasets/reference/Zanotelli_2020_Spheroids.html).  
  - Publication: [Zanotelli et al. *Mol Syst Biol* (2020)
    16:e9798](https://doi.org/10.15252/msb.20209798).  
- **IMMUcan_2022_CancerExample**: Example data from the
  [IMMUcan](https://immucan.eu/) project.
  - Documentation:
    [IMMUcan_2022_CancerExample](https://bodenmillergroup.github.io/imcdatasets/reference/IMMUcan_2022_CancerExample.html).

### Viewing available datasets in R

In R, currently available datasets can be viewed with:

``` r

imc <- imcdatasets::listDatasets()
imc <- as.data.frame(imc)
imc
```

Detailed information about each dataset is available in the help pages
(e.g.,
[`?JacksonFischer_2020_BreastCancer`](https://bodenmillergroup.github.io/imcdatasets/reference/JacksonFischer_2020_BreastCancer.md)).
For more information, please refer to the [ExperimentHub
vignette](https://bioconductor.org/packages/release/bioc/vignettes/ExperimentHub/inst/doc/ExperimentHub.html).

## Contributing

Suggestions for new Imaging Mass Cytometry datasets to include in the
`imcdatasets` package are welcome and can be made by [opening an issue
on GitHub](https://github.com/BodenmillerGroup/imcdatasets/issues).

Guidelines about contributions and dataset formatting are provided in a
[dedicated
vignette](https://bodenmillergroup.github.io/imcdatasets/articles/Guidelines_Contribution_Dataset-formatting.html).

## Citation

Damond N, Steenbuck N, Eling N, Fischer J, Hoch T, Meyer L (2026).
*imcdatasets: Collection of publicly available imaging mass cytometry
(IMC) datasets.* R package version 1.21.2,
<https://github.com/BodenmillerGroup/imcdatasets>.

## Authors

- [Nicolas Damond](https://github.com/ndamond) (author)  
- [Nathan Steenbuck](https://github.com/nathansteenbuck) (author,
  maintainer)
- [Nils Eling](https://github.com/nilseling) (contributor)  
- [Jana Fischer](https://github.com/JanaFischer) (contributor)  
- [Tobias Hoch](https://github.com/toobiwankenobi) (contributor)  
- [Lasse Meyer](https://github.com/lassedochreden) (contributor)

## References

\[1\] [Giesen et al. Nat Methods. 2014.
11(4):417-22](https://doi.org/10.1038/nmeth.2869)
