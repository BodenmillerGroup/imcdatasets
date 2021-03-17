# imcdatasets

## Summary


The `imcdatasets` package is an extensible resource containing a set of publicly available Imaging Mass Cytometry datasets. The datasets consist of three data objects:
1. Single cell data in the form of a `SingleCellExperiment` class object.
2. Multichannel images formatted into a `CytoImageList` class object.
3. Cell segmentation masks formatted into a `CytoImageList` class object.

These formats facilitate accession and integration into R/Bioconductor workflows. The data objects are hosted on Bioconductor's `ExperimentHub` platform.

The single cell data contain cell-level expression values and metadata. The `rowData` of the `SingleCellExperiment` objects contain marker information while the `colData` contain cell-level metadata. The `counts` assay contains mean ion counts per cell unless otherwise stated. `CytoImageList` objects contain either multichannel images with channel names, or cell segmentation masks. For more information about these data objects, please refer to the [SingleCellExperiment](https://www.bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) and [cytomapper](https://www.bioconductor.org/packages/release/bioc/html/cytomapper.html) packages.

## Details

Additional details are provided in the vignette, available at [Bioconductor](https://www.bioconductor.org/packages/release/bioc/vignettes/imcdatasets/inst/doc/imcdatasets.html).

For details on the datasets, please refer to the help files for each dataset available within the package, or the metadata from the `ExperimentHub` database.

## Availability and installation

The `imcdatasets` package is freely available from [Bioconductor](https://www.bioconductor.org/packages/release/bioc/html/imcdatasets.html), and can be installed by following standard Bioconductor package installation procedures:

```{r}
## Install imcdatasets
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("imcdatasets")

## View the available datasets
library(ExperimentHub)
eh = ExperimentHub()
query(eh, "imcdatasets")
```
