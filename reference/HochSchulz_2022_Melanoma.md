# Obtain the HochSchulz_2022_Melanoma dataset

Obtain the HochSchulz_2022_Melanoma dataset, which is composed of two
panels (rna and protein) that were acquired on consecutive sections.
Each dataset (panel) is composed of three data objects: single cell
data, multichannel images and cell segmentation masks. The data was
obtained by imaging mass cytometry (IMC) of a tissue microarray (TMA)
with multiple cores of formalin-fixed paraffin-embedded (FFPE) tissue
from 69 patients with metastatic melanoma.

## Usage

``` r
HochSchulz_2022_Melanoma(
  data_type = c("sce", "spe", "images", "masks"),
  panel = "rna",
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

- panel:

  which panel should be returned? Can be set to "rna" (default) or
  "protein".

- full_dataset:

  if FALSE (default), a subset corresponding to the 50 images containing
  the most B cells is returned. If TRUE, the full dataset (corresponding
  to 166 images) is returned. Due to memory space limitations, this
  option is only available for single cell data and masks, not for
  `data_type = "images"`.

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

This is an Imaging Mass Cytometry (IMC) dataset from Hoch, Schulz et al.
(2022):

- `images` contains fifty 38-channel images in the form of a
  CytoImageList class object.

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

- `scaled_counts` contains scaled counts.

- `scaled_exprs` contains scaled asinh-transformed counts.

The marker-associated metadata, including antibody information and metal
tags are stored in the `rowData` of the SingleCellExperiment /
SpatialExperiment objects.

The cell-associated metadata are stored in the `colData` of the
SingleCellExperiment and SpatialExperiment objects. These metadata
include various information about cells, milieu, samples, and patients.
For instance, cell types can be retrieved with `colData(sce)$cell_type`
and cell clusters with `colData(sce)$cell_cluster`.

Neighborhood information, defined here as cells that are localized next
to each other, is stored as a `SelfHits` object in the `colPairs` slot
of the `SingleCellExperiment` and SpatialExperiment objects.

For more information, please refer to the Hoch, Schulz, et al.
publication.

Dataset versions: a `version` argument can be passed to the function to
specify which dataset version should be retrieved.

- `` `v1` ``: first published version

File sizes:

- `` `images_rna` ``: size in memory = 13.9 Gb, size on disk = 954 Mb.

- `` `masks_rna` ``: size in memory = 347 Mb, size on disk = 11 Mb.

- `` `sce_rna` ``: size in memory = 774 Mb, size on disk = 401 Mb.

- `` `masks_full_rna` ``: size in memory = 1.1 Gb, size on disk = 30 Mb.

- `` `sce_full_rna` ``: size in memory = 2.0 Gb, size on disk = 1.1 Gb.

- `` `images_protein` ``: size in memory = 16.8 Gb, size on disk = 1.2
  Gb.

- `` `masks_protein` ``: size in memory = 374 Mb, size on disk = 12 Mb.

- `` `sce_protein` ``: size in memory = 856 Mb, size on disk = 531 Mb.

- `` `masks_full_protein` ``: size in memory = 1.2 Gb, size on disk = 35
  Mb.

- `` `sce_full_protein` ``: size in memory = 2.2 Gb, size on disk = 1.4
  Gb.

When storing images on disk, these need to be first fully read into
memory before writing them to disk. This means the process of
downloading the data is slower than directly keeping them in memory.
However, downstream analysis will lose its memory overhead when storing
images on disk.

Original source: Hoch, Schulz et al. (2022):
https://doi.org/10.1126/sciimmunol.abk1692

Original link to raw data: https://doi.org/10.5281/zenodo.5994136.

## References

Hoch, Schulz et al. (2022). Multiplexed imaging mass cytometry of the
chemokine milieus in melanoma characterizes features of the response to
immunotherapy *Sci Immunol* 7(70):eabk1692.

## Author

Nicolas Damond

## Examples

``` r
# Load single cell data
sce <- HochSchulz_2022_Melanoma(data_type = "sce")
#> snapshotDate(): 2026-07-16
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> loading from cache
print(sce)
#> class: SingleCellExperiment 
#> dim: 41 325881 
#> metadata(44): SpotNr BlockID ... colour_vectors
#>   chemokines_morethan600_withcontrol
#> assays(4): counts exprs scaled_counts scaled_exprs
#> rownames(41): VIM H3 ... CD15 MPO
#> rowData names(15): metal antibody_tube_number ... marker_class
#>   full_name
#> colnames(325881): 4_1 4_2 ... 162_7754 162_7755
#> colData names(88): cell_number image_number ...
#>   milieu_Bcell_patch_score image_name
#> reducedDimNames(1): UMAP
#> mainExpName: HochSchulz_2022_Melanoma_RNA_v1
#> altExpNames(0):

# Display metadata
HochSchulz_2022_Melanoma(data_type = "sce", metadata = TRUE)
#> snapshotDate(): 2026-07-16
#> ExperimentHub with 1 record
#> # snapshotDate(): 2026-07-16
#> # names(): EH7824
#> # package(): imcdatasets
#> # $dataprovider: University of Zurich
#> # $species: Homo sapiens
#> # $rdataclass: SingleCellExperiment
#> # $rdatadateadded: 2023-01-30
#> # $title: HochSchulz_2022_Melanoma - rna - sce - v1
#> # $description: Single cell data (RNA panel, subset) for the HochSchulz_2022...
#> # $taxonomyid: 9606
#> # $genome: NA
#> # $sourcetype: Zip
#> # $sourceurl: https://doi.org/10.5281/zenodo.5994136
#> # $sourcesize: NA
#> # $tags: c("Homo_sapiens_Data", "ImmunoOncologyData",
#> #   "ReproducibleResearch", "SingleCellData", "SpatialData",
#> #   "TechnologyData", "Tissue") 
#> # retrieve record with 'object[["EH7824"]]' 

# Load masks on disk
library(HDF5Array)
masks <- HochSchulz_2022_Melanoma(data_type = "masks", on_disk = TRUE,
h5FilesPath = getHDF5DumpDir())
#> snapshotDate(): 2026-07-16
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> loading from cache
print(head(masks))
#> CytoImageList containing 6 image(s)
#> names(6): 7 11 12 13 14 51 
#> Each image contains 1 channel
```
