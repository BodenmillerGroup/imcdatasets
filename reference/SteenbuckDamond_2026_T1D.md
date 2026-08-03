# Obtain the SteenbuckDamond_2026_T1D dataset

Obtain the SteenbuckDamond_2026_T1D dataset, which is composed of two
panels (Islet + Immune) that were acquired on two consecutive 4 µm
sections. Each dataset (panel) is composed of three data objects: single
cell data, multichannel images and cell segmentation masks. The data was
obtained by imaging mass cytometry (IMC) measuring formalin-fixed
paraffin-embedded (FFPE) tissue from 88 individuals along the disease
progression of T1D. It contains, both Controls, single and
multi-auto-antibody positive T1D donors (sAAb+/mAAb+), and donors with
recent and long-standing T1D (Onset/LD).

## Usage

``` r
SteenbuckDamond_2026_T1D(
  data_type = c("sce", "spe", "images", "masks"),
  panel = "islet",
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

  which panel should be returned? Can be set to "islet" (default) or
  "immune".

- full_dataset:

  if FALSE (default), a subset of 120 informative images is returned.
  These are sampled along the disease progression of T1D. It also
  contains insulitic images, i.e. T-cell infiltration of islets. If
  TRUE, the full dataset (corresponding to 7024 images) is returned. Due
  to memory space limitations, this option is only available for single
  cell data and masks, not for `data_type = "images"`. All images can be
  retrieved from Zenodo.

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

A
[SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
object with single cell data, a
[SpatialExperiment](https://rdrr.io/pkg/SpatialExperiment/man/SpatialExperiment.html)
object with single cell data, a
[CytoImageList](https://rdrr.io/pkg/cytomapper/man/CytoImageList.html)
object containing multichannel images, or a
[CytoImageList](https://rdrr.io/pkg/cytomapper/man/CytoImageList.html)
object containing cell segmentation masks.

## Details

This is an Imaging Mass Cytometry (IMC) dataset from Steenbuck, Damond
et al. (2026):

- `images` contains 120 47-channel images in the form of a
  [CytoImageList](https://rdrr.io/pkg/cytomapper/man/CytoImageList.html)
  class object.

- `masks` contains the cell segmentation masks associated with the
  images, in the form of a
  [CytoImageList](https://rdrr.io/pkg/cytomapper/man/CytoImageList.html)
  class object.

- `sce` contains the single cell data extracted from the multichannel
  images using the cell segmentation masks, as well as the associated
  metadata, in the form of a
  [SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
  object.

- `spe` same single cell data as for `sce`, but in the
  [SpatialExperiment](https://rdrr.io/pkg/SpatialExperiment/man/SpatialExperiment.html)
  format.

All data are downloaded from ExperimentHub and cached for local re-use.

Mapping between the three data objects is performed via variables
located in their metadata columns: `mcols()` for the
[CytoImageList](https://rdrr.io/pkg/cytomapper/man/CytoImageList.html)
objects and `ColData()` for the
[SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
and
[SpatialExperiment](https://rdrr.io/pkg/SpatialExperiment/man/SpatialExperiment.html)
objects. Mapping at the image level can be performed with the
`image_name` or `image_number` variables. Mapping between cell
segmentation masks and single cell data is performed with the
`cell_number` variable, the values of which correspond to the intensity
values of the `masks` object. For practical examples, please refer to
the "Accessing IMC datasets" vignette.

The `assay` slots of the
[SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
and
[SpatialExperiment](https://rdrr.io/pkg/SpatialExperiment/man/SpatialExperiment.html)
objects contain three assays:

- `raw` contains raw mean ion counts per cell.

- `exprs` contains arsinh-transformed counts, with cofactor 1.

- `scaled` contains scaled asinh-transformed raw counts.

The marker-associated metadata, including antibody information and metal
tags are stored in the `rowData` of the
[SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
/
[SpatialExperiment](https://rdrr.io/pkg/SpatialExperiment/man/SpatialExperiment.html)
objects.

The cell-associated metadata are stored in the `colData` of the
[SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
and
[SpatialExperiment](https://rdrr.io/pkg/SpatialExperiment/man/SpatialExperiment.html)
objects. These metadata include various information about cells, milieu,
samples, and patients. For instance, cell types can be retrieved with
`colData(sce)$cell_type` and immune cell clusters with
`colData(sce)$cell_cluster_scaled`. The latter for the Immune panel
only.

Neighborhood information, defined here as cells that are localized next
to each other, is stored as a `SelfHits` object in the `colPairs` slot
of the `SingleCellExperiment` and
[SpatialExperiment](https://rdrr.io/pkg/SpatialExperiment/man/SpatialExperiment.html)
objects.

For more information, please refer to the Steenbuck, Damond, et al.
publication.

Dataset versions: a `version` argument can be passed to the function to
specify which dataset version should be retrieved.

- `` `v1` ``: first published version

File sizes:#'

- `` `images_immune` ``: size in memory = 6.3 Gb, size on disk = 650.3
  Mb.

- `` `masks_immune` ``: size in memory = 138 Mb, size on disk = 4.7 Mb.

- `` `sce_immune` ``: size in memory = 442 Mb, size on disk = 217.1 Mb.

- `` `masks_full_immune` ``: size in memory = 8.6 Gb, size on disk =
  337.3 Mb.

- `` `sce_full_immune` ``: size in memory = 21.5 Gb, size on disk = 13.0
  Gb.

- `` `images_islet` ``: size in memory = 3.8 Gb, size on disk = 738.8
  Mb.

- `` `masks_islet` ``: size in memory = 83 Mb, size on disk = 2.8 Mb.

- `` `sce_islet` ``: size in memory = 277 Mb, size on disk = 128.5 Mb.

- `` `masks_full_islet` ``: size in memory = 5.1 Gb, size on disk =
  194.8 Mb.

- `` `sce_full_islet` ``: size in memory = 12.8 Gb, size on disk = 6.8
  Gb.

When storing images on disk, these need to be first fully read into
memory before writing them to disk. This means the process of
downloading the data is slower than directly keeping them in memory.
However, downstream analysis will lose its memory overhead when storing
images on disk.

Original source: Steenbuck, Damond, et al. (2026):
https://doi.org/10.1038/s42255-026-01559-z

Original link to raw data: https://doi.org/10.5281/zenodo.14968076.

## References

Steenbuck, N., Damond, N., et al. (2026). Imaging mass cytometry reveals
functional and immunological changes during type 1 diabetes progression
in human pancreata. *Nat Metab*
https://doi.org/10.1038/s42255-026-01559-z

## Author

Nathan Steenbuck

## Examples

``` r
# Load single cell data
sce <- SteenbuckDamond_2026_T1D(data_type = "sce")
#> Error in .local(x, i, j = j, ...): 'i' must be length 1
print(sce)
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'print': object 'sce' not found

# Display metadata
SteenbuckDamond_2026_T1D(data_type = "sce", metadata = TRUE)
#> ExperimentHub with 0 records
#> # snapshotDate(): 2026-04-21

# Load masks on disk
library(HDF5Array)
masks <- SteenbuckDamond_2026_T1D(data_type = "masks", on_disk = TRUE,
h5FilesPath = getHDF5DumpDir())
#> Error in .local(x, i, j = j, ...): 'i' must be length 1
print(head(masks))
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'print': error in evaluating the argument 'x' in selecting a method for function 'head': object 'masks' not found
```
