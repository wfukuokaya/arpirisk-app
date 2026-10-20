# Runs the app's tests: Rscript tests/testthat.R from the repository root.
testthat::test_dir(file.path("tests", "testthat"), stop_on_failure = TRUE)
