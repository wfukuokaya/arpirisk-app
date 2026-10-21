# ARPI treatment effect calculator

Web calculator for the risk model and treatment effects in the [arpirisk](https://github.com/wfukuokaya/arpirisk) R package: for a patient with metastatic hormone-sensitive prostate cancer, it shows the 4-year risk of death with androgen deprivation therapy (ADT) alone and with an androgen receptor pathway inhibitor (ARPI) plus ADT, and how the effect of adding an ARPI changes with baseline risk.

Live: <https://arpi-treatment-effect-estimator.pages.dev/>

For research and education; not a medical device.

The calculator is a Shiny app exported as a static [Shinylive](https://posit-dev.github.io/r-shinylive/) site, so it runs entirely in the browser: entered values never leave the device, and the site needs no server.

## Package version

The model and all calculations come from arpirisk. `PACKAGE_REF` pins the package commit the calculator is built and tested with; the footer of the calculator shows the model version. To move to a new package version, update `PACKAGE_REF`, run the tests, and publish a release.

## Repository layout

| Path | Contents |
|---|---|
| `app/app.R` | Runs the calculator locally with the installed package |
| `app/R/` | User interface, server, styles, and helpers |
| `tools/build_shinylive.R` | Builds the static site from the app and the pinned package source |
| `tools/loading/` | Loading screen with a download progress bar, inserted by the build |
| `_brand.yml`, `tools/build_theme.R` | Colors and fonts, converted into `app/R/app_theme.R` |
| `gradients/`, `tools/build_gradients.R` | Header artwork, inlined into `app/R/app_gradients.R` |
| `tests/` | Tests of the app against the installed package |
| `.github/workflows/` | Tests on every push; deployment to Cloudflare Pages on release |

## Development

Install the package at the pinned commit, then run the app or its tests from the repository root:

```r
pak::pak(paste0("wfukuokaya/arpirisk@", readLines("PACKAGE_REF")[[1]]))
shiny::runApp("app")
testthat::test_dir("tests/testthat")
```

To build the static site, check out the package at the pinned commit next to this repository (`../arpirisk`, or give its path), then:

```sh
Rscript tools/build_shinylive.R _site ../arpirisk
```

The build stops if the package checkout is not at the pinned commit.

Check changes in Safari or another WebKit browser as well as in Chrome: iPhone browsers give R in WebAssembly a smaller stack, and the app relies on keeping its call stacks shallow.

## License

MIT
