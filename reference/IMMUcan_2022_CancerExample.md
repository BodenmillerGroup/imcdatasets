# Obtain the IMMUcan_2022_CancerExample dataset

Obtain the IMMUcan_2022_CancerExample dataset, which consists of three
data objects: single cell data, multichannel images and cell
segmentation masks. Data were obtained by imaging mass cytometry (IMC)
of sections of 4 patients with different tumor indications.

## Usage

``` r
IMMUcan_2022_CancerExample(
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

A
[SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
object with single cell data, a
[CytoImageList](https://rdrr.io/pkg/cytomapper/man/CytoImageList.html)
object containing multichannel images, or a
[CytoImageList](https://rdrr.io/pkg/cytomapper/man/CytoImageList.html)
object containing cell segmentation masks.

## Details

This is an Imaging Mass Cytometry (IMC) dataset used in the [IMC data
analysis book](https://bodenmillergroup.github.io/IMCDataAnalysis/)

- `images` contains 14 multichannel images, each containing 50 channels,
  in the form of a
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
  object. Single cell data can also be retrieved as a
  [SpatialExperiment](https://rdrr.io/pkg/SpatialExperiment/man/SpatialExperiment.html)
  object. This represents a total of 46,825 cells x 40 channels.

All data are downloaded from ExperimentHub and cached for local re-use.

Mapping between the three data objects is performed via variables
located in their metadata columns: `mcols()` for the
[CytoImageList](https://rdrr.io/pkg/cytomapper/man/CytoImageList.html)
objects and `ColData()` for the
[SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
object. Mapping at the image level can be performed with the `sample_id`
or `image_name` variables. Mapping between cell segmentation masks and
single cell data is performed with the `cell_number` variable, the
values of which correspond to the intensity values of the `masks`
object. For practical examples, please refer to the "Accessing IMC
datasets" vignette.

This imaging mass cytometry dataset serves as an example to demonstrate
downstream analysis tools including spatial data analysis. The data was
generated as part of the Integrated iMMUnoprofiling of large adaptive
CANcer patient cohorts (IMMUcan) project
([immucan.eu](https://bodenmillergroup.github.io/imcdatasets/reference/immucan.eu))
using the Hyperion imaging system.

Relevant entries to the `colData` slot are as follows:

- `sample_id` image name.

- `cell_number` cell identifier.

- `width_px` width of the image.

- `height_px` height of the image.

- `patient_id` patient identifier.

- `ROI` region of interest identifier.

- `indication` cancer type.

- `cell_labels` labels of manually labelled cells.

- `cell_type` cell type as defined by classification.

- `spatial_community` identifiers of each spatial tumor or non-tumor
  community

- `cn_celltypes` cellular neighborhoods as defined by clustering cells
  based on the frequency of neighboring cell types.

- `cn_expression` cellular neighborhoods as defined by clustering cells
  based on the mean expression of neighboring cells

- `lisa_clusters` cellular neighborhoods as detected by the lisaClust
  package.

- `spatial_context` spatial contexts defined in `cn_celltype`.

- `spatial_context_filtered` filtered spatial context identifiers.

- `patch_id` identifier of the spatial tumor patch.

- `cell_x` spatial x coordinate.

- `cell_y` spatial y coordinate.

The marker-associated metadata, including antibody information and metal
tags are stored in the `rowData` of the
[SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
object.

The `assay` slot of the
[SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
object contains two assays:

- `counts`: mean ion counts per cell

- `exprs`: arsinh-transformed counts per cell, with cofactor 1.

The `colPair` slot of the
[SingleCellExperiment](https://rdrr.io/pkg/SingleCellExperiment/man/SingleCellExperiment.html)
object contains the following spatial object graphs:

- `neighborhood` steinbock generated graph.

- `knn_interaction_graph` 20-nearest neighbor graph.

- `expansion_interaction_graph` expansion graph using a threshold of 20.

- `delaunay_interaction_graph` interaction graph constructed by delaunay
  triangulation.

- `knn_spatialcontext_graph` 40-nearest neighbor graph.

File sizes:

- `` `images` ``: size in memory = 1.5 Gb, size on disk = 786 Mb.

- `` `masks` ``: size in memory = 19 Mb, size on disk = 1.2 Mb.

- `` `sce` ``: size in memory = 182 Mb, size on disk = 82 Mb.

- `` `spe` ``: size in memory = 183 Mb, size on disk = 81 Mb.

When storing images on disk, these need to be first fully read into
memory before writing them to disk. This means the process of
downloading the data is slower than directly keeping them in memory.
However, downstream analysis will lose its memory overhead when storing
images on disk.

## Author

Nils Eling

## Examples

``` r
# Load single cell data
sce <- IMMUcan_2022_CancerExample(data_type = "sce")
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> downloading 1 resources
#> retrieving 1 resource
#> 
#> loading from cache
print(sce)
#> class: SingleCellExperiment 
#> dim: 40 47794 
#> metadata(5): color_vectors cluster_codes SOM_codes delta_area
#>   filterSpatialContext
#> assays(2): counts exprs
#> rownames(40): MPO H3 ... DNA1 DNA2
#> rowData names(17): channel metal ... ilastik deepcell
#> colnames(47794): 1_1 1_2 ... 14_2844 14_2845
#> colData names(43): sample_id ObjectNumber ... cell_x cell_y
#> reducedDimNames(8): UMAP TSNE ... seurat UMAP_seurat
#> mainExpName: IMMUcan_2022_CancerExample_v1
#> altExpNames(0):

# Display metadata
IMMUcan_2022_CancerExample(data_type = "sce", metadata = TRUE)
#> ExperimentHub with 1 record
#> # snapshotDate(): 2026-04-21
#> # names(): EH7842
#> # package(): imcdatasets
#> # $dataprovider: University of Zurich
#> # $species: Homo sapiens
#> # $rdataclass: SingleCellExperiment
#> # $rdatadateadded: 2023-01-30
#> # $title: IMMUcan_2022_CancerExample - sce - v1
#> # $description: Single cell data for the IMMUcan_2022_CancerExample IMC dataset
#> # $taxonomyid: 9606
#> # $genome: NA
#> # $sourcetype: Zip
#> # $sourceurl: https://zenodo.org/record/6810879
#> # $sourcesize: NA
#> # $tags: c("Homo_sapiens_Data", "ImmunoOncologyData",
#> #   "ReproducibleResearch", "SingleCellData", "SpatialData",
#> #   "TechnologyData", "Tissue") 
#> # retrieve record with 'object[["EH7842"]]' 

# Load masks on disk
library(HDF5Array)
masks <- IMMUcan_2022_CancerExample(data_type = "masks", on_disk = TRUE,
h5FilesPath = getHDF5DumpDir())
#> see ?imcdatasets and browseVignettes('imcdatasets') for documentation
#> downloading 1 resources
#> retrieving 1 resource
#> 
#> loading from cache
print(head(masks))
#> CytoImageList containing 6 image(s)
#> names(6): Patient1_001 Patient1_002 Patient1_003 Patient2_001 Patient2_002 Patient2_003 
#> Each image contains 1 channel
```
