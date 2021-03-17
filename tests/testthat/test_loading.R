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
  sce <- DamondPancreas2019Data(data_type = "sce")
  images <- DamondPancreas2019Data(data_type = "images")
  masks <- DamondPancreas2019Data(data_type = "masks")
    
  check_sce(sce)
  check_images(images)
  check_masks(masks)
  check_intersect(sce,
                  images,
                  masks)
  
  # Fail
  expect_error(
    DamondPancreas2019Data(data_type = "test"), 
    regexp = 'The data_type argument should be "sce", "images" or "masks".'
  )
  expect_error(
    DamondPancreas2019Data(data_type = c("sce", "images")), 
    regexp = 'The data_type argument should be of length 1.'
  )
})

test_that("JacksonFischer2020Data works", {
  sce <- JacksonFischer2020Data(data_type = "sce")
  images <- JacksonFischer2020Data(data_type = "images")
  masks <- JacksonFischer2020Data(data_type = "masks")
  
  check_sce(sce)
  check_images(images)
  check_masks(masks)
  check_intersect(sce,
                  images,
                  masks)
  
  # Fail
  expect_error(
    JacksonFischer2020Data(data_type = "test"), 
    regexp = 'The data_type argument should be "sce", "images" or "masks".'
  )
  expect_error(
    JacksonFischer2020Data(data_type = c("sce", "images")), 
    regexp = 'The data_type argument should be of length 1.'
  )
})
