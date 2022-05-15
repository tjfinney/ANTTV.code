test_that("read_dist_matrix() reads a distance matrix", {
  dm <- read_dist_matrix("https://zenodo.org/record/6505843/files/Acts.UBS2.dist.csv")
  diag.zero <- vector(mode="numeric", length=dim(dm)[1])
  expect_equal(dm, Acts.UBS2.dist)
  expect_equal(as.vector(diag(dm)), diag.zero)
  expect_equal(rownames(dm), colnames(dm))
})
