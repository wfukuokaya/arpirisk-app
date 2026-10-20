# Runs the calculator locally with the installed mhspcarpi package:
#   shiny::runApp("app")
# Shiny sources the files in app/R/ before this file. The Shinylive site is
# built by tools/build_shinylive.R instead.
library(shiny)
library(mhspcarpi)
mhspc_app()
