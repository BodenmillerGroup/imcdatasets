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

test_that("DamondPancreas2019Data works", {
  check_sce(DamondPancreas2019Data(data_type = "sce"))
  check_images(DamondPancreas2019Data(data_type = "images"))
  check_masks(DamondPancreas2019Data(data_type = "masks"))
  check_intersect(DamondPancreas2019Data(data_type = "sce"),
                  DamondPancreas2019Data(data_type = "images"),
                  DamondPancreas2019Data(data_type = "masks"))
})