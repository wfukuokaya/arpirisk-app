# The app code runs against the installed arpirisk package, as in app/app.R.
library(arpirisk)
purrr::walk(
  list.files(test_path("..", "..", "app", "R"), pattern = "[.]R$", full.names = TRUE),
  source
)

example_patient <- function(...) {
  values <- list(
    ecog_ps = 0, gleason_score = 9, visceral_metastasis = 0,
    bone_metastases = 8, psa = 45, hemoglobin = 128, albumin = 41,
    alp = 180, ldh = 210
  )
  overrides <- list(...)
  values[names(overrides)] <- overrides
  as.data.frame(values)
}
