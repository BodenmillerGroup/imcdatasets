# Obtain the Meyer_2025_TripleNegativeBreastCancer dataset

Obtain the Meyer_2025_TripleNegativeBreastCancer dataset. The dataset is
composed of three data objects: single cell data, multichannel images
and cell segmentation masks. The data was obtained by imaging mass
cytometry (IMC) of a tissue microarray (TMA) with multiple cores of
formalin-fixed paraffin-embedded (FFPE) tissue from 215 patients with
triple-negative breast cancer.

## Usage

``` r
Meyer_2025_TripleNegativeBreastCancer(
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

  if FALSE (default), a subset corresponding to to 125 images from 60
  patients sampled across proposed patient groups is returned. This
  includes all images visually presented in the publication. If TRUE,
  the full dataset (corresponding to 450 images) is returned. Due to
  memory space limitations, this option is only available for single
  cell data and masks, not for `data_type = "images"`.

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

This is an Imaging Mass Cytometry (IMC) dataset from Meyer et al.
(2025):

- `images` contains 125 39-channel images in the form of a CytoImageList
  class object.

- `masks` contains the cell segmentation masks associated with the
  images, in the form of a CytoImageList class object.

- `sce` contains the single cell data extracted from the multichannel
  images using the cell segmentation masks, as well as the associated
  metadata, in the form of a SingleCellExperiment object.

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

The `assay` slots of the SingleCellExperiment and SpatialExperiment
objects contain three assays:

- `counts` contains raw mean ion counts per cell.

- `exprs` contains arsinh-transformed counts, with cofactor 1.

- `min_max` contains 0-1 normalized .

The marker-associated metadata, including antibody information and metal
tags are stored in the `rowData` of the SingleCellExperiment /
SpatialExperiment objects.

The cell-associated metadata are stored in the `colData` of the
SingleCellExperiment and SpatialExperiment objects. These metadata
include various information about cells, tumors and patients. For
instance, cell metacluster can be retrieved with
`colData(sce)$cell_metacluster` and patient groups with
`colData(sce)$patient_patientgroup`.

Neighborhood information, defined here as cells that are localized next
to each other, is stored as a `SelfHits` object in the `colPairs` slot
of the `SingleCellExperiment` and SpatialExperiment objects.

For more information, please refer to the Meyer et al. publication.

Dataset versions: a `version` argument can be passed to the function to
specify which dataset version should be retrieved.

- `` `v1` ``: first published version

File sizes:

- `` `images` ``: size in memory = 20.9 Gb, size on disk = 1.6 Gb.

- `` `masks` ``: size in memory = 269 Mb, size on disk = 8 Mb.

- `` `masks_full` ``: size in memory = 942 Mb, size on disk = 29 Mb.

- `` `sce` ``: size in memory = 451 Mb, size on disk = 241 Mb.

- `` `sce_full` ``: size in memory = 1.6 Gb, size on disk = 866 Mb.

When storing images on disk, these need to be first fully read into
memory before writing them to disk. This means the process of
downloading the data is slower than directly keeping them in memory.
However, downstream analysis will lose its memory overhead when storing
images on disk.

Original source: Meyer et al. (2025):
https://doi.org/10.1016/j.ccell.2025.06.019

Original link to raw data: https://zenodo.org/records/15304181.

## References

Meyer, Jackson et al. (2025). A stratification system for breast cancer
based on basoluminal tumor cells and spatial tumor architecture *Cancer
Cell* 43(9):1637–1655.e9.

## Author

Lasse Meyer

## Examples

``` r
# Load single cell data
sce <- Meyer_2025_TripleNegativeBreastCancer(data_type = "sce")
#> snapshotDate(): 2026-07-16
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> loading from cache
print(sce)
#> class: SingleCellExperiment 
#> dim: 39 257680 
#> metadata(0):
#> assays(3): counts exprs min_max
#> rownames(39): H3 trime_H3 ... DNA1 DNA2
#> rowData names(11): channel metal ... channel_cluster_tumor
#>   channel_cluster_combined
#> colnames(257680): ZTMA174.1_ZTMA174_B06.02565_3_AX3Y1_42_1
#>   ZTMA174.1_ZTMA174_B06.02565_3_AX3Y1_42_2 ...
#>   ZTMA249.3_ZTMA249_ID_99_AX3Y13_321_1552
#>   ZTMA249.3_ZTMA249_ID_99_AX3Y13_321_1553
#> colData names(41): image_name image_width ... tumor_PTNM_M
#>   tumor_PTNM_M_simple
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):

# Display metadata
Meyer_2025_TripleNegativeBreastCancer(data_type = "sce", metadata = TRUE)
#> snapshotDate(): 2026-07-16
#> ExperimentHub with 1 record
#> # snapshotDate(): 2026-07-16
#> # names(): EH10436
#> # package(): imcdatasets
#> # $dataprovider: University of Zurich
#> # $species: Homo sapiens
#> # $rdataclass: SingleCellExperiment
#> # $rdatadateadded: 2026-06-25
#> # $title: Meyer_2025_TripleNegativeBreastCancer - sce - v1
#> # $description: Single cell data (subset) for the Meyer_2025_TripleNegativeB...
#> # $taxonomyid: 9606
#> # $genome: NA
#> # $sourcetype: Zip
#> # $sourceurl: https://zenodo.org/records/15304181
#> # $sourcesize: NA
#> # $tags: c("Homo_sapiens_Data", "ImmunoOncologyData",
#> #   "ReproducibleResearch", "SingleCellData", "SpatialData",
#> #   "TechnologyData", "Tissue") 
#> # retrieve record with 'object[["EH10436"]]' 

# Load masks on disk
library(HDF5Array)
masks <- Meyer_2025_TripleNegativeBreastCancer(data_type = "masks", on_disk = TRUE,
h5FilesPath = getHDF5DumpDir())
#> snapshotDate(): 2026-07-16
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> loading from cache
print(head(masks))
#> CytoImageList containing 6 image(s)
#> names(6): ZTMA174.1_ZTMA174_B06.02565_3_AX3Y1_42 ZTMA174.1_ZTMA174_B06.11749_6_AX6Y1_81 ZTMA174.1_ZTMA174_B06.25613_11_AX3Y2_56 ZTMA174.1_ZTMA174_B06.25613_12_AX4Y2_13 ZTMA174.1_ZTMA174_B06.38699_14_AX6Y2_36 ZTMA174.1_ZTMA174_B07.08412_19_AX3Y3_46 
#> Each image contains 1 channel
```
