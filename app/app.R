# Runs the calculator locally with the installed arpirisk package; from the
# repository root, call `shiny::runApp("app")`.
# Shiny sources the files in app/R/ before this file. The Shinylive site is
# built by tools/build_shinylive.R instead.
library(shiny)
library(arpirisk)
mhspc_app()
