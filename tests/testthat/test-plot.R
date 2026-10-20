draw_test_plot <- function(scale, patients = data.frame(risk_percent = 60, estimate = NA), ...) {
  model <- mhspc_model()
  curve <- effect_curve(model, scale)
  if (is.na(patients$estimate[[1L]])) {
    patients$estimate <- stats::approx(curve$risk_percent, curve$estimate, patients$risk_percent)$y
  }
  graphics::par(effect_plot_par())
  draw_effect_plot(curve, scale, patients = patients, overall = overall_effect(model, scale), ...)
}

test_that("the effect plot draws every scale with the x axis from 0% to 100%", {
  grDevices::pdf(NULL, width = 6, height = 4)
  on.exit(grDevices::dev.off(), add = TRUE)
  purrr::walk(c("ard", "rmst", "hr"), function(scale) {
    expect_invisible(draw_test_plot(scale, show_prediction_interval = TRUE))
    expect_equal(graphics::par("usr")[1:2], c(0, 100))
  })
  expect_invisible(draw_test_plot("ard", patients = data.frame(risk_percent = c(20, 90), estimate = c(0, 12))))
})

test_that("the ARD curve is shown per 100 patients", {
  model <- mhspc_model()
  curve <- effect_curve(model, "ard")
  expect_equal(curve$estimate, 100 * model$treatment_effects$curves$ard$estimate)
  expect_equal(overall_effect(model, "ard"), 100 * model$treatment_effects$overall$ard$estimate)
  expect_equal(range(curve$risk_percent), 100 * effect_risk_range(model))
})

test_that("hazard ratio ticks stay within the limits", {
  expect_equal(hr_ticks(c(0.45, 0.95)), c(0.5, 0.6, 0.7, 0.8, 0.9))
  expect_equal(hr_ticks(c(0.2, 2)), c(0.2, 0.4, 0.6, 0.8, 1, 1.5))
})

test_that("axis titles shrink to fit narrow plots", {
  grDevices::pdf(NULL, width = 3, height = 3)
  on.exit(grDevices::dev.off(), add = TRUE)
  graphics::plot.new()
  label <- "4-year risk of death with ADT alone"
  expect_equal(label_cex(label, width_inches = 10), 0.95)
  narrow <- label_cex(label, width_inches = 1.5)
  expect_lt(narrow, 0.95)
  expect_lte(graphics::strwidth(label, units = "inches", cex = narrow), 1.5 + 1e-8)
})

test_that("percent ticks widen their spacing on narrow plots", {
  grDevices::pdf(NULL)
  on.exit(grDevices::dev.off())
  graphics::plot.new()
  expect_equal(percent_ticks(6), seq(0, 100, by = 20))
  expect_equal(percent_ticks(1.6), seq(0, 100, by = 50))
  expect_equal(percent_ticks(0.1), c(0, 50, 100))
})
