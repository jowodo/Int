#!/bin/bash

basename=thesis
pdflatex $basename.tex
bibtex $basename.aux
makeglossaries $basename
