CHAPTERS=$(wildcard chapters/*.tex)
DOC=memoria.pdf
BIB=bibtex
TEX=pdflatex
META=$(wildcard meta/*.tex)

all: $(DOC)

clean:
	rm -f *.pdf *.aux *.toc *.tmp

memoria.pdf: $(basename $(DOC)).tex $(CHAPTERS) classicthesis-config.tex $(basename $(DOC)).bbl $(META)
	$(BIB) $(basename $(DOC))
	$(TEX) $<
	$(TEX) $<

%.bbl: %.bib $(basename $(DOC)).aux
	$(TEX) $(basename $(DOC)).tex -shell-escape

%.aux: %.tex
	$(TEX) $< -shell-escape
