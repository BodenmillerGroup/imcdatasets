# Obtain the Damond_2019_Pancreas dataset

Obtain the Damond_2019_Pancreas dataset, which consists of three data
objects: single cell data, multichannel images and cell segmentation
masks. The data was obtained by imaging mass cytometry (IMC) of human
pancreas sections from donors with type 1 diabetes.

## Usage

``` r
Damond_2019_Pancreas(
  data_type = c("sce", "spe", "images", "masks"),
  full_dataset = FALSE,
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
  If TRUE, the full dataset (corresponding to 845 images) is returned.
  Due to memory space limitations, this option is only available for
  single cell data and masks, not for `data_type = "images"`.

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

This is an Imaging Mass Cytometry (IMC) dataset from Damond et al.
(2019):

- `images` contains a hundred 38-channel images in the form of a
  CytoImageList class object.

- `masks` contains the cell segmentation masks associated with the
  images, in the form of a CytoImageList class object.

- `sce` contains the single cell data extracted from the multichannel
  images using the cell segmentation masks, as well as the associated
  metadata, in the form of a SingleCellExperiment. This represents a
  total of 252,059 cells x 38 channels.

- `spe` same single cell data as for `sce`, but in the SpatialExperiment
  format.

All data are downloaded from ExperimentHub and cached for local re-use.

Mapping between the three data objects is performed via variables
located in their metadata columns: `mcols()` for the CytoImageList
objects and `ColData()` for the SingleCellExperiment and
SpatialExperiment objects. Mapping at the image level can be performed
with the `image_name` or `image_number` variables. Mapping between cell
segmentation masks and single cell data is performed with the
`cell_number` variable, the values of which correspond to the intensity
values of the `masks` object. For practical examples, please refer to
the "Accessing IMC datasets" vignette.

This dataset is a subset of the complete Damond et al. (2019) dataset
comprising the data from three pancreas donors at different stages of
type 1 diabetes (T1D). The three donors present clearly diverging
characteristics in terms of cell type composition and cell-cell
interactions, which makes this dataset ideal for benchmarking spatial
and neighborhood analysis algorithms. If `full_dataset = TRUE`, the full
dataset (845 images from 12 patients) is returned. This option is not
available for multichannel images.

The `assay` slots of the SingleCellExperiment and SpatialExperiment
objects contain three assays:

- `counts` contains raw mean ion counts per cell.

- `exprs` contains arsinh-transformed counts, with cofactor 1.

- `quant_norm` contains counts censored at the 99th percentile and
  scaled 0-1.

The marker-associated metadata, including antibody information and metal
tags are stored in the `rowData` of the SingleCellExperiment /
SpatialExperiment objects.

The cell-associated metadata are stored in the `colData` of the
SingleCellExperiment and SpatialExperiment objects. These metadata
include cell types (in `colData(sce)$cell_type`) and broader cell
categories, such as "immune" or "islet" cells (in
`colData(sce)$cell_category`). In addition, for cells located inside
pancreatic islets, the islet they belong to is indicated in
`colData(sce)$islet_parent`. For cells not located in islets, the
"islet_parent" value is set to 0 but the spatially closest islet can be
identified with `colData(sce)$islet_closest`.

The donor-associated metadata are also stored in the `colData` of the
SingleCellExperiment and SpatialExperiment objects. For instance, the
donors' IDs can be retrieved with `colData(sce)$patient_id` and the
donors' disease stage can be obtained with `colData(sce)$patient_stage`.

Neighborhood information, defined here as cells that are localized next
to each other, is stored as a `SelfHits` object in the `colPairs` slot
of the `SingleCellExperiment` and SpatialExperiment objects.

The three donors in the subset present the following characteristics:

- `6126` is a non-diabetic donor, with large islets containing many beta
  cells, severe infiltration of the exocrine pancreas with myeloid cells
  but limited infiltration of islets.

- `6414` is a donor with recent T1D onset (shortly after diagnosis)
  showing partial beta cell destruction and mild infiltration of islets
  with T cells.

- `6180` is a donor with long-duration T1D (11 years after diagnosis),
  showing near-total beta cell destruction and limited immune cell
  infiltration in both the islets and the pancreas.

For information about other donors in the full dataset, please refer to
the Damond et al. publication.

Dataset versions: a `version` argument can be passed to the function to
specify which dataset version should be retrieved.

- `` `v0` ``: original version (Bioconductor \<= 3.15).

- `` `v1` ``: consistent object formatting across datasets.

File sizes:

- `` `images` ``: size in memory = 7.4 Gb, size on disk = 1.7 Gb.

- `` `masks` ``: size in memory = 200 Mb, size on disk = 8.2 Mb.

- `` `sce` ``: size in memory = 353 Mb, size on disk = 204 Mb.

- `` `spe` ``: size in memory = 372 Mb, size on disk = 205 Mb.

- `` `sce_full` ``: size in memory = 2.4 Gb, size on disk = 1.5 Gb.

- `` `spe_full` ``: size in memory = 2.5 Gb, size on disk = 1.5 Gb.

- `` `masks_full` ``: size in memory = 1.4 Gb, size on disk = 60 Mb.

When storing images on disk, these need to be first fully read into
memory before writing them to disk. This means the process of
downloading the data is slower than directly keeping them in memory.
However, downstream analysis will lose its memory overhead when storing
images on disk.

Original source: Damond et al. (2019):
https://doi.org/10.1016/j.cmet.2018.11.014

Original link to raw data, also containing the entire dataset:
https://data.mendeley.com/datasets/cydmwsfztj/2

## References

Damond N et al. (2019). A Map of Human Type 1 Diabetes Progression by
Imaging Mass Cytometry. *Cell Metab* 29(3), 755-768.

## Author

Nicolas Damond

## Examples

``` r
# Load single cell data
sce <- Damond_2019_Pancreas(data_type = "sce")
#> 
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> downloading 1 resources
#> retrieving 1 resource
#> 
#> loading from cache
print(sce)
#> class: SingleCellExperiment 
#> dim: 38 252059 
#> metadata(0):
#> assays(3): counts exprs quant_norm
#> rownames(38): H3 SMA ... DNA1 DNA2
#> rowData names(6): channel metal ... antibody_clone full_name
#> colnames(252059): 138_1 138_2 ... 319_1149 319_1150
#> colData names(28): cell_id image_name ... patient_ethnicity patient_BMI
#> reducedDimNames(0):
#> mainExpName: Damond_2019_Pancreas_v1
#> altExpNames(0):

# Display metadata
Damond_2019_Pancreas(data_type = "sce", metadata = TRUE)
#> ExperimentHub with 1 record
#> # snapshotDate(): 2026-04-21
#> # names(): EH7719
#> # package(): imcdatasets
#> # $dataprovider: University of Zurich
#> # $species: Homo sapiens
#> # $rdataclass: SingleCellExperiment
#> # $rdatadateadded: 2022-10-17
#> # $title: Damond_2019_Pancreas - sce - v1
#> # $description: Single cell data for the Damond_2019_Pancreas IMC dataset
#> # $taxonomyid: 9606
#> # $genome: NA
#> # $sourcetype: Zip
#> # $sourceurl: http://dx.doi.org/10.17632/cydmwsfztj.2
#> # $sourcesize: NA
#> # $tags: c("SingleCellData", "TechnologyData", "Tissue") 
#> # retrieve record with 'object[["EH7719"]]' 

# Load masks on disk
library(HDF5Array)
#> Loading required package: SparseArray
#> Loading required package: Matrix
#> 
#> Attaching package: ‘Matrix’
#> The following object is masked from ‘package:S4Vectors’:
#> 
#>     expand
#> Loading required package: S4Arrays
#> Loading required package: abind
#> 
#> Attaching package: ‘abind’
#> The following object is masked from ‘package:EBImage’:
#> 
#>     abind
#> 
#> Attaching package: ‘S4Arrays’
#> The following object is masked from ‘package:abind’:
#> 
#>     abind
#> The following object is masked from ‘package:EBImage’:
#> 
#>     abind
#> The following object is masked from ‘package:base’:
#> 
#>     rowsum
#> Loading required package: DelayedArray
#> 
#> Attaching package: ‘DelayedArray’
#> The following objects are masked from ‘package:base’:
#> 
#>     apply, scale, sweep
#> Loading required package: h5mread
#> Loading required package: rhdf5
#> 
#> Attaching package: ‘h5mread’
#> The following object is masked from ‘package:rhdf5’:
#> 
#>     h5ls
masks <- Damond_2019_Pancreas(data_type = "masks", on_disk = TRUE,
h5FilesPath = getHDF5DumpDir())
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> downloading 1 resources
#> retrieving 1 resource
#> 
#> loading from cache
print(head(masks))
#> CytoImageList containing 6 image(s)
#> names(6): E02 E03 E04 E05 E06 E07 
#> Each image contains 1 channel
```
