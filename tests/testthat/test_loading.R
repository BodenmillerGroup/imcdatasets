# Checking all the getter functions.

check_sce <- function(sce) {
    expect_true(all(dim(sce) > 0))
    expect_true(length(assayNames(sce)) > 0)
}

check_images <- function(img) {
    expect_true(all(channelNames(img) > 0))
    expect_true(length(img) > 0)
}

check_masks <- function(msk) {
    expect_true(length(msk) > 0)
}

check_intersect <- function(sce, img, msk) {
    mappingcols <- Reduce(intersect, list(colnames(colData(sce)),
                                            colnames(mcols(img)),
                                            colnames(mcols(msk))))
    expect_true(length(mappingcols) > 0)
}

datasets <- list(
<<<<<<< HEAD
    "DamondPancreas2019Data",
    "JacksonFischer2020Data",
    "ZanotelliSpheroids2020Data",
    "IMMUcanExample2022"
=======
    "Damond_2019_Pancreas",
    "JacksonFischer_2020_BreastCancer",
    "Zanotelli_2020_Spheroids"
>>>>>>> master
)

testDatasetWorks <- function(x) {
    test_that(paste(x, "works"), {
        sce <- do.call(x, args = list(data_type = "sce"))
        images <- do.call(x, args = list(data_type = "images"))
        masks <- do.call(x, args = list(data_type = "masks"))
        
        check_sce(sce)
        check_images(images)
        check_masks(masks)
        check_intersect(sce, images, masks)
        
        # On disk storage works
        cur_path <- tempdir()
        on.exit(unlink(cur_path))
        
        # Fail
        expect_error(
          do.call(x, args = list(data_type = "test")),
          regexp = 'The data_type argument should be "sce", "images" or "masks".'
        )
        expect_error(
          do.call(x, args = list(data_type = c("sce", "images"))),
          regexp = 'The data_type argument should be of length 1.'
        )
        expect_error(
          do.call(x, args = list(data_type = "sce", metadata = NA)),
          regexp = '"metadata" should be either TRUE or FALSE'
        )
        expect_error(do.call(x, args = list(metadata = TRUE)))
        expect_error(do.call(x, args = list(data_type = "masks",
                                            on_disk = TRUE)))
    }
)}

lapply(datasets, testDatasetWorks)