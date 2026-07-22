# Obtain the Zanotelli_2020_Spheroids dataset

Obtain the Zanotelli_2020_Spheroids dataset, which consists of three
data objects: single cell data, multichannel images and cell
segmentation masks. The data were obtained by imaging mass cytometry
(IMC) of sections of 3D spheroids generated from different cell lines.

## Usage

``` r
Zanotelli_2020_Spheroids(
  data_type = c("sce", "spe", "images", "masks"),
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

This is an Imaging Mass Cytometry (IMC) dataset from Zanotelli et al.
(2020), consisting of three data objects:

- `images` contains 517 multichannel images, each containing 51
  channels, in the form of a CytoImageList class object.

- `masks` contains the cell segmentation masks associated with the
  images, in the form of a CytoImageList class object.

- `sce` contains the single cell data extracted from the multichannel
  images using the cell segmentation masks, as well as the associated
  metadata, in the form of a SingleCellExperiment. This represents a
  total of 229,047 cells x 51 channels.

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

This dataset was obtained as following (the names of the experimental
variables, located in the `colData` of the SingleCellExperiment and
SpatialExperiment objects, are indicated in parentheses): *i)* Cells
from four different cell lines (`cell_line`) were seeded at three
different densities (`treatment_concentration`, relative densities) and
grown for either 72 or 96 hours (`treatment_time_point`, duration in
hours). In the appropriate experimental conditions (see the paper for
details), the cells aggregate into 3D spheroids. *ii)* Cells were
harvested and pooled into 60-well barcoding plates. *iii)* A pellet of
each spheroid pool was generated and cut into several 6 um-thick
sections. *iv)* A subset of these sections (`site_id`) were stained with
an IMC panel and acquired as one or more acquisitions (`acquisition_id`)
containing multiple spheres each. *v)* Spheres in these acquisitions
were identified by computer vision and cropped into individual images
(`image_number`).

Other relevant cell metadata include:

- `treatment_name`: experimental conditions in the format:
  `"Cell line name"_c"seeding density"_tp"time point"`.

- `cell_x/cell_y`: cell centroid position in the image.

- `cell_area`: area of the cell (um^2).

- `distance_rim`: estimated distance to spheroid border.

- `distance_sphere`: distance to spheroid section border.

- `distance_other_sphere`: distance to the closest of the other spheroid
  sections in the same image (if there is any).

- `distance_background`: distance to background pixels.

For a full description of the other experimental variables, please refer
to the publication (https://doi.org/10.15252/msb.20209798) and to the
original dataset repository (https://doi.org/10.5281/zenodo.4271910).

The marker-associated metadata, including antibody information and metal
tags are stored in the `rowData` of the SingleCellExperiment and
SpatialExperiment objects. The channels with names starting with "BC\_"
are the channels used for barcoding. Post-transcriptional modification
of the protein targets are indicated in brackets.

The `assay` slots of the SingleCellExperiment and SpatialExperiment
objects contain three assays:

- `counts` contains raw mean ion counts per cell.

- `exprs` contains arsinh-transformed counts, with cofactor 1.

- `quant_norm` contains counts censored at the 99th percentile and
  scaled 0-1.

In addition, the `altExp` slot of the SingleCellExperiment object
contains another SingleCellExperiment object where the counts matrix
represents raw mean ion counts for cells neighboring the current cell.

Neighborhood information, defined here as cells that are localized next
to each other, is stored as a `SelfHits` object in the `colPairs` slot
of the `SingleCellExperiment` and SpatialExperiment objects. Cells in
the `SelfHits` object are represented by unique integers that map to the
`cell_number_absolute` column of `colData(sce)`.

Dataset versions: a `version` argument can be passed to the function to
specify which dataset version should be retrieved.

- `` `v0` ``: original version (Bioconductor \<= 3.15).

- `` `v1` ``: consistent object formatting across datasets.

File sizes:

- `` `images` ``: size in memory = 21.2 Gb, size on disk = 860 Mb.

- `` `masks` ``: size in memory = 426 Mb, size on disk = 12 Mb.

- `` `sce` ``: size in memory = 564 Mb, size on disk = 319 Mb.

- `` `spe` ``: size in memory = 596 Mb, size on disk = 320 Mb.

When storing images on disk, these need to be first fully read into
memory before writing them to disk. This means the process of
downloading the data is slower than directly keeping them in memory.
However, downstream analysis will lose its memory overhead when storing
images on disk.

Original source: Zanotelli et al. (2020):
https://doi.org/10.15252/msb.20209798

Original link to raw data, also containing the entire dataset:
https://doi.org/10.5281/zenodo.4271910

## References

Zanotelli VRT et al. (2020). A quantitative analysis of the interplay of
environment, neighborhood, and cell state in 3D spheroids *Mol Syst
Biol* 16(12), e9798.

## Author

Nicolas Damond

## Examples

``` r
# Load single cell data
sce <- Zanotelli_2020_Spheroids(data_type = "sce")
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> downloading 1 resources
#> retrieving 1 resource
#> 
#> loading from cache
print(sce)
#> class: SingleCellExperiment 
#> dim: 51 229047 
#> metadata(0):
#> assays(3): counts exprs quant_norm
#> rownames(51): BC_Pd102 BC_Rh103 ... BC_Bi209 BC_Y89
#> rowData names(8): channel metal ... antibody_cell_cycle measurement_id
#> colnames(229047): 2_40 2_41 ... 736_1538 736_1554
#> colData names(32): cell_id image_name ... sampleblock_name
#>   cell_number_absolute
#> reducedDimNames(0):
#> mainExpName: Zanotelli_2020_Spheroids_v1
#> altExpNames(1): neighboring_cells

# Display metadata
Zanotelli_2020_Spheroids(data_type = "sce", metadata = TRUE)
#> ExperimentHub with 1 record
#> # snapshotDate(): 2026-04-21
#> # names(): EH7731
#> # package(): imcdatasets
#> # $dataprovider: University of Zurich
#> # $species: Homo sapiens
#> # $rdataclass: SingleCellExperiment
#> # $rdatadateadded: 2022-10-17
#> # $title: Zanotelli_2020_Spheroids - sce - v1
#> # $description: Single cell data for the Zanotelli_2020_Spheroids IMC dataset
#> # $taxonomyid: 9606
#> # $genome: NA
#> # $sourcetype: Zip
#> # $sourceurl: https://zenodo.org/record/4271910#.YGWR_T8kz-i
#> # $sourcesize: NA
#> # $tags: c("SingleCellData", "TechnologyData", "Tissue") 
#> # retrieve record with 'object[["EH7731"]]' 

# Load masks on disk
library(HDF5Array)
masks <- Zanotelli_2020_Spheroids(data_type = "masks", on_disk = TRUE,
h5FilesPath = getHDF5DumpDir())
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> downloading 1 resources
#> retrieving 1 resource
#> 
#> loading from cache
print(head(masks))
#> CytoImageList containing 6 image(s)
#> names(6): 20190619_p173_slide31_ac1_vz_s1_p1_r11_a11_ac_full_l2_x217_y72_cell 20190619_p173_slide31_ac1_vz_s1_p1_r13_a13_ac_full_l1_x0_y0_cell 20190619_p173_slide31_ac1_vz_s1_p1_r14_a14_ac_full_l1_x0_y127_cell 20190619_p173_slide31_ac1_vz_s1_p1_r14_a14_ac_full_l2_x277_y0_cell 20190619_p173_slide31_ac1_vz_s1_p1_r14_a14_ac_full_l3_x389_y144_cell 20190619_p173_slide31_ac1_vz_s1_p1_r15_a15_ac_full_l1_x0_y0_cell 
#> Each image contains 1 channel
```
