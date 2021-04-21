#!/bin/bash

basename=article
pdflatex $basename.tex
bibtex $basename.aux
makeglossaries $basename
