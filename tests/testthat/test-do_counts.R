test_that("do_counts() is correct for a piece of Mark.UBS4", {
  piece <- Mark.UBS4[c(1, 5, 13, 60), 1:10]
  expected <- matrix(c(10,9,3,3, 9,9,2,3, 3,2,3,1, 3,3,1,3), nrow = 4, ncol=4, byrow = TRUE, dimnames = list(c("UBS", "Aleph", "C", "28-c"), c("UBS", "Aleph", "C", "28-c")))
  expect_equal(do_counts(piece), expected)
})
