# Obtain the JacksonFischer_2020_BreastCancer dataset

Obtain the JacksonFischer_2020_BreastCancer dataset, which consists of
three data objects: single cell data, multichannel images and cell
segmentation masks. The data was obtained by imaging mass cytometry
(IMC) of tumour tissue from patients with breast cancer.

## Usage

``` r
JacksonFischer_2020_BreastCancer(
  data_type = c("sce", "spe", "images", "masks"),
  full_dataset = FALSE,
  cohort = "Basel",
  version = "latest",
  metadata = FALSE,
  on_disk = FALSE,
  h5FilesPath = NULL,
  force = FALSE
)
```

## Arguments

- data_type:

  type of object to load, \`images\` for multichannel images or
  \`masks\` for cell segmentation masks. Single cell data are retrieved
  using either \`sce\` for the `SingleCellExperiment` format or \`spe\`
  for the `SpatialExperiment` format.

- full_dataset:

  if FALSE (default), a subset corresponding to 100 images is returned.
  If TRUE, the full dataset is returned, including both "Basel" and
  "Zurich" cohorts. Due to memory space limitations, this option is only
  available for single cell data and masks, not for
  `data_type = "images"`.

- cohort:

  which patient cohort should be returned? Can be set to "Basel"
  (default) or "Zurich". Ignored if `full_dataset` is set to TRUE.

- version:

  dataset version. By default, the latest version is returned.

- metadata:

  if FALSE (default), the data object selected in `data_type` is
  returned. If TRUE, only the metadata associated to this object is
  returned.

- on_disk:

  logical indicating if images in form of
  [HDF5Array](https://rdrr.io/pkg/HDF5Array/man/HDF5Array-class.html)
  objects (as .h5 files) should be stored on disk rather than in memory.
  This setting is valid when downloading `images` and `masks`.

- h5FilesPath:

  path to where the .h5 files for on disk representation are stored.
  This path needs to be defined when `on_disk = TRUE`. When files should
  only temporarily be stored on disk, please set
  `h5FilesPath = getHDF5DumpDir()`.

- force:

  logical indicating if images should be overwritten when files with the
  same name already exist on disk.

## Value

A SingleCellExperiment object with single cell data, a SpatialExperiment
object with single cell data, a CytoImageList object containing
multichannel images, or a CytoImageList object containing cell
segmentation masks.

## Details

This is an Imaging Mass Cytometry (IMC) dataset from Jackson, Fischer et
al. (2020):

- `images` contains a hundred 42-channel images in the form of a
  CytoImageList class object.

- `masks` contains the cell segmentation masks associated with the
  images, in the form of a CytoImageList class object.

- `sce` contains the single cell data extracted from the multichannel
  images using the cell segmentation masks, as well as the associated
  metadata, in the form of a SingleCellExperiment. This represents a
  total of 285,851 cells x 42 channels.

- `spe` same single cell data as for `sce`, but in the SpatialExperiment
  format.

All data are downloaded from ExperimentHub and cached for local re-use.

Mapping between the three data objects is performed via variables
located in their metadata columns: `mcols()` for the CytoImageList
objects and `ColData()` for the SingleCellExperiment and
SpatialExperiment objects. Mapping at the image level can be performed
with the `image_name` variable. Mapping between cell segmentation masks
and single cell data is performed with the `cell_number` variable, the
values of which correspond to the intensity values of the `masks`
object. For practical examples, please refer to the "Accessing IMC
datasets" vignette.

This dataset is a subset of the complete Jackson, Fischer et al. (2020)
dataset comprising the data from tumour tissue from 100 patients with
breast cancer (one image per patient). By default, data from the "Basel"
cohort are returned. By setting `cohort = "Zurich"`, data from the
"Zurich" cohort, corresponding to images and associated data from 72
patients, are returned. For details about the patient cohorts, refer to
the publication. If `full_dataset = TRUE`, the full dataset is returned
(including both "Basel" and "Zurich" patient cohorts). This option is
not available for multichannel images.

The `assay` slot of the SingleCellExperiment object contains three
assays:

- `counts` contains mean ion counts per cell.

- `exprs` contains arsinh-transformed counts, with cofactor 1.

- `quant_norm` contains quantile-normalized counts (0 to 1, 99th
  percentile).

The marker-associated metadata, including antibody information and metal
tags are stored in the `rowData` of the SingleCellExperiment and
SpatialExperiment objects.

The cell-associated metadata are stored in the `colData` of the
SingleCellExperiment and SpatialExperiment objects. These metadata
include clusters (in `colData(sce)$cell_cluster_phenograph`) and
metaclusters (in `colData(sce)$cell_metacluster`), as well as spatial
information (e.g., cell areas are stored in `colData(sce)$cell_area`).

The clinical data are also stored in the `colData` of the
SingleCellExperiment and SpatialExperiment objects. For instance, the
tumor grades can be retrieved with `colData(sce)$tumor_grade`.

Dataset versions: a `version` argument can be passed to the function to
specify which dataset version should be retrieved.

- `` `v0` ``: original version (Bioconductor \<= 3.15).

- `` `v1` ``: consistent object formatting across datasets.

- `` `v2` ``: added full datasets and Zurich cohort.

File sizes:

- `` `images_basel` ``: size in memory = 19 Gb, size on disk = 2.0 Gb.

- `` `masks_basel` ``: size in memory = 433 Mb, size on disk = 10 Mb.

- `` `sce_basel` ``: size in memory = 513 Mb, size on disk = 270 Mb.

- `` `images_zurich` ``: size in memory = 6.0 Gb, size on disk = 724 Mb.

- `` `masks_zurich` ``: size in memory = 137 Mb, size on disk = 3.4 Mb.

- `` `sce_zurich` ``: size in memory = 188 Mb, size on disk = 105 Mb.

- `` `masks_full` ``: size in memory = 2.1 Gb, size on disk = 10 Mb.

- `` `sce_full` ``: size in memory = 2.2 Gb, size on disk = 1.2 Gb.

When storing images on disk, these need to be first fully read into
memory before writing them to disk. This means the process of
downloading the data is slower than directly keeping them in memory.
However, downstream analysis will lose its memory overhead when storing
images on disk.

Original source: Jackson, Fischer et al. (2020):
https://doi.org/10.1038/s41586-019-1876-x

Original link to raw data, containing the entire dataset:
https://doi.org/10.5281/zenodo.3518284

## References

Jackson, Fischer et al. (2020). The single-cell pathology landscape of
breast cancer. *Nature* 578(7796), 615-620.

## Author

Nicolas Damond

## Examples

``` r
# Load single cell data
sce <- JacksonFischer_2020_BreastCancer(data_type = "sce")
#> snapshotDate(): 2026-07-16
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> loading from cache
print(sce)
#> class: SingleCellExperiment 
#> dim: 45 285851 
#> metadata(0):
#> assays(3): counts exprs quant_norm
#> rownames(45): Ru96 Ru98 ... DNA1 DNA2
#> rowData names(6): metal name ... channel antibody_clone
#> colnames(285851): 1_1 1_2 ... 375_3941 375_3942
#> colData names(74): image_name cell_id ... patient_cohort cell_number
#> reducedDimNames(0):
#> mainExpName: JacksonFischer_2020_BreastCancer_Basel_v2
#> altExpNames(0):

# Display metadata
JacksonFischer_2020_BreastCancer(data_type = "sce", metadata = TRUE)
#> snapshotDate(): 2026-07-16
#> ExperimentHub with 1 record
#> # snapshotDate(): 2026-07-16
#> # names(): EH7834
#> # package(): imcdatasets
#> # $dataprovider: University of Zurich
#> # $species: Homo sapiens
#> # $rdataclass: SingleCellExperiment
#> # $rdatadateadded: 2023-01-30
#> # $title: JacksonFischer_2020_BreastCancer_Basel - sce - v2
#> # $description: Single cell data (Basel cohort subset) for the JacksonFische...
#> # $taxonomyid: 9606
#> # $genome: NA
#> # $sourcetype: Zip
#> # $sourceurl: https://doi.org/10.5281/zenodo.3518284
#> # $sourcesize: NA
#> # $tags: c("Homo_sapiens_Data", "ImmunoOncologyData",
#> #   "ReproducibleResearch", "SingleCellData", "SpatialData",
#> #   "TechnologyData", "Tissue") 
#> # retrieve record with 'object[["EH7834"]]' 

# Load masks on disk
library(HDF5Array)
masks <- JacksonFischer_2020_BreastCancer(data_type = "masks", on_disk = 
TRUE, h5FilesPath = getHDF5DumpDir())
#> snapshotDate(): 2026-07-16
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> loading from cache
print(head(masks))
#> CytoImageList containing 6 image(s)
#> names(6): BaselTMA_SP41_18_X13Y5 BaselTMA_SP41_114_X13Y4 BaselTMA_SP41_117_X13Y3 BaselTMA_SP41_42_X14Y5 BaselTMA_SP41_166_X15Y4 BaselTMA_SP41_86_X15Y3 
#> Each image contains 1 channel

```
