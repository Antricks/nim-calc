# Package

version       = "0.1.0"
author        = "Antricks"
description   = "A calculator exporting a function to evaluate basic mathematical terms"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.0"


# Tasks

task docgen, "Generate HTML documentation":
    exec "cd src; nim doc -o:../doc/nimCalc.html nimCalc"

task runCalc, "Run calculator":
    exec "nim r src/nimCalc.nim"