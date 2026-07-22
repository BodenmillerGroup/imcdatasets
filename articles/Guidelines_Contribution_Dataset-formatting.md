# Contribution guidelines and dataset format

## **Introduction**

This vignette describes the procedure to contribute new datasets to the
`imcdatasets` package and contains guidelines for dataset formatting.

## **Contribution guidelines**

Contributions or suggestions for new imaging mass cytometry (IMC)
datasets to add to the `imcdatasets` package are always welcome. New
datasets can be suggested by opening an issue at the `imcdatasets`
[GitHub page](https://github.com/BodenmillerGroup/imcdatasets/issues).
The only requirements are that the new dataset *(i)* is publicly
available and *(ii)* has been described in a published scientific
article.

Details about creating Bioconductor’s `ExperimentHub` packages [are
available here](https://bioconductor.org/packages/HubPub).

### Create a data generation script

The first step is to create a new branch at the `imcdatasets` [GitHub
page](https://github.com/BodenmillerGroup/imcdatasets/branches).

Then, create an R markdown (`.Rmd`) script in `.inst/scripts/` to
generate the data objects:

- Download single cell data, multiplexed images and cell segmentation
  masks.
- Format the single cell data into a
  [SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment)
  object.
- Format the images and masks into
  [CytoImageList](https://bioconductor.org/packages/CytoImageList)
  objects.
- Save the three data objects so that they can be uploaded to
  `ExperimentHub`.
- The three data objects must contain matching information so that they
  can be associated by the
  [cytomapper](https://bioconductor.org/packages/cytomapper) package, as
  described in the [imcdataset
  vignette](https://www.bioconductor.org/packages/release/data/experiment/vignettes/imcdatasets/inst/doc/imcdatasets.html#5_Usage).

The `.Rmd` script must be formatted in the same way as pre-existing
scripts. Examples can be found
[here](https://github.com/BodenmillerGroup/imcdatasets/blob/master/inst/scripts/make-Damond-2019-Pancreas.Rmd)
and
[here](https://github.com/BodenmillerGroup/imcdatasets/blob/master/inst/scripts/make-JacksonFischer-2020-BreastCancer.Rmd).
Each step should be clearly and comprehensively documented.

**For usability of the package and consistency across datasets, the
data** **objects must be formatted as described in the**
`Dataset format` **section** **below.**

### Update the documentation

Other files in the `imcdatasets` package should be updated to include
the new dataset:

- Make a new `./R/Lastname_Year_Type.R` file with a function to load the
  new dataset and extensive documentation. Examples can be found
  [here](https://github.com/BodenmillerGroup/imcdatasets/blob/master/R/Damond_2019_Pancreas.R)
  and
  [here](https://github.com/BodenmillerGroup/imcdatasets/blob/master/R/JacksonFischer_2020_BreastCancer.R).
- Run roxygenize to generate `man` documentation files (go to the
  `imcdatasets` directory and run `roxygen2::roxygenize(".")`).
- Update the `./inst/scripts/make-metadata.R` R script and run it. This
  will update the `./inst/extdata/metadata.csv` file that is used by
  `ExperimentHub` to provide metadata information about datasets.
- Add the reference of the paper that describes the dataset to the
  `./inst/scripts/ref.bib` file.
- Add the new dataset to the `./inst/extdata/alldatasets.csv` file.
- Add the new dataset to the dataset list in
  `./tests/testthat/test_loading.R`.

### Open a pull request

After these steps have been completed, open a pull request at the
[imcdataset GitHub
page](https://github.com/BodenmillerGroup/imcdatasets/pulls).

The package maintainers will do the following:

- Check the R markdown script for data generation.
- Generate the data objects by knitting the R markdown script.
- Make sure the data objects are well formatted and consistent with the
  other datasets.
- Check all the new package metadata and documentation.
- Upload the data objects to `AWS S3` and announce the upload to
  Bioconductor Hubs.
- Download the data objects from `ExperimentHub` and check the format
  again.
- Update the `NEWS`, `DESCRIPTION` (add new contributor, version bump)
  and `README.md` (if needed) files.
- Build and check the package, make sure it passes all R and
  Bioconductor checks.
- Push to GitHub and check that the `imcdatasets` package can be
  installed from there.
- Test the package functionality in R.
- Once everything works, approve the pull request and merge with the
  master branch.

Contributors will be recognized by having their names added to the
DESCRIPTION file of the `imcdatasets` package.

## **Dataset format**

The `imcdatasets` package is meant to provide quick and easy access to
published and curated IMC datasets. Each dataset consists of three data
objects that can be retrieved individually:

- **Single cell data** in the form of a
  [SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment)
  object.
- **Multichannel images** formatted into a
  [CytoImageList](https://bioconductor.org/packages/CytoImageList)
  object.
- **Cell segmentation masks** formatted into a
  [CytoImageList](https://bioconductor.org/packages/CytoImageList)
  object.

The three data objects can be mapped using unique `image_name` values
contained in the metadata of each object.

For consistency across datasets, the guidelines below must be followed
when creating a new dataset.

### Single cell data

Single cell data should be formatted into a
[SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment)
object named `sce` that contains the following slots:

- `colData`: observations metadata.
- `rowData`: marker metadata.
- `assays`: marker expression levels per cell.
- `colPairs` *(optional)*: neighborhood information.

#### colData

The `colData` entry of the `SingleCellExperiment` object is a
`DataFrame` that contains observation metadata; i.e., cells, slides,
tissue, patients, …. It is recommended that all column names have a
prefix that indicates the level of observation (e.g. `cell_`, `slide_` ,
`tissue_`, `patient_`, `tumor_`).

The following columns are required:

- `image_name` and/or `image_number`: unique image (ablated ROI) name,
  respectively number. Should map to the `image_name`/`image_number`
  column(s) in the metadata of the `images` and `masks` objects.
- `cell_number`: integer representing cell numbers. Should map to the
  values of cell segmentation masks.
- `cell_id`: a unique cell identifier defined as {`image_number` `_`
  `cell_number`} (e.g., `7_138`).
- `cell_x` and `cell_y`: position of the cell centroid on the image.
  These columns are used as `SpatialCoords` when converting to a
  [SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment)
  object.

In addition, `colnames(sce)` should be set as `colData(sce)$cell_id`.

#### rowData

The `rowData` entry of the `SingleCellExperiment` is a `DataFrame` that
contains marker (protein, RNA, probe) information.

The following columns are required in the `rowData` entry:

- `channel`: a unique integer that maps to the channels of the
  associated multichannel images.
- `metal`: the metal isotope used for detection, formatted as {
  `ChemicalSymbol` `IsotopeMass`} (e.g., `Y89`, `In115`, `Yb176`,
  `Bi209`).
- `name`: marker name used in the publication that describes the
  dataset.
- `full_name`: full marker name.
- `short_name`: abbreviated marker name, preferably following the
  official [UniProt](https://www.uniprot.org) nomenclature.

For the `full_name` and `short_name` columns, the following guidelines
apply:

- In `short_name`, all dashes, dots and spaces should removed or
  replaced with underscores.
- For post-translationally modified proteins:
- Prefix the `full_name` with the modification type (e.g., `phospho-`,
  `methyl-`) and suffix it with the modified aminoacids (e.g., `[S28]`).
- Prefix the `short_name` with an abbreviation of the modification type
  (e.g., `p_`, `me_`) and do not indicate the modified aminoacids,
  unless there is a possible confusion with another target in the
  dataset.

| full_name                       | short_name   |
|:--------------------------------|:-------------|
| Carbonic anhydrase IX           | CA9          |
| CD3 epsilon                     | CD3e         |
| CD8 alpha                       | CD8a         |
| E-Cadherin                      | CDH1         |
| cleaved-Caspase3 + cleaved-PARP | cCASP3_cPARP |
| Cytokeratin 5                   | KRT5         |
| Forkhead box P3                 | FOXP3        |
| Glucose transporter 1           | SLC2A1       |
| Histone H3                      | H3           |
| phospho-Histone H3 \[S28\]      | p_H3         |
| Ki-67                           | Ki67         |
| Myeloperoxidase                 | MPO          |
| Programmed cell death protein 1 | PD_1         |
| Programmed death-ligand 1       | PD_L1        |
| phospho-Rb \[S807/S811\]        | p_Rb         |
| Smooth muscle actin             | SMA          |
| Vimentin                        | VIM          |
| Iridium 191                     | DNA1         |
| Iridium 193                     | DNA2         |

‘full_name’ and ‘short_name’ examples for some commonly used markers

In addition, `rownames(sce)` should be set as `rowData(sce)$short_name`.

#### assays

The `assays` slot of the `SingleCellExperiment` contains counts matrices
representing marker expression levels per cell and channel.

It should at least contain a `counts` matrix with raw ion counts. The
`assays` slot can also contain additional matrices with commonly used
counts transformations, or counts transformations that were used in the
publication that describes the dataset. All counts transformations must
be documented in the `.R` function used to load the dataset. Common
examples include:

- `exprs`: asinh-transformed counts. For IMC, a cofactor of 1 is
  typically used.
- `quant_norm`: counts censored (e.g., at the 99th percentile) and
  scaled from 0 to 1.

#### colPairs

Neighborhood information, such as a list of cells that are localized
next to each other, can be stored as a
[SelfHits](https://bioconductor.org/packages/devel/bioc/vignettes/SingleCellExperiment/inst/doc/intro.html#6_Storing_row_or_column_pairings)
object in the `colPair` slot of the `SingleCellExperiment` object.

### Images and masks

#### Images

Multichannel images are stored in a
[CytoImageList](https://bioconductor.org/packages/CytoImageList) object
named `images`.

Channel names of the `images` object (`channelNames(images)`) must map
to `rownames(sce)` (marker short names).

The metadata slot (`mcols(images)`) must contain an `image_name` column
that maps to the `image_name` column of `colData(sce)`, and to the
`image_name` column of `mcols(masks)`. This information is used by
[cytomapper](https://bioconductor.org/packages/cytomapper) to associate
multichannel images, cell segmentation masks, and single cell data.

#### Masks

Cell segmentation masks are stored in a
[CytoImageList](https://bioconductor.org/packages/CytoImageList) object
named `masks`.

The values of the masks should be integers mapping to the `cell_number`
column of `colData(sce)`. This information is used by
[cytomapper](https://bioconductor.org/packages/cytomapper) to associate
single cell data and cell segmentation masks.

The metadata slot (`mcols(masks)`) must contain an `image_name` column
that maps to the `image_name` column of `colData(sce)`, and to the
`image_name` column of `mcols(images)`. This information is used by
[cytomapper](https://bioconductor.org/packages/cytomapper) to associate
multichannel images, cell segmentation masks, and single cell data.

## **Session info**

    ## R version 4.6.1 (2026-06-24)
    ## Platform: x86_64-pc-linux-gnu
    ## Running under: Ubuntu 24.04.4 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.12.0 
    ## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
    ##  [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
    ##  [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
    ## [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
    ## 
    ## time zone: Etc/UTC
    ## tzcode source: system (glibc)
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices datasets  utils     methods   base     
    ## 
    ## other attached packages:
    ## [1] BiocStyle_2.41.0
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] digest_0.6.39       desc_1.4.3          R6_2.6.1           
    ##  [4] bookdown_0.47       fastmap_1.2.0       xfun_0.59          
    ##  [7] cachem_1.1.0        knitr_1.51          htmltools_0.5.9    
    ## [10] rmarkdown_2.31      lifecycle_1.0.5     cli_3.6.6          
    ## [13] sass_0.4.10         pkgdown_2.2.0       textshaping_1.0.5  
    ## [16] jquerylib_0.1.4     renv_1.2.3          systemfonts_1.3.2  
    ## [19] compiler_4.6.1      tools_4.6.1         ragg_1.5.2         
    ## [22] bslib_0.11.0        evaluate_1.0.5      yaml_2.3.12        
    ## [25] otel_0.2.0          BiocManager_1.30.27 jsonlite_2.0.0     
    ## [28] htmlwidgets_1.6.4   rlang_1.2.0         fs_2.1.0
