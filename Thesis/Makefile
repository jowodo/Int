basename := thesis
bibfile := int.bib
LATEX := pdflatex

all: $(bibfile) $(basename).tex
	$(LATEX)  $(basename).tex
	bibtex $(basename).aux
	makeglossaries $(basename)

clean: clear
clear: 
	rm -f $(basename).aux \
		$(basename).acn \
		$(basename).acr \
		$(basename).alg \
		$(basename).aux \
		$(basename).bbl \
		$(basename).blg \
		$(basename).glsdefs \
		$(basename).ist \
		$(basename).log \
		$(basename).out \
		$(basename).toc

