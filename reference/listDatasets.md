# List all available datasets

Summary information for all available datasets in the imcdatasets
package.

## Usage

``` r
listDatasets()
```

## Value

A DataFrame where each row corresponds to a dataset, containing the
fields:

- `FunctionCall`, the R function call required to construct the dataset.

- `Species`, species of origin.

- `Tissue`, the tissue that was imaged.

- `NumberOfCells`, the total number of cells in the dataset.

- `NumberOfImages`, the total number of images in the dataset.

- `NumberOfChannels`, the number of channels per image.

- `Reference`, a Markdown-formatted citation to `scripts/ref.bib` in the
  imcdatasets installation directory.

## Details

Each dataset contains single-cell data, multichannel images and cell
segmentation masks.

## Examples

``` r
listDatasets()
#> DataFrame with 6 rows and 7 columns
#>             FunctionCall     Species                Tissue NumberOfCells
#>              <character> <character>           <character>     <integer>
#> 1 Damond_2019_Pancreas()       Human              Pancreas        252059
#> 2 HochSchulz_2022_Mela..       Human   Metastatic melanoma        325881
#> 3 JacksonFischer_2020_..       Human Primary breast tumour        285851
#> 4 Zanotelli_2020_Spher..       Human   Cell line spheroids        229047
#> 5 IMMUcan_2022_CancerE..       Human         Primary tumor         46825
#> 6 Meyer_2025_TripleNeg..       Human  Primary breast tumor        257680
#>   NumberOfImages NumberOfChannels              Reference
#>        <integer>        <integer>            <character>
#> 1            100               38  @Damond-2019-Pancreas
#> 2             50               41 @HochSchulz-2022-Mel..
#> 3            100               42 @JacksonFischer-2020..
#> 4            517               51 @Zanotelli-2020-Sphe..
#> 5             14               40                   None
#> 6            125               39 @Meyer-2025-TripleNe..
```
